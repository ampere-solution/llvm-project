; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=gfx90a -amdgpu-atomic-optimizer-strategy=None < %s | FileCheck %s

define protected amdgpu_kernel void @IllegalGEPConst(i32 %a, ptr addrspace(1) %b, double %c) {
; CHECK-LABEL: IllegalGEPConst:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_load_dword s0, s[2:3], 0x24
; CHECK-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x2c
; CHECK-NEXT:    v_mov_b32_e32 v2, 0
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_ashr_i32 s1, s0, 31
; CHECK-NEXT:    s_lshl_b64 s[0:1], s[0:1], 3
; CHECK-NEXT:    s_add_u32 s0, s4, s0
; CHECK-NEXT:    v_mov_b32_e32 v0, s6
; CHECK-NEXT:    v_mov_b32_e32 v1, s7
; CHECK-NEXT:    s_addc_u32 s1, s5, s1
; CHECK-NEXT:    global_atomic_add_f64 v2, v[0:1], s[0:1] offset:-8
; CHECK-NEXT:    s_waitcnt vmcnt(0)
; CHECK-NEXT:    buffer_wbinvl1_vol
; CHECK-NEXT:    s_endpgm
entry:
  %i = add nsw i32 %a, -1
  %i.2 = sext i32 %i to i64
  %i.3 = getelementptr inbounds double, ptr addrspace(1) %b, i64 %i.2
  %i.4 = addrspacecast ptr addrspace(1) %i.3 to ptr
  %i.5 = atomicrmw fadd ptr %i.4, double %c syncscope("agent") seq_cst, align 8, !amdgpu.no.fine.grained.memory !0
  ret void
}

!0 = !{}