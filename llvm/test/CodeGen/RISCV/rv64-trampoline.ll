; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64 %s
; RUN: llc -mtriple=riscv64-unknown-linux-gnu -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64-LINUX %s

declare void @llvm.init.trampoline(ptr, ptr, ptr)
declare ptr @llvm.adjust.trampoline(ptr)
declare i64 @f(ptr nest, i64)

define i64 @test0(i64 %n, ptr %p) nounwind {
; RV64-LABEL: test0:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -64
; RV64-NEXT:    sd ra, 56(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 48(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s1, 40(sp) # 8-byte Folded Spill
; RV64-NEXT:    mv s0, a0
; RV64-NEXT:    lui a0, %hi(f)
; RV64-NEXT:    addi a0, a0, %lo(f)
; RV64-NEXT:    sd a0, 32(sp)
; RV64-NEXT:    li a0, 919
; RV64-NEXT:    lui a2, %hi(.LCPI0_0)
; RV64-NEXT:    ld a2, %lo(.LCPI0_0)(a2)
; RV64-NEXT:    lui a3, 6203
; RV64-NEXT:    addi a3, a3, 643
; RV64-NEXT:    sw a0, 8(sp)
; RV64-NEXT:    sw a3, 12(sp)
; RV64-NEXT:    sd a2, 16(sp)
; RV64-NEXT:    sd a1, 24(sp)
; RV64-NEXT:    addi a1, sp, 24
; RV64-NEXT:    addi a0, sp, 8
; RV64-NEXT:    addi s1, sp, 8
; RV64-NEXT:    call __clear_cache
; RV64-NEXT:    mv a0, s0
; RV64-NEXT:    jalr s1
; RV64-NEXT:    ld ra, 56(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s0, 48(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s1, 40(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 64
; RV64-NEXT:    ret
;
; RV64-LINUX-LABEL: test0:
; RV64-LINUX:       # %bb.0:
; RV64-LINUX-NEXT:    addi sp, sp, -64
; RV64-LINUX-NEXT:    sd ra, 56(sp) # 8-byte Folded Spill
; RV64-LINUX-NEXT:    sd s0, 48(sp) # 8-byte Folded Spill
; RV64-LINUX-NEXT:    sd s1, 40(sp) # 8-byte Folded Spill
; RV64-LINUX-NEXT:    mv s0, a0
; RV64-LINUX-NEXT:    lui a0, %hi(f)
; RV64-LINUX-NEXT:    addi a0, a0, %lo(f)
; RV64-LINUX-NEXT:    sd a0, 32(sp)
; RV64-LINUX-NEXT:    li a0, 919
; RV64-LINUX-NEXT:    lui a2, %hi(.LCPI0_0)
; RV64-LINUX-NEXT:    ld a2, %lo(.LCPI0_0)(a2)
; RV64-LINUX-NEXT:    lui a3, 6203
; RV64-LINUX-NEXT:    addi a3, a3, 643
; RV64-LINUX-NEXT:    sw a0, 8(sp)
; RV64-LINUX-NEXT:    sw a3, 12(sp)
; RV64-LINUX-NEXT:    sd a2, 16(sp)
; RV64-LINUX-NEXT:    sd a1, 24(sp)
; RV64-LINUX-NEXT:    addi a1, sp, 24
; RV64-LINUX-NEXT:    addi a0, sp, 8
; RV64-LINUX-NEXT:    addi s1, sp, 8
; RV64-LINUX-NEXT:    li a2, 0
; RV64-LINUX-NEXT:    call __riscv_flush_icache
; RV64-LINUX-NEXT:    mv a0, s0
; RV64-LINUX-NEXT:    jalr s1
; RV64-LINUX-NEXT:    ld ra, 56(sp) # 8-byte Folded Reload
; RV64-LINUX-NEXT:    ld s0, 48(sp) # 8-byte Folded Reload
; RV64-LINUX-NEXT:    ld s1, 40(sp) # 8-byte Folded Reload
; RV64-LINUX-NEXT:    addi sp, sp, 64
; RV64-LINUX-NEXT:    ret
  %alloca = alloca [32 x i8], align 8
  call void @llvm.init.trampoline(ptr %alloca, ptr @f, ptr %p)
  %tramp = call ptr @llvm.adjust.trampoline(ptr %alloca)
  %ret = call i64 %tramp(i64 %n)
  ret i64 %ret

}