! RUN: %flang_fc1 -fopenmp -emit-llvm %s -o - | FileCheck %s

! Combinational testing of control flow graph and builder insertion points
! in mlir-to-llvm conversion:
!   - mixing multiple delayed privatizations and multiple reductions
!   - multiple blocks in the private alloc region
!   - private alloc region has to read from the mold variable
!   - firstprivate
!   - multiple blocks in the private copy region
!   - multiple blocks in the reduction init region
!   - reduction init region has to read from the mold variable
!   - re-used omp.private ops
!   - re-used omp.reduction.declare ops
!   - unstructured code inside of the parallel region
!   - needs private dealloc region, and this has multiple blocks
!   - needs reduction cleanup region, and this has multiple blocks

! This maybe belongs in the mlir tests, but what we are doing here is complex
! enough that I find the kind of minimised mlir code preferred by mlir reviewers
! hard to read without some fortran here for reference. Nothing like this would
! be generated by other upstream users of the MLIR OpenMP dialect.

subroutine worst_case(a, b, c, d)
  real, allocatable :: a(:), b(:), c(:), d(:)
  integer i

  !$omp parallel firstprivate(a,b) reduction(+:c,d)
  if (sum(a) == 1) stop 1
  !$omp end parallel
end subroutine

! CHECK-LABEL: define internal void @worst_case_..omp_par
! CHECK-NEXT:  omp.par.entry:
!                [reduction alloc regions inlined here]
! CHECK:         br label %omp.private.latealloc

! CHECK:       omp.private.latealloc:                            ; preds = %omp.par.entry
! CHECK-NEXT:  br label %omp.private.alloc5

! CHECK:       omp.private.alloc5:                               ; preds = %omp.private.latealloc
!                [begin private alloc for first var]
!                [read the length from the mold argument]
!                [if it is non-zero...]
! CHECK:         br i1 {{.*}}, label %omp.private.alloc6, label %omp.private.alloc7

! CHECK:       omp.private.alloc7:                               ; preds = %omp.private.alloc5
!                [finish private alloc for first var with zero extent]
! CHECK:         br label %omp.private.alloc8

! CHECK:       omp.private.alloc8:                               ; preds = %omp.private.alloc6, %omp.private.alloc7
! CHECK-NEXT:    br label %omp.region.cont4

! CHECK:       omp.region.cont4:                                 ; preds = %omp.private.alloc8
! CHECK-NEXT:    %{{.*}} = phi ptr
! CHECK-NEXT:    br label %omp.private.alloc

! CHECK:       omp.private.alloc:                                ; preds = %omp.region.cont4
!                [begin private alloc for first var]
!                [read the length from the mold argument]
!                [if it is non-zero...]
! CHECK:         br i1 %{{.*}}, label %omp.private.alloc1, label %omp.private.alloc2

! CHECK:       omp.private.alloc2:                               ; preds = %omp.private.alloc
!                [finish private alloc for second var with zero extent]
! CHECK:         br label %omp.private.alloc3

! CHECK:       omp.private.alloc3:                               ; preds = %omp.private.alloc1, %omp.private.alloc2
! CHECK-NEXT:    br label %omp.region.cont

! CHECK:       omp.region.cont:                                  ; preds = %omp.private.alloc3
! CHECK-NEXT:    %{{.*}} = phi ptr
! CHECK-NEXT:    br label %omp.private.copy

! CHECK:       omp.private.copy:                                 ; preds = %omp.region.cont
! CHECK-NEXT:    br label %omp.private.copy10

! CHECK:       omp.private.copy10:                               ; preds = %omp.private.copy
!                [begin firstprivate copy for first var]
!                [read the length, is it non-zero?]
! CHECK:         br i1 %{{.*}}, label %omp.private.copy11, label %omp.private.copy12

! CHECK:       omp.private.copy12:                               ; preds = %omp.private.copy11, %omp.private.copy10
! CHECK-NEXT:    br label %omp.region.cont9

! CHECK:       omp.region.cont9:                                 ; preds = %omp.private.copy12
! CHECK-NEXT:    %{{.*}} = phi ptr
! CHECK-NEXT:    br label %omp.private.copy14

! CHECK:       omp.private.copy14:                               ; preds = %omp.region.cont9
!                [begin firstprivate copy for second var]
!                [read the length, is it non-zero?]
! CHECK:         br i1 %{{.*}}, label %omp.private.copy15, label %omp.private.copy16

! CHECK:       omp.private.copy16:                               ; preds = %omp.private.copy15, %omp.private.copy14
! CHECK-NEXT:    br label %omp.region.cont13

! CHECK:       omp.region.cont13:                                ; preds = %omp.private.copy16
! CHECK-NEXT:    %{{.*}} = phi ptr
! CHECK-NEXT:    br label %omp.reduction.init

! CHECK:       omp.reduction.init:                               ; preds = %omp.region.cont13
!                [deffered stores for results of reduction alloc regions]
! CHECK:         br label %[[VAL_96:.*]]

! CHECK:       omp.reduction.neutral:                            ; preds = %omp.reduction.init
!                [start of reduction initialization region]
!                [null check:]
! CHECK:         br i1 %{{.*}}, label %omp.reduction.neutral18, label %omp.reduction.neutral19

! CHECK:       omp.reduction.neutral19:                          ; preds = %omp.reduction.neutral
!                [malloc and assign the default value to the reduction variable]
! CHECK:         br label %omp.reduction.neutral20

! CHECK:       omp.reduction.neutral20:                          ; preds = %omp.reduction.neutral18, %omp.reduction.neutral19
! CHECK-NEXT:    br label %omp.region.cont17

! CHECK:       omp.region.cont17:                                ; preds = %omp.reduction.neutral20
! CHECK-NEXT:    %{{.*}} = phi ptr
! CHECK-NEXT:    br label %omp.reduction.neutral22

! CHECK:       omp.reduction.neutral22:                          ; preds = %omp.region.cont17
!                [start of reduction initialization region]
!                [null check:]
! CHECK:         br i1 %{{.*}}, label %omp.reduction.neutral23, label %omp.reduction.neutral24

! CHECK:       omp.reduction.neutral24:                          ; preds = %omp.reduction.neutral22
!                [malloc and assign the default value to the reduction variable]
! CHECK:         br label %omp.reduction.neutral25

! CHECK:       omp.reduction.neutral25:                          ; preds = %omp.reduction.neutral23, %omp.reduction.neutral24
! CHECK-NEXT:    br label %omp.region.cont21

! CHECK:       omp.region.cont21:                                ; preds = %omp.reduction.neutral25
! CHECK-NEXT:    %{{.*}} = phi ptr
! CHECK-NEXT:    br label %omp.par.region

! CHECK:       omp.par.region:                                   ; preds = %omp.region.cont21
! CHECK-NEXT:    br label %omp.par.region27

! CHECK:       omp.par.region27:                                 ; preds = %omp.par.region
!                [call SUM runtime function]
!                [if (sum(a) == 1)]
! CHECK:         br i1 %{{.*}}, label %omp.par.region28, label %omp.par.region29

! CHECK:       omp.par.region29:                                 ; preds = %omp.par.region27
! CHECK-NEXT:    br label %omp.region.cont26

! CHECK:       omp.region.cont26:                                ; preds = %omp.par.region28, %omp.par.region29
!                [omp parallel region done, call into the runtime to complete reduction]
! CHECK:         %[[VAL_233:.*]] = call i32 @__kmpc_reduce(
! CHECK:         switch i32 %[[VAL_233]], label %reduce.finalize [
! CHECK-NEXT:      i32 1, label %reduce.switch.nonatomic
! CHECK-NEXT:      i32 2, label %reduce.switch.atomic
! CHECK-NEXT:    ]

! CHECK:       reduce.switch.atomic:                             ; preds = %omp.region.cont26
! CHECK-NEXT:    unreachable

! CHECK:       reduce.switch.nonatomic:                          ; preds = %omp.region.cont26
! CHECK-NEXT:    %[[red_private_value_0:.*]] = load ptr, ptr %{{.*}}, align 8
! CHECK-NEXT:    br label %omp.reduction.nonatomic.body

!              [various blocks implementing the reduction]

! CHECK:       omp.region.cont35:                                ; preds =
! CHECK-NEXT:    %{{.*}} = phi ptr
! CHECK-NEXT:    call void @__kmpc_end_reduce(
! CHECK-NEXT:    br label %reduce.finalize

! CHECK:       reduce.finalize:                                  ; preds =
! CHECK-NEXT:    br label %omp.par.pre_finalize

! CHECK:       omp.par.pre_finalize:                             ; preds = %reduce.finalize
! CHECK-NEXT:    %{{.*}} = load ptr, ptr
! CHECK-NEXT:    br label %omp.reduction.cleanup

! CHECK:       omp.reduction.cleanup:                            ; preds = %omp.par.pre_finalize
!                [null check]
! CHECK:         br i1 %{{.*}}, label %omp.reduction.cleanup41, label %omp.reduction.cleanup42

! CHECK:       omp.reduction.cleanup42:                          ; preds = %omp.reduction.cleanup41, %omp.reduction.cleanup
! CHECK-NEXT:    br label %omp.region.cont40

! CHECK:       omp.region.cont40:                                ; preds = %omp.reduction.cleanup42
! CHECK-NEXT:    %{{.*}} = load ptr, ptr
! CHECK-NEXT:    br label %omp.reduction.cleanup44

! CHECK:       omp.reduction.cleanup44:                          ; preds = %omp.region.cont40
!                [null check]
! CHECK:         br i1 %{{.*}}, label %omp.reduction.cleanup45, label %omp.reduction.cleanup46

! CHECK:       omp.reduction.cleanup46:                          ; preds = %omp.reduction.cleanup45, %omp.reduction.cleanup44
! CHECK-NEXT:    br label %omp.region.cont43

! CHECK:       omp.region.cont43:                                ; preds = %omp.reduction.cleanup46
! CHECK-NEXT:    br label %omp.private.dealloc

! CHECK:       omp.private.dealloc:                              ; preds = %omp.region.cont43
!                [null check]
! CHECK:         br i1 %{{.*}}, label %omp.private.dealloc48, label %omp.private.dealloc49

! CHECK:       omp.private.dealloc49:                            ; preds = %omp.private.dealloc48, %omp.private.dealloc
! CHECK-NEXT:    br label %omp.region.cont47

! CHECK:       omp.region.cont47:                                ; preds = %omp.private.dealloc49
! CHECK-NEXT:    br label %omp.private.dealloc51

! CHECK:       omp.private.dealloc51:                            ; preds = %omp.region.cont47
!                [null check]
! CHECK:         br i1 %{{.*}}, label %omp.private.dealloc52, label %omp.private.dealloc53

! CHECK:       omp.private.dealloc53:                            ; preds = %omp.private.dealloc52, %omp.private.dealloc51
! CHECK-NEXT:    br label %omp.region.cont50

! CHECK:       omp.region.cont50:                                ; preds = %omp.private.dealloc53
! CHECK-NEXT:    br label %omp.par.outlined.exit.exitStub

! CHECK:       omp.private.dealloc52:                            ; preds = %omp.private.dealloc51
!                [dealloc memory]
! CHECK:         br label %omp.private.dealloc53

! CHECK:       omp.private.dealloc48:                            ; preds = %omp.private.dealloc
!                [dealloc memory]
! CHECK:         br label %omp.private.dealloc49

! CHECK:       omp.reduction.cleanup45:                          ; preds = %omp.reduction.cleanup44
! CHECK-NEXT:    call void @free(
! CHECK-NEXT:    br label %omp.reduction.cleanup46

! CHECK:       omp.reduction.cleanup41:                          ; preds = %omp.reduction.cleanup
! CHECK-NEXT:    call void @free(
! CHECK-NEXT:    br label %omp.reduction.cleanup42

! CHECK:       omp.par.region28:                                 ; preds = %omp.par.region27
! CHECK-NEXT:    call {} @_FortranAStopStatement

! CHECK:       omp.reduction.neutral23:                          ; preds = %omp.reduction.neutral22
!                [source length was zero: finish initializing array]
! CHECK:         br label %omp.reduction.neutral25

! CHECK:       omp.reduction.neutral18:                          ; preds = %omp.reduction.neutral
!                [source length was zero: finish initializing array]
! CHECK:         br label %omp.reduction.neutral20

! CHECK:       omp.private.copy15:                               ; preds = %omp.private.copy14
!                [source length was non-zero: call assign runtime]
! CHECK:         br label %omp.private.copy16

! CHECK:       omp.private.copy11:                               ; preds = %omp.private.copy10
!                [source length was non-zero: call assign runtime]
! CHECK:         br label %omp.private.copy12

! CHECK:       omp.private.alloc1:                               ; preds = %omp.private.alloc
!                [var extent was non-zero: malloc a private array]
! CHECK:         br label %omp.private.alloc3

! CHECK:       omp.private.alloc6:                               ; preds = %omp.private.alloc5
!                [var extent was non-zero: malloc a private array]
! CHECK:         br label %omp.private.alloc8

! CHECK:       omp.par.outlined.exit.exitStub:                   ; preds = %omp.region.cont50
! CHECK-NEXT:    ret void