; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=riscv32 -mattr=+v,+d,+zvfh,+zvfbfmin -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32,NOZFMIN,ZVFH
; RUN: llc -mtriple=riscv64 -mattr=+v,+d,+zvfh,+zvfbfmin -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64,NOZFMIN,ZVFH
; RUN: llc -mtriple=riscv32 -mattr=+v,+d,+zvfhmin,+zvfbfmin -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32,NOZFMIN,ZVFHMIN
; RUN: llc -mtriple=riscv64 -mattr=+v,+d,+zvfhmin,+zvfbfmin -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64,NOZFMIN,ZVFHMIN
; RUN: llc -mtriple=riscv32 -mattr=+v,+d,+zfhmin,+zfbfmin,+zvfhmin,+zvfbfmin -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32,ZFMIN
; RUN: llc -mtriple=riscv64 -mattr=+v,+d,+zfhmin,+zfbfmin,+zvfhmin,+zvfbfmin -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64,ZFMIN

define <vscale x 1 x i8> @vp_splat_nxv1i8(i8 %val, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv1i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 1 x i8> @llvm.experimental.vp.splat.nxv1i8(i8 %val, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i8> %splat
}

define <vscale x 2 x i8> @vp_splat_nxv2i8(i8 %val, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 2 x i8> @llvm.experimental.vp.splat.nxv2i8(i8 %val, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i8> %splat
}

define <vscale x 4 x i8> @vp_splat_nxv4i8(i8 %val, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 4 x i8> @llvm.experimental.vp.splat.nxv4i8(i8 %val, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i8> %splat
}

define <vscale x 8 x i8> @vp_splat_nxv8i8(i8 %val, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 8 x i8> @llvm.experimental.vp.splat.nxv8i8(i8 %val, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i8> %splat
}

define <vscale x 16 x i8> @vp_splat_nxv16i8(i8 %val, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m2, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 16 x i8> @llvm.experimental.vp.splat.nxv16i8(i8 %val, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x i8> %splat
}

define <vscale x 32 x i8> @vp_splat_nxv32i8(i8 %val, <vscale x 32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m4, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 32 x i8> @llvm.experimental.vp.splat.nxv32i8(i8 %val, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x i8> %splat
}

define <vscale x 64 x i8> @vp_splat_nxv64i8(i8 %val, <vscale x 64 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m8, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 64 x i8> @llvm.experimental.vp.splat.nxv64i8(i8 %val, <vscale x 64 x i1> %m, i32 %evl)
  ret <vscale x 64 x i8> %splat
}

define <vscale x 1 x i16> @vp_splat_nxv1i16(i16 %val, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv1i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, mf4, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 1 x i16> @llvm.experimental.vp.splat.nxv1i16(i16 %val, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i16> %splat
}

define <vscale x 2 x i16> @vp_splat_nxv2i16(i16 %val, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, mf2, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 2 x i16> @llvm.experimental.vp.splat.nxv2i16(i16 %val, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i16> %splat
}

define <vscale x 4 x i16> @vp_splat_nxv4i16(i16 %val, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 4 x i16> @llvm.experimental.vp.splat.nxv4i16(i16 %val, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i16> %splat
}

define <vscale x 8 x i16> @vp_splat_nxv8i16(i16 %val, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, m2, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 8 x i16> @llvm.experimental.vp.splat.nxv8i16(i16 %val, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i16> %splat
}

define <vscale x 16 x i16> @vp_splat_nxv16i16(i16 %val, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, m4, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 16 x i16> @llvm.experimental.vp.splat.nxv16i16(i16 %val, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x i16> %splat
}

define <vscale x 32 x i16> @vp_splat_nxv32i16(i16 %val, <vscale x 32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv32i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, m8, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 32 x i16> @llvm.experimental.vp.splat.nxv32i16(i16 %val, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x i16> %splat
}

define <vscale x 1 x i32> @vp_splat_nxv1i32(i32 %val, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv1i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, mf2, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 1 x i32> @llvm.experimental.vp.splat.nxv1i32(i32 %val, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i32> %splat
}

define <vscale x 2 x i32> @vp_splat_nxv2i32(i32 %val, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 2 x i32> @llvm.experimental.vp.splat.nxv2i32(i32 %val, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i32> %splat
}

define <vscale x 4 x i32> @vp_splat_nxv4i32(i32 %val, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 4 x i32> @llvm.experimental.vp.splat.nxv4i32(i32 %val, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i32> %splat
}

define <vscale x 8 x i32> @vp_splat_nxv8i32(i32 %val, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 8 x i32> @llvm.experimental.vp.splat.nxv8i32(i32 %val, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i32> %splat
}

define <vscale x 16 x i32> @vp_splat_nxv16i32(i32 %val, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 16 x i32> @llvm.experimental.vp.splat.nxv16i32(i32 %val, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x i32> %splat
}

define <vscale x 1 x i64> @vp_splat_nxv1i64(i64 %val, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; RV32-LABEL: vp_splat_nxv1i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetvli a1, zero, e64, m1, ta, ma
; RV32-NEXT:    vlse64.v v8, (a0), zero
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vp_splat_nxv1i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli zero, a1, e64, m1, ta, ma
; RV64-NEXT:    vmv.v.x v8, a0
; RV64-NEXT:    ret
  %splat = call <vscale x 1 x i64> @llvm.experimental.vp.splat.nxv1i64(i64 %val, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i64> %splat
}

define <vscale x 2 x i64> @vp_splat_nxv2i64(i64 %val, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; RV32-LABEL: vp_splat_nxv2i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetvli a1, zero, e64, m2, ta, ma
; RV32-NEXT:    vlse64.v v8, (a0), zero
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vp_splat_nxv2i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli zero, a1, e64, m2, ta, ma
; RV64-NEXT:    vmv.v.x v8, a0
; RV64-NEXT:    ret
  %splat = call <vscale x 2 x i64> @llvm.experimental.vp.splat.nxv2i64(i64 %val, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i64> %splat
}

define <vscale x 4 x i64> @vp_splat_nxv4i64(i64 %val, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; RV32-LABEL: vp_splat_nxv4i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetvli a1, zero, e64, m4, ta, ma
; RV32-NEXT:    vlse64.v v8, (a0), zero
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vp_splat_nxv4i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli zero, a1, e64, m4, ta, ma
; RV64-NEXT:    vmv.v.x v8, a0
; RV64-NEXT:    ret
  %splat = call <vscale x 4 x i64> @llvm.experimental.vp.splat.nxv4i64(i64 %val, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i64> %splat
}

define <vscale x 8 x i64> @vp_splat_nxv8i64(i64 %val, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; RV32-LABEL: vp_splat_nxv8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; RV32-NEXT:    vlse64.v v8, (a0), zero
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vp_splat_nxv8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli zero, a1, e64, m8, ta, ma
; RV64-NEXT:    vmv.v.x v8, a0
; RV64-NEXT:    ret
  %splat = call <vscale x 8 x i64> @llvm.experimental.vp.splat.nxv8i64(i64 %val, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i64> %splat
}

define <vscale x 1 x bfloat> @vp_splat_nxv1bf16(bfloat %val, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; NOZFMIN-LABEL: vp_splat_nxv1bf16:
; NOZFMIN:       # %bb.0:
; NOZFMIN-NEXT:    fmv.x.w a1, fa0
; NOZFMIN-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; NOZFMIN-NEXT:    vmv.v.x v8, a1
; NOZFMIN-NEXT:    ret
;
; ZFMIN-LABEL: vp_splat_nxv1bf16:
; ZFMIN:       # %bb.0:
; ZFMIN-NEXT:    fmv.x.h a1, fa0
; ZFMIN-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; ZFMIN-NEXT:    vmv.v.x v8, a1
; ZFMIN-NEXT:    ret
  %splat = call <vscale x 1 x bfloat> @llvm.experimental.vp.splat.nxv1bf16(bfloat %val, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x bfloat> %splat
}

define <vscale x 2 x bfloat> @vp_splat_nxv2bf16(bfloat %val, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; NOZFMIN-LABEL: vp_splat_nxv2bf16:
; NOZFMIN:       # %bb.0:
; NOZFMIN-NEXT:    fmv.x.w a1, fa0
; NOZFMIN-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; NOZFMIN-NEXT:    vmv.v.x v8, a1
; NOZFMIN-NEXT:    ret
;
; ZFMIN-LABEL: vp_splat_nxv2bf16:
; ZFMIN:       # %bb.0:
; ZFMIN-NEXT:    fmv.x.h a1, fa0
; ZFMIN-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZFMIN-NEXT:    vmv.v.x v8, a1
; ZFMIN-NEXT:    ret
  %splat = call <vscale x 2 x bfloat> @llvm.experimental.vp.splat.nxv2bf16(bfloat %val, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x bfloat> %splat
}

define <vscale x 4 x bfloat> @vp_splat_nxv4bf16(bfloat %val, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; NOZFMIN-LABEL: vp_splat_nxv4bf16:
; NOZFMIN:       # %bb.0:
; NOZFMIN-NEXT:    fmv.x.w a1, fa0
; NOZFMIN-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; NOZFMIN-NEXT:    vmv.v.x v8, a1
; NOZFMIN-NEXT:    ret
;
; ZFMIN-LABEL: vp_splat_nxv4bf16:
; ZFMIN:       # %bb.0:
; ZFMIN-NEXT:    fmv.x.h a1, fa0
; ZFMIN-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; ZFMIN-NEXT:    vmv.v.x v8, a1
; ZFMIN-NEXT:    ret
  %splat = call <vscale x 4 x bfloat> @llvm.experimental.vp.splat.nxv4bf16(bfloat %val, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x bfloat> %splat
}

define <vscale x 8 x bfloat> @vp_splat_nxv8bf16(bfloat %val, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; NOZFMIN-LABEL: vp_splat_nxv8bf16:
; NOZFMIN:       # %bb.0:
; NOZFMIN-NEXT:    fmv.x.w a1, fa0
; NOZFMIN-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; NOZFMIN-NEXT:    vmv.v.x v8, a1
; NOZFMIN-NEXT:    ret
;
; ZFMIN-LABEL: vp_splat_nxv8bf16:
; ZFMIN:       # %bb.0:
; ZFMIN-NEXT:    fmv.x.h a1, fa0
; ZFMIN-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; ZFMIN-NEXT:    vmv.v.x v8, a1
; ZFMIN-NEXT:    ret
  %splat = call <vscale x 8 x bfloat> @llvm.experimental.vp.splat.nxv8bf16(bfloat %val, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x bfloat> %splat
}

define <vscale x 16 x bfloat> @vp_splat_nxv16bf16(bfloat %val, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; NOZFMIN-LABEL: vp_splat_nxv16bf16:
; NOZFMIN:       # %bb.0:
; NOZFMIN-NEXT:    fmv.x.w a1, fa0
; NOZFMIN-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; NOZFMIN-NEXT:    vmv.v.x v8, a1
; NOZFMIN-NEXT:    ret
;
; ZFMIN-LABEL: vp_splat_nxv16bf16:
; ZFMIN:       # %bb.0:
; ZFMIN-NEXT:    fmv.x.h a1, fa0
; ZFMIN-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; ZFMIN-NEXT:    vmv.v.x v8, a1
; ZFMIN-NEXT:    ret
  %splat = call <vscale x 16 x bfloat> @llvm.experimental.vp.splat.nxv16bf16(bfloat %val, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x bfloat> %splat
}

define <vscale x 32 x bfloat> @vp_splat_nxv32bf16(bfloat %val, <vscale x 32 x i1> %m, i32 zeroext %evl) {
; NOZFMIN-LABEL: vp_splat_nxv32bf16:
; NOZFMIN:       # %bb.0:
; NOZFMIN-NEXT:    fmv.x.w a1, fa0
; NOZFMIN-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; NOZFMIN-NEXT:    vmv.v.x v8, a1
; NOZFMIN-NEXT:    ret
;
; ZFMIN-LABEL: vp_splat_nxv32bf16:
; ZFMIN:       # %bb.0:
; ZFMIN-NEXT:    fmv.x.h a1, fa0
; ZFMIN-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; ZFMIN-NEXT:    vmv.v.x v8, a1
; ZFMIN-NEXT:    ret
  %splat = call <vscale x 32 x bfloat> @llvm.experimental.vp.splat.nxv32bf16(bfloat %val, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x bfloat> %splat
}

define <vscale x 1 x half> @vp_splat_nxv1f16(half %val, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vp_splat_nxv1f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; ZVFH-NEXT:    vfmv.v.f v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vp_splat_nxv1f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fmv.x.w a1, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vmv.v.x v8, a1
; ZVFHMIN-NEXT:    ret
;
; ZFMIN-LABEL: vp_splat_nxv1f16:
; ZFMIN:       # %bb.0:
; ZFMIN-NEXT:    fmv.x.h a1, fa0
; ZFMIN-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; ZFMIN-NEXT:    vmv.v.x v8, a1
; ZFMIN-NEXT:    ret
  %splat = call <vscale x 1 x half> @llvm.experimental.vp.splat.nxv1f16(half %val, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x half> %splat
}

define <vscale x 2 x half> @vp_splat_nxv2f16(half %val, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vp_splat_nxv2f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfmv.v.f v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vp_splat_nxv2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fmv.x.w a1, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vmv.v.x v8, a1
; ZVFHMIN-NEXT:    ret
;
; ZFMIN-LABEL: vp_splat_nxv2f16:
; ZFMIN:       # %bb.0:
; ZFMIN-NEXT:    fmv.x.h a1, fa0
; ZFMIN-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZFMIN-NEXT:    vmv.v.x v8, a1
; ZFMIN-NEXT:    ret
  %splat = call <vscale x 2 x half> @llvm.experimental.vp.splat.nxv2f16(half %val, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x half> %splat
}

define <vscale x 4 x half> @vp_splat_nxv4f16(half %val, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vp_splat_nxv4f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; ZVFH-NEXT:    vfmv.v.f v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vp_splat_nxv4f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fmv.x.w a1, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vmv.v.x v8, a1
; ZVFHMIN-NEXT:    ret
;
; ZFMIN-LABEL: vp_splat_nxv4f16:
; ZFMIN:       # %bb.0:
; ZFMIN-NEXT:    fmv.x.h a1, fa0
; ZFMIN-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; ZFMIN-NEXT:    vmv.v.x v8, a1
; ZFMIN-NEXT:    ret
  %splat = call <vscale x 4 x half> @llvm.experimental.vp.splat.nxv4f16(half %val, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x half> %splat
}

define <vscale x 8 x half> @vp_splat_nxv8f16(half %val, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vp_splat_nxv8f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; ZVFH-NEXT:    vfmv.v.f v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vp_splat_nxv8f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fmv.x.w a1, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vmv.v.x v8, a1
; ZVFHMIN-NEXT:    ret
;
; ZFMIN-LABEL: vp_splat_nxv8f16:
; ZFMIN:       # %bb.0:
; ZFMIN-NEXT:    fmv.x.h a1, fa0
; ZFMIN-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; ZFMIN-NEXT:    vmv.v.x v8, a1
; ZFMIN-NEXT:    ret
  %splat = call <vscale x 8 x half> @llvm.experimental.vp.splat.nxv8f16(half %val, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x half> %splat
}

define <vscale x 16 x half> @vp_splat_nxv16f16(half %val, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vp_splat_nxv16f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; ZVFH-NEXT:    vfmv.v.f v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vp_splat_nxv16f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fmv.x.w a1, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vmv.v.x v8, a1
; ZVFHMIN-NEXT:    ret
;
; ZFMIN-LABEL: vp_splat_nxv16f16:
; ZFMIN:       # %bb.0:
; ZFMIN-NEXT:    fmv.x.h a1, fa0
; ZFMIN-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; ZFMIN-NEXT:    vmv.v.x v8, a1
; ZFMIN-NEXT:    ret
  %splat = call <vscale x 16 x half> @llvm.experimental.vp.splat.nxv16f16(half %val, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x half> %splat
}

define <vscale x 32 x half> @vp_splat_nxv32f16(half %val, <vscale x 32 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vp_splat_nxv32f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; ZVFH-NEXT:    vfmv.v.f v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vp_splat_nxv32f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fmv.x.w a1, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; ZVFHMIN-NEXT:    vmv.v.x v8, a1
; ZVFHMIN-NEXT:    ret
;
; ZFMIN-LABEL: vp_splat_nxv32f16:
; ZFMIN:       # %bb.0:
; ZFMIN-NEXT:    fmv.x.h a1, fa0
; ZFMIN-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; ZFMIN-NEXT:    vmv.v.x v8, a1
; ZFMIN-NEXT:    ret
  %splat = call <vscale x 32 x half> @llvm.experimental.vp.splat.nxv32f16(half %val, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x half> %splat
}

define <vscale x 1 x float> @vp_splat_nxv1f32(float %val, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa0
; CHECK-NEXT:    ret
  %splat = call <vscale x 1 x float> @llvm.experimental.vp.splat.nxv1f32(float %val, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x float> %splat
}

define <vscale x 2 x float> @vp_splat_nxv2f32(float %val, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa0
; CHECK-NEXT:    ret
  %splat = call <vscale x 2 x float> @llvm.experimental.vp.splat.nxv2f32(float %val, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x float> %splat
}

define <vscale x 4 x float> @vp_splat_nxv4f32(float %val, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa0
; CHECK-NEXT:    ret
  %splat = call <vscale x 4 x float> @llvm.experimental.vp.splat.nxv4f32(float %val, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x float> %splat
}

define <vscale x 8 x float> @vp_splat_nxv8f32(float %val, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa0
; CHECK-NEXT:    ret
  %splat = call <vscale x 8 x float> @llvm.experimental.vp.splat.nxv8f32(float %val, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x float> %splat
}

define <vscale x 16 x float> @vp_splat_nxv16f32(float %val, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa0
; CHECK-NEXT:    ret
  %splat = call <vscale x 16 x float> @llvm.experimental.vp.splat.nxv16f32(float %val, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x float> %splat
}

define <vscale x 1 x double> @vp_splat_nxv1f64(double %val, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa0
; CHECK-NEXT:    ret
  %splat = call <vscale x 1 x double> @llvm.experimental.vp.splat.nxv1f64(double %val, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x double> %splat
}

define <vscale x 2 x double> @vp_splat_nxv2f64(double %val, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa0
; CHECK-NEXT:    ret
  %splat = call <vscale x 2 x double> @llvm.experimental.vp.splat.nxv2f64(double %val, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x double> %splat
}

define <vscale x 4 x double> @vp_splat_nxv4f64(double %val, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa0
; CHECK-NEXT:    ret
  %splat = call <vscale x 4 x double> @llvm.experimental.vp.splat.nxv4f64(double %val, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x double> %splat
}

define <vscale x 8 x double> @vp_splat_nxv8f64(double %val, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa0
; CHECK-NEXT:    ret
  %splat = call <vscale x 8 x double> @llvm.experimental.vp.splat.nxv8f64(double %val, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x double> %splat
}

define <vscale x 16 x i31> @vp_splat_nxv16i31(i31 %val, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv16i31:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 16 x i31> @llvm.experimental.vp.splat.nxv16i31(i31 %val, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x i31> %splat
}

define <vscale x 15 x i32> @vp_splat_nxv15i32(i32 %val, <vscale x 15 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv15i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 15 x i32> @llvm.experimental.vp.splat.nxv15i32(i32 %val, <vscale x 15 x i1> %m, i32 %evl)
  ret <vscale x 15 x i32> %splat
}

; Split case.
define <vscale x 32 x i32> @vp_splat_nxv32i32(i32 %val, <vscale x 32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_splat_nxv32i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    sub a3, a1, a2
; CHECK-NEXT:    sltu a4, a1, a3
; CHECK-NEXT:    addi a4, a4, -1
; CHECK-NEXT:    and a3, a4, a3
; CHECK-NEXT:    vsetvli zero, a3, e32, m8, ta, ma
; CHECK-NEXT:    vmv.v.x v16, a0
; CHECK-NEXT:    bltu a1, a2, .LBB45_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, a2
; CHECK-NEXT:  .LBB45_2:
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    ret
  %splat = call <vscale x 32 x i32> @llvm.experimental.vp.splat.nxv32i32(i32 %val, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x i32> %splat
}
