; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc < %s --mtriple=nvptx64 -mcpu=sm_20 | FileCheck --check-prefix=SM20 %s
; RUN: llc < %s --mtriple=nvptx64 -mcpu=sm_35 | FileCheck --check-prefix=SM35 %s
; RUN: %if ptxas %{ llc < %s --mtriple=nvptx64 -mcpu=sm_20 | %ptxas-verify %}
; RUN: %if ptxas %{ llc < %s --mtriple=nvptx64 -mcpu=sm_35 | %ptxas-verify %}


declare i32 @llvm.nvvm.rotate.b32(i32, i32)
declare i64 @llvm.nvvm.rotate.b64(i64, i32)
declare i64 @llvm.nvvm.rotate.right.b64(i64, i32)

declare i64 @llvm.fshl.i64(i64, i64, i64)
declare i64 @llvm.fshr.i64(i64, i64, i64)
declare i32 @llvm.fshl.i32(i32, i32, i32)
declare i32 @llvm.fshr.i32(i32, i32, i32)


; SM20: rotate32
; SM35: rotate32
define i32 @rotate32(i32 %a, i32 %b) {
; SM20-LABEL: rotate32(
; SM20:       {
; SM20-NEXT:    .reg .b32 %r<9>;
; SM20-EMPTY:
; SM20-NEXT:  // %bb.0:
; SM20-NEXT:    ld.param.u32 %r1, [rotate32_param_0];
; SM20-NEXT:    ld.param.u32 %r2, [rotate32_param_1];
; SM20-NEXT:    and.b32 %r3, %r2, 31;
; SM20-NEXT:    shl.b32 %r4, %r1, %r3;
; SM20-NEXT:    neg.s32 %r5, %r2;
; SM20-NEXT:    and.b32 %r6, %r5, 31;
; SM20-NEXT:    shr.u32 %r7, %r1, %r6;
; SM20-NEXT:    or.b32 %r8, %r4, %r7;
; SM20-NEXT:    st.param.b32 [func_retval0], %r8;
; SM20-NEXT:    ret;
;
; SM35-LABEL: rotate32(
; SM35:       {
; SM35-NEXT:    .reg .b32 %r<4>;
; SM35-EMPTY:
; SM35-NEXT:  // %bb.0:
; SM35-NEXT:    ld.param.u32 %r1, [rotate32_param_0];
; SM35-NEXT:    ld.param.u32 %r2, [rotate32_param_1];
; SM35-NEXT:    shf.l.wrap.b32 %r3, %r1, %r1, %r2;
; SM35-NEXT:    st.param.b32 [func_retval0], %r3;
; SM35-NEXT:    ret;
  %val = tail call i32 @llvm.nvvm.rotate.b32(i32 %a, i32 %b)
  ret i32 %val
}

; SM20: rotate64
; SM35: rotate64
define i64 @rotate64(i64 %a, i32 %b) {
; SM20-LABEL: rotate64(
; SM20:       {
; SM20-NEXT:    .reg .b32 %r<5>;
; SM20-NEXT:    .reg .b64 %rd<5>;
; SM20-EMPTY:
; SM20-NEXT:  // %bb.0:
; SM20-NEXT:    ld.param.u64 %rd1, [rotate64_param_0];
; SM20-NEXT:    ld.param.u32 %r1, [rotate64_param_1];
; SM20-NEXT:    and.b32 %r2, %r1, 63;
; SM20-NEXT:    shl.b64 %rd2, %rd1, %r2;
; SM20-NEXT:    neg.s32 %r3, %r1;
; SM20-NEXT:    and.b32 %r4, %r3, 63;
; SM20-NEXT:    shr.u64 %rd3, %rd1, %r4;
; SM20-NEXT:    or.b64 %rd4, %rd2, %rd3;
; SM20-NEXT:    st.param.b64 [func_retval0], %rd4;
; SM20-NEXT:    ret;
;
; SM35-LABEL: rotate64(
; SM35:       {
; SM35-NEXT:    .reg .b32 %r<5>;
; SM35-NEXT:    .reg .b64 %rd<5>;
; SM35-EMPTY:
; SM35-NEXT:  // %bb.0:
; SM35-NEXT:    ld.param.u64 %rd1, [rotate64_param_0];
; SM35-NEXT:    ld.param.u32 %r1, [rotate64_param_1];
; SM35-NEXT:    and.b32 %r2, %r1, 63;
; SM35-NEXT:    shl.b64 %rd2, %rd1, %r2;
; SM35-NEXT:    neg.s32 %r3, %r1;
; SM35-NEXT:    and.b32 %r4, %r3, 63;
; SM35-NEXT:    shr.u64 %rd3, %rd1, %r4;
; SM35-NEXT:    or.b64 %rd4, %rd2, %rd3;
; SM35-NEXT:    st.param.b64 [func_retval0], %rd4;
; SM35-NEXT:    ret;
  %val = tail call i64 @llvm.nvvm.rotate.b64(i64 %a, i32 %b)
  ret i64 %val
}

; SM20: rotateright64
; SM35: rotateright64
define i64 @rotateright64(i64 %a, i32 %b) {
; SM20-LABEL: rotateright64(
; SM20:       {
; SM20-NEXT:    .reg .b32 %r<5>;
; SM20-NEXT:    .reg .b64 %rd<5>;
; SM20-EMPTY:
; SM20-NEXT:  // %bb.0:
; SM20-NEXT:    ld.param.u64 %rd1, [rotateright64_param_0];
; SM20-NEXT:    ld.param.u32 %r1, [rotateright64_param_1];
; SM20-NEXT:    and.b32 %r2, %r1, 63;
; SM20-NEXT:    shr.u64 %rd2, %rd1, %r2;
; SM20-NEXT:    neg.s32 %r3, %r1;
; SM20-NEXT:    and.b32 %r4, %r3, 63;
; SM20-NEXT:    shl.b64 %rd3, %rd1, %r4;
; SM20-NEXT:    or.b64 %rd4, %rd2, %rd3;
; SM20-NEXT:    st.param.b64 [func_retval0], %rd4;
; SM20-NEXT:    ret;
;
; SM35-LABEL: rotateright64(
; SM35:       {
; SM35-NEXT:    .reg .b32 %r<5>;
; SM35-NEXT:    .reg .b64 %rd<5>;
; SM35-EMPTY:
; SM35-NEXT:  // %bb.0:
; SM35-NEXT:    ld.param.u64 %rd1, [rotateright64_param_0];
; SM35-NEXT:    ld.param.u32 %r1, [rotateright64_param_1];
; SM35-NEXT:    and.b32 %r2, %r1, 63;
; SM35-NEXT:    shr.u64 %rd2, %rd1, %r2;
; SM35-NEXT:    neg.s32 %r3, %r1;
; SM35-NEXT:    and.b32 %r4, %r3, 63;
; SM35-NEXT:    shl.b64 %rd3, %rd1, %r4;
; SM35-NEXT:    or.b64 %rd4, %rd2, %rd3;
; SM35-NEXT:    st.param.b64 [func_retval0], %rd4;
; SM35-NEXT:    ret;
  %val = tail call i64 @llvm.nvvm.rotate.right.b64(i64 %a, i32 %b)
  ret i64 %val
}

; SM20: rotl0
; SM35: rotl0
define i32 @rotl0(i32 %x) {
; SM20-LABEL: rotl0(
; SM20:       {
; SM20-NEXT:    .reg .b32 %r<5>;
; SM20-EMPTY:
; SM20-NEXT:  // %bb.0:
; SM20-NEXT:    ld.param.u32 %r1, [rotl0_param_0];
; SM20-NEXT:    shr.u32 %r2, %r1, 24;
; SM20-NEXT:    shl.b32 %r3, %r1, 8;
; SM20-NEXT:    or.b32 %r4, %r3, %r2;
; SM20-NEXT:    st.param.b32 [func_retval0], %r4;
; SM20-NEXT:    ret;
;
; SM35-LABEL: rotl0(
; SM35:       {
; SM35-NEXT:    .reg .b32 %r<3>;
; SM35-EMPTY:
; SM35-NEXT:  // %bb.0:
; SM35-NEXT:    ld.param.u32 %r1, [rotl0_param_0];
; SM35-NEXT:    shf.l.wrap.b32 %r2, %r1, %r1, 8;
; SM35-NEXT:    st.param.b32 [func_retval0], %r2;
; SM35-NEXT:    ret;
  %t0 = shl i32 %x, 8
  %t1 = lshr i32 %x, 24
  %t2 = or i32 %t0, %t1
  ret i32 %t2
}

; SM35: rotl64
define i64 @rotl64(i64 %a, i64 %n) {
; SM20-LABEL: rotl64(
; SM20:       {
; SM20-NEXT:    .reg .b32 %r<5>;
; SM20-NEXT:    .reg .b64 %rd<5>;
; SM20-EMPTY:
; SM20-NEXT:  // %bb.0:
; SM20-NEXT:    ld.param.u64 %rd1, [rotl64_param_0];
; SM20-NEXT:    ld.param.u32 %r1, [rotl64_param_1];
; SM20-NEXT:    and.b32 %r2, %r1, 63;
; SM20-NEXT:    shl.b64 %rd2, %rd1, %r2;
; SM20-NEXT:    neg.s32 %r3, %r1;
; SM20-NEXT:    and.b32 %r4, %r3, 63;
; SM20-NEXT:    shr.u64 %rd3, %rd1, %r4;
; SM20-NEXT:    or.b64 %rd4, %rd2, %rd3;
; SM20-NEXT:    st.param.b64 [func_retval0], %rd4;
; SM20-NEXT:    ret;
;
; SM35-LABEL: rotl64(
; SM35:       {
; SM35-NEXT:    .reg .b32 %r<5>;
; SM35-NEXT:    .reg .b64 %rd<5>;
; SM35-EMPTY:
; SM35-NEXT:  // %bb.0:
; SM35-NEXT:    ld.param.u64 %rd1, [rotl64_param_0];
; SM35-NEXT:    ld.param.u32 %r1, [rotl64_param_1];
; SM35-NEXT:    and.b32 %r2, %r1, 63;
; SM35-NEXT:    shl.b64 %rd2, %rd1, %r2;
; SM35-NEXT:    neg.s32 %r3, %r1;
; SM35-NEXT:    and.b32 %r4, %r3, 63;
; SM35-NEXT:    shr.u64 %rd3, %rd1, %r4;
; SM35-NEXT:    or.b64 %rd4, %rd2, %rd3;
; SM35-NEXT:    st.param.b64 [func_retval0], %rd4;
; SM35-NEXT:    ret;
  %val = tail call i64 @llvm.fshl.i64(i64 %a, i64 %a, i64 %n)
  ret i64 %val
}

; SM35: rotl64_imm
define i64 @rotl64_imm(i64 %a) {
; SM20-LABEL: rotl64_imm(
; SM20:       {
; SM20-NEXT:    .reg .b64 %rd<5>;
; SM20-EMPTY:
; SM20-NEXT:  // %bb.0:
; SM20-NEXT:    ld.param.u64 %rd1, [rotl64_imm_param_0];
; SM20-NEXT:    shr.u64 %rd2, %rd1, 62;
; SM20-NEXT:    shl.b64 %rd3, %rd1, 2;
; SM20-NEXT:    or.b64 %rd4, %rd3, %rd2;
; SM20-NEXT:    st.param.b64 [func_retval0], %rd4;
; SM20-NEXT:    ret;
;
; SM35-LABEL: rotl64_imm(
; SM35:       {
; SM35-NEXT:    .reg .b64 %rd<5>;
; SM35-EMPTY:
; SM35-NEXT:  // %bb.0:
; SM35-NEXT:    ld.param.u64 %rd1, [rotl64_imm_param_0];
; SM35-NEXT:    shr.u64 %rd2, %rd1, 62;
; SM35-NEXT:    shl.b64 %rd3, %rd1, 2;
; SM35-NEXT:    or.b64 %rd4, %rd3, %rd2;
; SM35-NEXT:    st.param.b64 [func_retval0], %rd4;
; SM35-NEXT:    ret;
  %val = tail call i64 @llvm.fshl.i64(i64 %a, i64 %a, i64 66)
  ret i64 %val
}

; SM35: rotr64
define i64 @rotr64(i64 %a, i64 %n) {
; SM20-LABEL: rotr64(
; SM20:       {
; SM20-NEXT:    .reg .b32 %r<5>;
; SM20-NEXT:    .reg .b64 %rd<5>;
; SM20-EMPTY:
; SM20-NEXT:  // %bb.0:
; SM20-NEXT:    ld.param.u64 %rd1, [rotr64_param_0];
; SM20-NEXT:    ld.param.u32 %r1, [rotr64_param_1];
; SM20-NEXT:    and.b32 %r2, %r1, 63;
; SM20-NEXT:    shr.u64 %rd2, %rd1, %r2;
; SM20-NEXT:    neg.s32 %r3, %r1;
; SM20-NEXT:    and.b32 %r4, %r3, 63;
; SM20-NEXT:    shl.b64 %rd3, %rd1, %r4;
; SM20-NEXT:    or.b64 %rd4, %rd2, %rd3;
; SM20-NEXT:    st.param.b64 [func_retval0], %rd4;
; SM20-NEXT:    ret;
;
; SM35-LABEL: rotr64(
; SM35:       {
; SM35-NEXT:    .reg .b32 %r<5>;
; SM35-NEXT:    .reg .b64 %rd<5>;
; SM35-EMPTY:
; SM35-NEXT:  // %bb.0:
; SM35-NEXT:    ld.param.u64 %rd1, [rotr64_param_0];
; SM35-NEXT:    ld.param.u32 %r1, [rotr64_param_1];
; SM35-NEXT:    and.b32 %r2, %r1, 63;
; SM35-NEXT:    shr.u64 %rd2, %rd1, %r2;
; SM35-NEXT:    neg.s32 %r3, %r1;
; SM35-NEXT:    and.b32 %r4, %r3, 63;
; SM35-NEXT:    shl.b64 %rd3, %rd1, %r4;
; SM35-NEXT:    or.b64 %rd4, %rd2, %rd3;
; SM35-NEXT:    st.param.b64 [func_retval0], %rd4;
; SM35-NEXT:    ret;
  %val = tail call i64 @llvm.fshr.i64(i64 %a, i64 %a, i64 %n)
  ret i64 %val
}

; SM35: rotr64_imm
define i64 @rotr64_imm(i64 %a) {
; SM20-LABEL: rotr64_imm(
; SM20:       {
; SM20-NEXT:    .reg .b64 %rd<5>;
; SM20-EMPTY:
; SM20-NEXT:  // %bb.0:
; SM20-NEXT:    ld.param.u64 %rd1, [rotr64_imm_param_0];
; SM20-NEXT:    shl.b64 %rd2, %rd1, 62;
; SM20-NEXT:    shr.u64 %rd3, %rd1, 2;
; SM20-NEXT:    or.b64 %rd4, %rd3, %rd2;
; SM20-NEXT:    st.param.b64 [func_retval0], %rd4;
; SM20-NEXT:    ret;
;
; SM35-LABEL: rotr64_imm(
; SM35:       {
; SM35-NEXT:    .reg .b64 %rd<5>;
; SM35-EMPTY:
; SM35-NEXT:  // %bb.0:
; SM35-NEXT:    ld.param.u64 %rd1, [rotr64_imm_param_0];
; SM35-NEXT:    shl.b64 %rd2, %rd1, 62;
; SM35-NEXT:    shr.u64 %rd3, %rd1, 2;
; SM35-NEXT:    or.b64 %rd4, %rd3, %rd2;
; SM35-NEXT:    st.param.b64 [func_retval0], %rd4;
; SM35-NEXT:    ret;
  %val = tail call i64 @llvm.fshr.i64(i64 %a, i64 %a, i64 66)
  ret i64 %val
}

define i32 @funnel_shift_right_32(i32 %a, i32 %b, i32 %c) {
; SM20-LABEL: funnel_shift_right_32(
; SM20:       {
; SM20-NEXT:    .reg .b32 %r<11>;
; SM20-EMPTY:
; SM20-NEXT:  // %bb.0:
; SM20-NEXT:    ld.param.u32 %r1, [funnel_shift_right_32_param_0];
; SM20-NEXT:    ld.param.u32 %r2, [funnel_shift_right_32_param_2];
; SM20-NEXT:    and.b32 %r3, %r2, 31;
; SM20-NEXT:    ld.param.u32 %r4, [funnel_shift_right_32_param_1];
; SM20-NEXT:    shr.u32 %r5, %r4, %r3;
; SM20-NEXT:    shl.b32 %r6, %r1, 1;
; SM20-NEXT:    not.b32 %r7, %r2;
; SM20-NEXT:    and.b32 %r8, %r7, 31;
; SM20-NEXT:    shl.b32 %r9, %r6, %r8;
; SM20-NEXT:    or.b32 %r10, %r9, %r5;
; SM20-NEXT:    st.param.b32 [func_retval0], %r10;
; SM20-NEXT:    ret;
;
; SM35-LABEL: funnel_shift_right_32(
; SM35:       {
; SM35-NEXT:    .reg .b32 %r<5>;
; SM35-EMPTY:
; SM35-NEXT:  // %bb.0:
; SM35-NEXT:    ld.param.u32 %r1, [funnel_shift_right_32_param_0];
; SM35-NEXT:    ld.param.u32 %r2, [funnel_shift_right_32_param_1];
; SM35-NEXT:    ld.param.u32 %r3, [funnel_shift_right_32_param_2];
; SM35-NEXT:    shf.r.wrap.b32 %r4, %r2, %r1, %r3;
; SM35-NEXT:    st.param.b32 [func_retval0], %r4;
; SM35-NEXT:    ret;
  %val = call i32 @llvm.fshr.i32(i32 %a, i32 %b, i32 %c)
  ret i32 %val
}

define i32 @funnel_shift_left_32(i32 %a, i32 %b, i32 %c) {
; SM20-LABEL: funnel_shift_left_32(
; SM20:       {
; SM20-NEXT:    .reg .b32 %r<11>;
; SM20-EMPTY:
; SM20-NEXT:  // %bb.0:
; SM20-NEXT:    ld.param.u32 %r1, [funnel_shift_left_32_param_0];
; SM20-NEXT:    ld.param.u32 %r2, [funnel_shift_left_32_param_2];
; SM20-NEXT:    and.b32 %r3, %r2, 31;
; SM20-NEXT:    shl.b32 %r4, %r1, %r3;
; SM20-NEXT:    ld.param.u32 %r5, [funnel_shift_left_32_param_1];
; SM20-NEXT:    shr.u32 %r6, %r5, 1;
; SM20-NEXT:    not.b32 %r7, %r2;
; SM20-NEXT:    and.b32 %r8, %r7, 31;
; SM20-NEXT:    shr.u32 %r9, %r6, %r8;
; SM20-NEXT:    or.b32 %r10, %r4, %r9;
; SM20-NEXT:    st.param.b32 [func_retval0], %r10;
; SM20-NEXT:    ret;
;
; SM35-LABEL: funnel_shift_left_32(
; SM35:       {
; SM35-NEXT:    .reg .b32 %r<5>;
; SM35-EMPTY:
; SM35-NEXT:  // %bb.0:
; SM35-NEXT:    ld.param.u32 %r1, [funnel_shift_left_32_param_0];
; SM35-NEXT:    ld.param.u32 %r2, [funnel_shift_left_32_param_1];
; SM35-NEXT:    ld.param.u32 %r3, [funnel_shift_left_32_param_2];
; SM35-NEXT:    shf.l.wrap.b32 %r4, %r2, %r1, %r3;
; SM35-NEXT:    st.param.b32 [func_retval0], %r4;
; SM35-NEXT:    ret;
  %val = call i32 @llvm.fshl.i32(i32 %a, i32 %b, i32 %c)
  ret i32 %val
}

define i64 @funnel_shift_right_64(i64 %a, i64 %b, i64 %c) {
; SM20-LABEL: funnel_shift_right_64(
; SM20:       {
; SM20-NEXT:    .reg .b32 %r<5>;
; SM20-NEXT:    .reg .b64 %rd<7>;
; SM20-EMPTY:
; SM20-NEXT:  // %bb.0:
; SM20-NEXT:    ld.param.u64 %rd1, [funnel_shift_right_64_param_0];
; SM20-NEXT:    ld.param.u32 %r1, [funnel_shift_right_64_param_2];
; SM20-NEXT:    and.b32 %r2, %r1, 63;
; SM20-NEXT:    ld.param.u64 %rd2, [funnel_shift_right_64_param_1];
; SM20-NEXT:    shr.u64 %rd3, %rd2, %r2;
; SM20-NEXT:    shl.b64 %rd4, %rd1, 1;
; SM20-NEXT:    not.b32 %r3, %r1;
; SM20-NEXT:    and.b32 %r4, %r3, 63;
; SM20-NEXT:    shl.b64 %rd5, %rd4, %r4;
; SM20-NEXT:    or.b64 %rd6, %rd5, %rd3;
; SM20-NEXT:    st.param.b64 [func_retval0], %rd6;
; SM20-NEXT:    ret;
;
; SM35-LABEL: funnel_shift_right_64(
; SM35:       {
; SM35-NEXT:    .reg .b32 %r<5>;
; SM35-NEXT:    .reg .b64 %rd<7>;
; SM35-EMPTY:
; SM35-NEXT:  // %bb.0:
; SM35-NEXT:    ld.param.u64 %rd1, [funnel_shift_right_64_param_0];
; SM35-NEXT:    ld.param.u32 %r1, [funnel_shift_right_64_param_2];
; SM35-NEXT:    and.b32 %r2, %r1, 63;
; SM35-NEXT:    ld.param.u64 %rd2, [funnel_shift_right_64_param_1];
; SM35-NEXT:    shr.u64 %rd3, %rd2, %r2;
; SM35-NEXT:    shl.b64 %rd4, %rd1, 1;
; SM35-NEXT:    not.b32 %r3, %r1;
; SM35-NEXT:    and.b32 %r4, %r3, 63;
; SM35-NEXT:    shl.b64 %rd5, %rd4, %r4;
; SM35-NEXT:    or.b64 %rd6, %rd5, %rd3;
; SM35-NEXT:    st.param.b64 [func_retval0], %rd6;
; SM35-NEXT:    ret;
  %val = call i64 @llvm.fshr.i64(i64 %a, i64 %b, i64 %c)
  ret i64 %val
}

define i64 @funnel_shift_left_64(i64 %a, i64 %b, i64 %c) {
; SM20-LABEL: funnel_shift_left_64(
; SM20:       {
; SM20-NEXT:    .reg .b32 %r<5>;
; SM20-NEXT:    .reg .b64 %rd<7>;
; SM20-EMPTY:
; SM20-NEXT:  // %bb.0:
; SM20-NEXT:    ld.param.u64 %rd1, [funnel_shift_left_64_param_0];
; SM20-NEXT:    ld.param.u32 %r1, [funnel_shift_left_64_param_2];
; SM20-NEXT:    and.b32 %r2, %r1, 63;
; SM20-NEXT:    shl.b64 %rd2, %rd1, %r2;
; SM20-NEXT:    ld.param.u64 %rd3, [funnel_shift_left_64_param_1];
; SM20-NEXT:    shr.u64 %rd4, %rd3, 1;
; SM20-NEXT:    not.b32 %r3, %r1;
; SM20-NEXT:    and.b32 %r4, %r3, 63;
; SM20-NEXT:    shr.u64 %rd5, %rd4, %r4;
; SM20-NEXT:    or.b64 %rd6, %rd2, %rd5;
; SM20-NEXT:    st.param.b64 [func_retval0], %rd6;
; SM20-NEXT:    ret;
;
; SM35-LABEL: funnel_shift_left_64(
; SM35:       {
; SM35-NEXT:    .reg .b32 %r<5>;
; SM35-NEXT:    .reg .b64 %rd<7>;
; SM35-EMPTY:
; SM35-NEXT:  // %bb.0:
; SM35-NEXT:    ld.param.u64 %rd1, [funnel_shift_left_64_param_0];
; SM35-NEXT:    ld.param.u32 %r1, [funnel_shift_left_64_param_2];
; SM35-NEXT:    and.b32 %r2, %r1, 63;
; SM35-NEXT:    shl.b64 %rd2, %rd1, %r2;
; SM35-NEXT:    ld.param.u64 %rd3, [funnel_shift_left_64_param_1];
; SM35-NEXT:    shr.u64 %rd4, %rd3, 1;
; SM35-NEXT:    not.b32 %r3, %r1;
; SM35-NEXT:    and.b32 %r4, %r3, 63;
; SM35-NEXT:    shr.u64 %rd5, %rd4, %r4;
; SM35-NEXT:    or.b64 %rd6, %rd2, %rd5;
; SM35-NEXT:    st.param.b64 [func_retval0], %rd6;
; SM35-NEXT:    ret;
  %val = call i64 @llvm.fshl.i64(i64 %a, i64 %b, i64 %c)
  ret i64 %val
}
