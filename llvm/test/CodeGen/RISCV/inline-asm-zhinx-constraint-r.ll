; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=riscv32 -mattr=+zhinx -verify-machineinstrs < %s \
; RUN:   -target-abi=ilp32 | FileCheck -check-prefix=RV32ZHINX %s
; RUN: llc -mtriple=riscv64 -mattr=+zhinx -verify-machineinstrs < %s \
; RUN:   -target-abi=lp64 | FileCheck -check-prefix=RV64ZHINX %s
; RUN: llc -mtriple=riscv32 -mattr=+zdinx,+zhinx -verify-machineinstrs < %s \
; RUN:   -target-abi=ilp32 | FileCheck -check-prefix=RV32DINXZHINX %s
; RUN: llc -mtriple=riscv64 -mattr=+zdinx,+zhinx -verify-machineinstrs < %s \
; RUN:   -target-abi=lp64 | FileCheck -check-prefix=RV64DINXZHINX %s

@gh = external global half

define half @constraint_r_half(half %a) nounwind {
; RV32ZHINX-LABEL: constraint_r_half:
; RV32ZHINX:       # %bb.0:
; RV32ZHINX-NEXT:    lui a1, %hi(gh)
; RV32ZHINX-NEXT:    lh a1, %lo(gh)(a1)
; RV32ZHINX-NEXT:    #APP
; RV32ZHINX-NEXT:    fadd.h a0, a0, a1
; RV32ZHINX-NEXT:    #NO_APP
; RV32ZHINX-NEXT:    ret
;
; RV64ZHINX-LABEL: constraint_r_half:
; RV64ZHINX:       # %bb.0:
; RV64ZHINX-NEXT:    lui a1, %hi(gh)
; RV64ZHINX-NEXT:    lh a1, %lo(gh)(a1)
; RV64ZHINX-NEXT:    #APP
; RV64ZHINX-NEXT:    fadd.h a0, a0, a1
; RV64ZHINX-NEXT:    #NO_APP
; RV64ZHINX-NEXT:    ret
;
; RV32DINXZHINX-LABEL: constraint_r_half:
; RV32DINXZHINX:       # %bb.0:
; RV32DINXZHINX-NEXT:    lui a1, %hi(gh)
; RV32DINXZHINX-NEXT:    lh a1, %lo(gh)(a1)
; RV32DINXZHINX-NEXT:    #APP
; RV32DINXZHINX-NEXT:    fadd.h a0, a0, a1
; RV32DINXZHINX-NEXT:    #NO_APP
; RV32DINXZHINX-NEXT:    ret
;
; RV64DINXZHINX-LABEL: constraint_r_half:
; RV64DINXZHINX:       # %bb.0:
; RV64DINXZHINX-NEXT:    lui a1, %hi(gh)
; RV64DINXZHINX-NEXT:    lh a1, %lo(gh)(a1)
; RV64DINXZHINX-NEXT:    #APP
; RV64DINXZHINX-NEXT:    fadd.h a0, a0, a1
; RV64DINXZHINX-NEXT:    #NO_APP
; RV64DINXZHINX-NEXT:    ret
  %1 = load half, ptr @gh
  %2 = tail call half asm "fadd.h $0, $1, $2", "=r,r,r"(half %a, half %1)
  ret half %2
}

define half @constraint_cr_half(half %a) nounwind {
; RV32ZHINX-LABEL: constraint_cr_half:
; RV32ZHINX:       # %bb.0:
; RV32ZHINX-NEXT:    lui a1, %hi(gh)
; RV32ZHINX-NEXT:    lh a1, %lo(gh)(a1)
; RV32ZHINX-NEXT:    #APP
; RV32ZHINX-NEXT:    fadd.h a0, a0, a1
; RV32ZHINX-NEXT:    #NO_APP
; RV32ZHINX-NEXT:    ret
;
; RV64ZHINX-LABEL: constraint_cr_half:
; RV64ZHINX:       # %bb.0:
; RV64ZHINX-NEXT:    lui a1, %hi(gh)
; RV64ZHINX-NEXT:    lh a1, %lo(gh)(a1)
; RV64ZHINX-NEXT:    #APP
; RV64ZHINX-NEXT:    fadd.h a0, a0, a1
; RV64ZHINX-NEXT:    #NO_APP
; RV64ZHINX-NEXT:    ret
;
; RV32DINXZHINX-LABEL: constraint_cr_half:
; RV32DINXZHINX:       # %bb.0:
; RV32DINXZHINX-NEXT:    lui a1, %hi(gh)
; RV32DINXZHINX-NEXT:    lh a1, %lo(gh)(a1)
; RV32DINXZHINX-NEXT:    #APP
; RV32DINXZHINX-NEXT:    fadd.h a0, a0, a1
; RV32DINXZHINX-NEXT:    #NO_APP
; RV32DINXZHINX-NEXT:    ret
;
; RV64DINXZHINX-LABEL: constraint_cr_half:
; RV64DINXZHINX:       # %bb.0:
; RV64DINXZHINX-NEXT:    lui a1, %hi(gh)
; RV64DINXZHINX-NEXT:    lh a1, %lo(gh)(a1)
; RV64DINXZHINX-NEXT:    #APP
; RV64DINXZHINX-NEXT:    fadd.h a0, a0, a1
; RV64DINXZHINX-NEXT:    #NO_APP
; RV64DINXZHINX-NEXT:    ret
  %1 = load half, ptr @gh
  %2 = tail call half asm "fadd.h $0, $1, $2", "=^cr,^cr,^cr"(half %a, half %1)
  ret half %2
}

define half @constraint_half_abi_name(half %a) nounwind {
; RV32ZHINX-LABEL: constraint_half_abi_name:
; RV32ZHINX:       # %bb.0:
; RV32ZHINX-NEXT:    addi sp, sp, -16
; RV32ZHINX-NEXT:    sw s0, 12(sp) # 4-byte Folded Spill
; RV32ZHINX-NEXT:    lui a1, %hi(gh)
; RV32ZHINX-NEXT:    lh s0, %lo(gh)(a1)
; RV32ZHINX-NEXT:    # kill: def $x10_h killed $x10_h def $x10
; RV32ZHINX-NEXT:    #APP
; RV32ZHINX-NEXT:    fadd.s t0, a0, s0
; RV32ZHINX-NEXT:    #NO_APP
; RV32ZHINX-NEXT:    mv a0, t0
; RV32ZHINX-NEXT:    lw s0, 12(sp) # 4-byte Folded Reload
; RV32ZHINX-NEXT:    addi sp, sp, 16
; RV32ZHINX-NEXT:    ret
;
; RV64ZHINX-LABEL: constraint_half_abi_name:
; RV64ZHINX:       # %bb.0:
; RV64ZHINX-NEXT:    addi sp, sp, -16
; RV64ZHINX-NEXT:    sd s0, 8(sp) # 8-byte Folded Spill
; RV64ZHINX-NEXT:    lui a1, %hi(gh)
; RV64ZHINX-NEXT:    lh s0, %lo(gh)(a1)
; RV64ZHINX-NEXT:    # kill: def $x10_h killed $x10_h def $x10
; RV64ZHINX-NEXT:    #APP
; RV64ZHINX-NEXT:    fadd.s t0, a0, s0
; RV64ZHINX-NEXT:    #NO_APP
; RV64ZHINX-NEXT:    mv a0, t0
; RV64ZHINX-NEXT:    ld s0, 8(sp) # 8-byte Folded Reload
; RV64ZHINX-NEXT:    addi sp, sp, 16
; RV64ZHINX-NEXT:    ret
;
; RV32DINXZHINX-LABEL: constraint_half_abi_name:
; RV32DINXZHINX:       # %bb.0:
; RV32DINXZHINX-NEXT:    addi sp, sp, -16
; RV32DINXZHINX-NEXT:    sw s0, 12(sp) # 4-byte Folded Spill
; RV32DINXZHINX-NEXT:    lui a1, %hi(gh)
; RV32DINXZHINX-NEXT:    lh s0, %lo(gh)(a1)
; RV32DINXZHINX-NEXT:    # kill: def $x10_h killed $x10_h def $x10
; RV32DINXZHINX-NEXT:    #APP
; RV32DINXZHINX-NEXT:    fadd.s t0, a0, s0
; RV32DINXZHINX-NEXT:    #NO_APP
; RV32DINXZHINX-NEXT:    mv a0, t0
; RV32DINXZHINX-NEXT:    lw s0, 12(sp) # 4-byte Folded Reload
; RV32DINXZHINX-NEXT:    addi sp, sp, 16
; RV32DINXZHINX-NEXT:    ret
;
; RV64DINXZHINX-LABEL: constraint_half_abi_name:
; RV64DINXZHINX:       # %bb.0:
; RV64DINXZHINX-NEXT:    addi sp, sp, -16
; RV64DINXZHINX-NEXT:    sd s0, 8(sp) # 8-byte Folded Spill
; RV64DINXZHINX-NEXT:    lui a1, %hi(gh)
; RV64DINXZHINX-NEXT:    lh s0, %lo(gh)(a1)
; RV64DINXZHINX-NEXT:    # kill: def $x10_h killed $x10_h def $x10
; RV64DINXZHINX-NEXT:    #APP
; RV64DINXZHINX-NEXT:    fadd.s t0, a0, s0
; RV64DINXZHINX-NEXT:    #NO_APP
; RV64DINXZHINX-NEXT:    mv a0, t0
; RV64DINXZHINX-NEXT:    ld s0, 8(sp) # 8-byte Folded Reload
; RV64DINXZHINX-NEXT:    addi sp, sp, 16
; RV64DINXZHINX-NEXT:    ret
  %1 = load half, ptr @gh
  %2 = tail call half asm "fadd.s $0, $1, $2", "={t0},{a0},{s0}"(half %a, half %1)
  ret half %2
}

define half @constraint_f_half(half %a) nounwind {
; RV32ZHINX-LABEL: constraint_f_half:
; RV32ZHINX:       # %bb.0:
; RV32ZHINX-NEXT:    lui a1, %hi(gh)
; RV32ZHINX-NEXT:    lh a1, %lo(gh)(a1)
; RV32ZHINX-NEXT:    #APP
; RV32ZHINX-NEXT:    fadd.h a0, a0, a1
; RV32ZHINX-NEXT:    #NO_APP
; RV32ZHINX-NEXT:    ret
;
; RV64ZHINX-LABEL: constraint_f_half:
; RV64ZHINX:       # %bb.0:
; RV64ZHINX-NEXT:    lui a1, %hi(gh)
; RV64ZHINX-NEXT:    lh a1, %lo(gh)(a1)
; RV64ZHINX-NEXT:    #APP
; RV64ZHINX-NEXT:    fadd.h a0, a0, a1
; RV64ZHINX-NEXT:    #NO_APP
; RV64ZHINX-NEXT:    ret
;
; RV32DINXZHINX-LABEL: constraint_f_half:
; RV32DINXZHINX:       # %bb.0:
; RV32DINXZHINX-NEXT:    lui a1, %hi(gh)
; RV32DINXZHINX-NEXT:    lh a1, %lo(gh)(a1)
; RV32DINXZHINX-NEXT:    #APP
; RV32DINXZHINX-NEXT:    fadd.h a0, a0, a1
; RV32DINXZHINX-NEXT:    #NO_APP
; RV32DINXZHINX-NEXT:    ret
;
; RV64DINXZHINX-LABEL: constraint_f_half:
; RV64DINXZHINX:       # %bb.0:
; RV64DINXZHINX-NEXT:    lui a1, %hi(gh)
; RV64DINXZHINX-NEXT:    lh a1, %lo(gh)(a1)
; RV64DINXZHINX-NEXT:    #APP
; RV64DINXZHINX-NEXT:    fadd.h a0, a0, a1
; RV64DINXZHINX-NEXT:    #NO_APP
; RV64DINXZHINX-NEXT:    ret
  %1 = load half, ptr @gh
  %2 = tail call half asm "fadd.h $0, $1, $2", "=f,f,f"(half %a, half %1)
  ret half %2
}

define half @constraint_cf_half(half %a) nounwind {
; RV32ZHINX-LABEL: constraint_cf_half:
; RV32ZHINX:       # %bb.0:
; RV32ZHINX-NEXT:    lui a1, %hi(gh)
; RV32ZHINX-NEXT:    lh a1, %lo(gh)(a1)
; RV32ZHINX-NEXT:    #APP
; RV32ZHINX-NEXT:    fadd.h a0, a0, a1
; RV32ZHINX-NEXT:    #NO_APP
; RV32ZHINX-NEXT:    ret
;
; RV64ZHINX-LABEL: constraint_cf_half:
; RV64ZHINX:       # %bb.0:
; RV64ZHINX-NEXT:    lui a1, %hi(gh)
; RV64ZHINX-NEXT:    lh a1, %lo(gh)(a1)
; RV64ZHINX-NEXT:    #APP
; RV64ZHINX-NEXT:    fadd.h a0, a0, a1
; RV64ZHINX-NEXT:    #NO_APP
; RV64ZHINX-NEXT:    ret
;
; RV32DINXZHINX-LABEL: constraint_cf_half:
; RV32DINXZHINX:       # %bb.0:
; RV32DINXZHINX-NEXT:    lui a1, %hi(gh)
; RV32DINXZHINX-NEXT:    lh a1, %lo(gh)(a1)
; RV32DINXZHINX-NEXT:    #APP
; RV32DINXZHINX-NEXT:    fadd.h a0, a0, a1
; RV32DINXZHINX-NEXT:    #NO_APP
; RV32DINXZHINX-NEXT:    ret
;
; RV64DINXZHINX-LABEL: constraint_cf_half:
; RV64DINXZHINX:       # %bb.0:
; RV64DINXZHINX-NEXT:    lui a1, %hi(gh)
; RV64DINXZHINX-NEXT:    lh a1, %lo(gh)(a1)
; RV64DINXZHINX-NEXT:    #APP
; RV64DINXZHINX-NEXT:    fadd.h a0, a0, a1
; RV64DINXZHINX-NEXT:    #NO_APP
; RV64DINXZHINX-NEXT:    ret
  %1 = load half, ptr @gh
  %2 = tail call half asm "fadd.h $0, $1, $2", "=^cf,^cf,^cf"(half %a, half %1)
  ret half %2
}