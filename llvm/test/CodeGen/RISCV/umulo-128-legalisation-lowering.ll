; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv32 -mattr=+m | FileCheck %s --check-prefixes=RISCV32

define { i128, i8 } @muloti_test(i128 %l, i128 %r) #0 {
; RISCV32-LABEL: muloti_test:
; RISCV32:       # %bb.0: # %start
; RISCV32-NEXT:    addi sp, sp, -32
; RISCV32-NEXT:    sw s0, 28(sp) # 4-byte Folded Spill
; RISCV32-NEXT:    sw s1, 24(sp) # 4-byte Folded Spill
; RISCV32-NEXT:    sw s2, 20(sp) # 4-byte Folded Spill
; RISCV32-NEXT:    sw s3, 16(sp) # 4-byte Folded Spill
; RISCV32-NEXT:    sw s4, 12(sp) # 4-byte Folded Spill
; RISCV32-NEXT:    lw a3, 0(a1)
; RISCV32-NEXT:    lw t2, 4(a1)
; RISCV32-NEXT:    lw a4, 8(a1)
; RISCV32-NEXT:    lw a5, 12(a1)
; RISCV32-NEXT:    lw a1, 0(a2)
; RISCV32-NEXT:    lw t0, 4(a2)
; RISCV32-NEXT:    lw a6, 8(a2)
; RISCV32-NEXT:    lw a7, 12(a2)
; RISCV32-NEXT:    mulhu a2, a3, a1
; RISCV32-NEXT:    mul t1, t2, a1
; RISCV32-NEXT:    add a2, t1, a2
; RISCV32-NEXT:    sltu t1, a2, t1
; RISCV32-NEXT:    mulhu t3, t2, a1
; RISCV32-NEXT:    add t4, t3, t1
; RISCV32-NEXT:    mul t1, a3, t0
; RISCV32-NEXT:    add a2, t1, a2
; RISCV32-NEXT:    sltu t1, a2, t1
; RISCV32-NEXT:    mulhu t3, a3, t0
; RISCV32-NEXT:    add t1, t3, t1
; RISCV32-NEXT:    add t5, t4, t1
; RISCV32-NEXT:    mul t6, t2, t0
; RISCV32-NEXT:    add s0, t6, t5
; RISCV32-NEXT:    mul t1, a6, a3
; RISCV32-NEXT:    mul s3, a4, a1
; RISCV32-NEXT:    add s4, s3, t1
; RISCV32-NEXT:    add t1, s0, s4
; RISCV32-NEXT:    sltu t3, t1, s0
; RISCV32-NEXT:    sltu s0, s0, t6
; RISCV32-NEXT:    sltu t4, t5, t4
; RISCV32-NEXT:    mulhu t5, t2, t0
; RISCV32-NEXT:    add t4, t5, t4
; RISCV32-NEXT:    add s0, t4, s0
; RISCV32-NEXT:    mul t4, t2, a6
; RISCV32-NEXT:    mul t5, a7, a3
; RISCV32-NEXT:    add t4, t5, t4
; RISCV32-NEXT:    mulhu s1, a6, a3
; RISCV32-NEXT:    add s2, s1, t4
; RISCV32-NEXT:    mul t4, t0, a4
; RISCV32-NEXT:    mul t5, a5, a1
; RISCV32-NEXT:    add t4, t5, t4
; RISCV32-NEXT:    mulhu t5, a4, a1
; RISCV32-NEXT:    add t6, t5, t4
; RISCV32-NEXT:    add t4, t6, s2
; RISCV32-NEXT:    sltu s3, s4, s3
; RISCV32-NEXT:    add t4, t4, s3
; RISCV32-NEXT:    add t4, s0, t4
; RISCV32-NEXT:    add t4, t4, t3
; RISCV32-NEXT:    beq t4, s0, .LBB0_2
; RISCV32-NEXT:  # %bb.1: # %start
; RISCV32-NEXT:    sltu t3, t4, s0
; RISCV32-NEXT:  .LBB0_2: # %start
; RISCV32-NEXT:    sltu s0, s2, s1
; RISCV32-NEXT:    snez s1, t2
; RISCV32-NEXT:    snez s2, a7
; RISCV32-NEXT:    and s1, s2, s1
; RISCV32-NEXT:    mulhu s2, a7, a3
; RISCV32-NEXT:    snez s2, s2
; RISCV32-NEXT:    or s1, s1, s2
; RISCV32-NEXT:    mulhu t2, t2, a6
; RISCV32-NEXT:    snez t2, t2
; RISCV32-NEXT:    or t2, s1, t2
; RISCV32-NEXT:    or t2, t2, s0
; RISCV32-NEXT:    sltu t5, t6, t5
; RISCV32-NEXT:    snez t6, t0
; RISCV32-NEXT:    snez s0, a5
; RISCV32-NEXT:    and t6, s0, t6
; RISCV32-NEXT:    mulhu s0, a5, a1
; RISCV32-NEXT:    snez s0, s0
; RISCV32-NEXT:    or t6, t6, s0
; RISCV32-NEXT:    mulhu t0, t0, a4
; RISCV32-NEXT:    snez t0, t0
; RISCV32-NEXT:    or t0, t6, t0
; RISCV32-NEXT:    or t0, t0, t5
; RISCV32-NEXT:    or a6, a6, a7
; RISCV32-NEXT:    snez a6, a6
; RISCV32-NEXT:    or a4, a4, a5
; RISCV32-NEXT:    snez a4, a4
; RISCV32-NEXT:    and a4, a4, a6
; RISCV32-NEXT:    or a4, a4, t0
; RISCV32-NEXT:    or a4, a4, t2
; RISCV32-NEXT:    or a4, a4, t3
; RISCV32-NEXT:    mul a1, a3, a1
; RISCV32-NEXT:    andi a4, a4, 1
; RISCV32-NEXT:    sw a1, 0(a0)
; RISCV32-NEXT:    sw a2, 4(a0)
; RISCV32-NEXT:    sw t1, 8(a0)
; RISCV32-NEXT:    sw t4, 12(a0)
; RISCV32-NEXT:    sb a4, 16(a0)
; RISCV32-NEXT:    lw s0, 28(sp) # 4-byte Folded Reload
; RISCV32-NEXT:    lw s1, 24(sp) # 4-byte Folded Reload
; RISCV32-NEXT:    lw s2, 20(sp) # 4-byte Folded Reload
; RISCV32-NEXT:    lw s3, 16(sp) # 4-byte Folded Reload
; RISCV32-NEXT:    lw s4, 12(sp) # 4-byte Folded Reload
; RISCV32-NEXT:    addi sp, sp, 32
; RISCV32-NEXT:    ret
start:
  %0 = tail call { i128, i1 } @llvm.umul.with.overflow.i128(i128 %l, i128 %r) #2
  %1 = extractvalue { i128, i1 } %0, 0
  %2 = extractvalue { i128, i1 } %0, 1
  %3 = zext i1 %2 to i8
  %4 = insertvalue { i128, i8 } undef, i128 %1, 0
  %5 = insertvalue { i128, i8 } %4, i8 %3, 1
  ret { i128, i8 } %5
}

; Function Attrs: nounwind readnone speculatable
declare { i128, i1 } @llvm.umul.with.overflow.i128(i128, i128) #1

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind }