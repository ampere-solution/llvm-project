; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=gfx1150 -verify-machineinstrs < %s | FileCheck -check-prefix=SDAG %s
; RUN: llc -mtriple=amdgcn -mcpu=gfx1150 -global-isel -verify-machineinstrs < %s | FileCheck -check-prefix=GISEL %s

define amdgpu_vs void @f32_olt(ptr addrspace(1) inreg %out, float inreg %a, float inreg %b) {
; SDAG-LABEL: f32_olt:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_lt_f32 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f32_olt:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_lt_f32 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp olt float %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f32_oeq(ptr addrspace(1) inreg %out, float inreg %a, float inreg %b) {
; SDAG-LABEL: f32_oeq:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_eq_f32 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f32_oeq:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_eq_f32 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp oeq float %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f32_ole(ptr addrspace(1) inreg %out, float inreg %a, float inreg %b) {
; SDAG-LABEL: f32_ole:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_le_f32 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f32_ole:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_le_f32 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp ole float %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f32_ogt(ptr addrspace(1) inreg %out, float inreg %a, float inreg %b) {
; SDAG-LABEL: f32_ogt:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_gt_f32 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f32_ogt:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_gt_f32 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp ogt float %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f32_one(ptr addrspace(1) inreg %out, float inreg %a, float inreg %b) {
; SDAG-LABEL: f32_one:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_lg_f32 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f32_one:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_lg_f32 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp one float %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f32_oge(ptr addrspace(1) inreg %out, float inreg %a, float inreg %b) {
; SDAG-LABEL: f32_oge:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_ge_f32 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f32_oge:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_ge_f32 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp oge float %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f32_ord(ptr addrspace(1) inreg %out, float inreg %a, float inreg %b) {
; SDAG-LABEL: f32_ord:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_o_f32 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f32_ord:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_o_f32 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp ord float %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f32_uno(ptr addrspace(1) inreg %out, float inreg %a, float inreg %b) {
; SDAG-LABEL: f32_uno:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_u_f32 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f32_uno:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_u_f32 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp uno float %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f32_ult(ptr addrspace(1) inreg %out, float inreg %a, float inreg %b) {
; SDAG-LABEL: f32_ult:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_nge_f32 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f32_ult:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_nge_f32 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp ult float %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f32_ueq(ptr addrspace(1) inreg %out, float inreg %a, float inreg %b) {
; SDAG-LABEL: f32_ueq:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_nlg_f32 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f32_ueq:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_nlg_f32 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp ueq float %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f32_ule(ptr addrspace(1) inreg %out, float inreg %a, float inreg %b) {
; SDAG-LABEL: f32_ule:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_ngt_f32 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f32_ule:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_ngt_f32 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp ule float %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f32_ugt(ptr addrspace(1) inreg %out, float inreg %a, float inreg %b) {
; SDAG-LABEL: f32_ugt:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_nle_f32 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f32_ugt:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_nle_f32 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp ugt float %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f32_une(ptr addrspace(1) inreg %out, float inreg %a, float inreg %b) {
; SDAG-LABEL: f32_une:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_neq_f32 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f32_une:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_neq_f32 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp une float %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f32_uge(ptr addrspace(1) inreg %out, float inreg %a, float inreg %b) {
; SDAG-LABEL: f32_uge:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_nlt_f32 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f32_uge:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_nlt_f32 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp uge float %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f16_olt(ptr addrspace(1) inreg %out, half inreg %a, half inreg %b) {
; SDAG-LABEL: f16_olt:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_lt_f16 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f16_olt:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_lt_f16 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp olt half %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f16_oeq(ptr addrspace(1) inreg %out, half inreg %a, half inreg %b) {
; SDAG-LABEL: f16_oeq:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_eq_f16 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f16_oeq:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_eq_f16 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp oeq half %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f16_ole(ptr addrspace(1) inreg %out, half inreg %a, half inreg %b) {
; SDAG-LABEL: f16_ole:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_le_f16 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f16_ole:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_le_f16 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp ole half %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f16_ogt(ptr addrspace(1) inreg %out, half inreg %a, half inreg %b) {
; SDAG-LABEL: f16_ogt:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_gt_f16 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f16_ogt:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_gt_f16 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp ogt half %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f16_one(ptr addrspace(1) inreg %out, half inreg %a, half inreg %b) {
; SDAG-LABEL: f16_one:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_lg_f16 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f16_one:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_lg_f16 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp one half %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f16_oge(ptr addrspace(1) inreg %out, half inreg %a, half inreg %b) {
; SDAG-LABEL: f16_oge:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_ge_f16 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f16_oge:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_ge_f16 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp oge half %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f16_ord(ptr addrspace(1) inreg %out, half inreg %a, half inreg %b) {
; SDAG-LABEL: f16_ord:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_o_f16 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f16_ord:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_o_f16 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp ord half %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f16_uno(ptr addrspace(1) inreg %out, half inreg %a, half inreg %b) {
; SDAG-LABEL: f16_uno:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_u_f16 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f16_uno:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_u_f16 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp uno half %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f16_ult(ptr addrspace(1) inreg %out, half inreg %a, half inreg %b) {
; SDAG-LABEL: f16_ult:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_nge_f16 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f16_ult:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_nge_f16 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp ult half %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f16_ueq(ptr addrspace(1) inreg %out, half inreg %a, half inreg %b) {
; SDAG-LABEL: f16_ueq:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_nlg_f16 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f16_ueq:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_nlg_f16 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp ueq half %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f16_ule(ptr addrspace(1) inreg %out, half inreg %a, half inreg %b) {
; SDAG-LABEL: f16_ule:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_ngt_f16 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f16_ule:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_ngt_f16 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp ule half %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f16_ugt(ptr addrspace(1) inreg %out, half inreg %a, half inreg %b) {
; SDAG-LABEL: f16_ugt:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_nle_f16 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f16_ugt:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_nle_f16 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp ugt half %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f16_une(ptr addrspace(1) inreg %out, half inreg %a, half inreg %b) {
; SDAG-LABEL: f16_une:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_neq_f16 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f16_une:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_neq_f16 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp une half %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}

define amdgpu_vs void @f16_uge(ptr addrspace(1) inreg %out, half inreg %a, half inreg %b) {
; SDAG-LABEL: f16_uge:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_nlt_f16 s2, s3
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    s_cselect_b32 s2, -1, 0
; SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; SDAG-NEXT:    v_cndmask_b32_e64 v1, 0, -1, s2
; SDAG-NEXT:    global_store_b32 v0, v1, s[0:1]
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: f16_uge:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_nlt_f16 s2, s3
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    s_cselect_b32 s2, 1, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_bfe_i32 s2, s2, 0x10000
; GISEL-NEXT:    v_mov_b32_e32 v0, s2
; GISEL-NEXT:    global_store_b32 v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
entry:
  %0 = fcmp uge half %a, %b
  %1 = sext i1 %0 to i32
  store i32 %1, ptr addrspace(1) %out
  ret void
}