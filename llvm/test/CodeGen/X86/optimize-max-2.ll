; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s

; LSR's OptimizeMax function shouldn't try to eliminate this max, because
; it has three operands.

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128"

define void @foo(ptr nocapture %p, i64 %x, i64 %y) nounwind {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testq %rdx, %rdx
; CHECK-NEXT:    movl $1, %eax
; CHECK-NEXT:    cmovneq %rdx, %rax
; CHECK-NEXT:    cmpq %rsi, %rax
; CHECK-NEXT:    cmovbeq %rsi, %rax
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_1: # %bb4
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; CHECK-NEXT:    addsd %xmm0, %xmm0
; CHECK-NEXT:    movsd %xmm0, (%rdi)
; CHECK-NEXT:    addq $8, %rdi
; CHECK-NEXT:    decq %rax
; CHECK-NEXT:    jne .LBB0_1
; CHECK-NEXT:  # %bb.2: # %return
; CHECK-NEXT:    retq
entry:
	%tmp = icmp eq i64 %y, 0		; <i1> [#uses=1]
	%umax = select i1 %tmp, i64 1, i64 %y		; <i64> [#uses=2]
	%tmp8 = icmp ugt i64 %umax, %x		; <i1> [#uses=1]
	%umax9 = select i1 %tmp8, i64 %umax, i64 %x		; <i64> [#uses=1]
	br label %bb4

bb4:		; preds = %bb4, %entry
	%i.07 = phi i64 [ 0, %entry ], [ %2, %bb4 ]		; <i64> [#uses=2]
	%scevgep = getelementptr double, ptr %p, i64 %i.07		; <ptr> [#uses=2]
	%0 = load double, ptr %scevgep, align 8		; <double> [#uses=1]
	%1 = fmul double %0, 2.000000e+00		; <double> [#uses=1]
	store double %1, ptr %scevgep, align 8
	%2 = add i64 %i.07, 1		; <i64> [#uses=2]
	%exitcond = icmp eq i64 %2, %umax9		; <i1> [#uses=1]
	br i1 %exitcond, label %return, label %bb4

return:		; preds = %bb4
	ret void
}
