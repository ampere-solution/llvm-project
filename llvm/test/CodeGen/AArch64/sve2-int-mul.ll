; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve2 < %s | FileCheck %s

;
; MUL with SPLAT
;
define <vscale x 8 x i16> @mul_i16_imm(<vscale x 8 x i16> %a) {
; CHECK-LABEL: mul_i16_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.h, #255 // =0xff
; CHECK-NEXT:    mul z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %res = mul <vscale x 8 x i16> %a, splat(i16 255)
  ret <vscale x 8 x i16> %res
}

define <vscale x 8 x i16> @mul_i16_imm_neg(<vscale x 8 x i16> %a) {
; CHECK-LABEL: mul_i16_imm_neg:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-200
; CHECK-NEXT:    mov z1.h, w8
; CHECK-NEXT:    mul z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %res = mul <vscale x 8 x i16> %a, splat(i16 -200)
  ret <vscale x 8 x i16> %res
}

define <vscale x 4 x i32> @mul_i32_imm(<vscale x 4 x i32> %a) {
; CHECK-LABEL: mul_i32_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.s, #255 // =0xff
; CHECK-NEXT:    mul z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %res = mul <vscale x 4 x i32> %a, splat(i32 255)
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @mul_i32_imm_neg(<vscale x 4 x i32> %a) {
; CHECK-LABEL: mul_i32_imm_neg:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-200
; CHECK-NEXT:    mov z1.s, w8
; CHECK-NEXT:    mul z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %res = mul <vscale x 4 x i32> %a, splat(i32 -200)
  ret <vscale x 4 x i32> %res
}

define <vscale x 2 x i64> @mul_i64_imm(<vscale x 2 x i64> %a) {
; CHECK-LABEL: mul_i64_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.d, #255 // =0xff
; CHECK-NEXT:    mul z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %res = mul <vscale x 2 x i64> %a, splat(i64 255)
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @mul_i64_imm_neg(<vscale x 2 x i64> %a) {
; CHECK-LABEL: mul_i64_imm_neg:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-200
; CHECK-NEXT:    mov z1.d, x8
; CHECK-NEXT:    mul z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %res = mul <vscale x 2 x i64> %a, splat(i64 -200)
  ret <vscale x 2 x i64> %res
}

;
; MUL (vector, unpredicated)
;
define <vscale x 16 x i8> @mul_i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b) {
; CHECK-LABEL: mul_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul z0.b, z0.b, z1.b
; CHECK-NEXT:    ret
  %res = mul <vscale x 16 x i8> %a, %b
  ret <vscale x 16 x i8> %res
}

define <vscale x 8 x i16> @mul_i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b) {
; CHECK-LABEL: mul_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %res = mul <vscale x 8 x i16> %a, %b
  ret <vscale x 8 x i16> %res
}

define <vscale x 4 x i32> @mul_i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: mul_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %res = mul <vscale x 4 x i32> %a, %b
  ret <vscale x 4 x i32> %res
}

define <vscale x 2 x i64> @mul_i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b) {
; CHECK-LABEL: mul_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %res = mul <vscale x 2 x i64> %a, %b
  ret <vscale x 2 x i64> %res
}

;
; SMULH (vector, unpredicated)
;
define <vscale x 16 x i8> @smulh_i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b) {
; CHECK-LABEL: smulh_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smulh z0.b, z0.b, z1.b
; CHECK-NEXT:    ret
  %sel = call <vscale x 16 x i1> @llvm.aarch64.sve.ptrue.nxv16i1(i32 31)
  %res = call <vscale x 16 x i8> @llvm.aarch64.sve.smulh.u.nxv16i8(<vscale x 16 x i1> %sel, <vscale x 16 x i8> %a,
                                                                   <vscale x 16 x i8> %b)
  ret <vscale x 16 x i8> %res
}

define <vscale x 8 x i16> @smulh_i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b) {
; CHECK-LABEL: smulh_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smulh z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %sel = call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 31)
  %res = call <vscale x 8 x i16> @llvm.aarch64.sve.smulh.u.nxv8i16(<vscale x 8 x i1> %sel, <vscale x 8 x i16> %a,
                                                                   <vscale x 8 x i16> %b)
  ret <vscale x 8 x i16> %res
}

define <vscale x 4 x i32> @smulh_i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: smulh_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smulh z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %sel = call <vscale x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 31)
  %res = call <vscale x 4 x i32> @llvm.aarch64.sve.smulh.u.nxv4i32(<vscale x 4 x i1> %sel, <vscale x 4 x i32> %a,
                                                                   <vscale x 4 x i32> %b)
  ret <vscale x 4 x i32> %res
}

define <vscale x 2 x i64> @smulh_i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b) {
; CHECK-LABEL: smulh_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smulh z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %sel = call <vscale x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 31)
  %res = call <vscale x 2 x i64> @llvm.aarch64.sve.smulh.u.nxv2i64(<vscale x 2 x i1> %sel, <vscale x 2 x i64> %a,
                                                                   <vscale x 2 x i64> %b)
  ret <vscale x 2 x i64> %res
}

;
; UMULH (vector, unpredicated)
;
define <vscale x 16 x i8> @umulh_i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b) {
; CHECK-LABEL: umulh_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    umulh z0.b, z0.b, z1.b
; CHECK-NEXT:    ret
  %sel = call <vscale x 16 x i1> @llvm.aarch64.sve.ptrue.nxv16i1(i32 31)
  %res = call <vscale x 16 x i8> @llvm.aarch64.sve.umulh.u.nxv16i8(<vscale x 16 x i1> %sel, <vscale x 16 x i8> %a,
                                                                   <vscale x 16 x i8> %b)
  ret <vscale x 16 x i8> %res
}

define <vscale x 8 x i16> @umulh_i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b) {
; CHECK-LABEL: umulh_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    umulh z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %sel = call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 31)
  %res = call <vscale x 8 x i16> @llvm.aarch64.sve.umulh.u.nxv8i16(<vscale x 8 x i1> %sel, <vscale x 8 x i16> %a,
                                                                   <vscale x 8 x i16> %b)
  ret <vscale x 8 x i16> %res
}

define <vscale x 4 x i32> @umulh_i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: umulh_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    umulh z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %sel = call <vscale x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 31)
  %res = call <vscale x 4 x i32> @llvm.aarch64.sve.umulh.u.nxv4i32(<vscale x 4 x i1> %sel, <vscale x 4 x i32> %a,
                                                                   <vscale x 4 x i32> %b)
  ret <vscale x 4 x i32> %res
}

define <vscale x 2 x i64> @umulh_i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b) {
; CHECK-LABEL: umulh_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    umulh z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %sel = call <vscale x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 31)
  %res = call <vscale x 2 x i64> @llvm.aarch64.sve.umulh.u.nxv2i64(<vscale x 2 x i1> %sel, <vscale x 2 x i64> %a,
                                                                   <vscale x 2 x i64> %b)
  ret <vscale x 2 x i64> %res
}

;
; PMUL (vector, unpredicated)
;
define <vscale x 16 x i8> @pmul_i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b) {
; CHECK-LABEL: pmul_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    pmul z0.b, z0.b, z1.b
; CHECK-NEXT:    ret
  %res = call <vscale x 16 x i8> @llvm.aarch64.sve.pmul.nxv16i8(<vscale x 16 x i8> %a,
                                                                <vscale x 16 x i8> %b)
  ret <vscale x 16 x i8> %res
}

;
; SQDMULH (vector, unpredicated)
;
define <vscale x 16 x i8> @sqdmulh_i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b) {
; CHECK-LABEL: sqdmulh_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqdmulh z0.b, z0.b, z1.b
; CHECK-NEXT:    ret
  %res = call <vscale x 16 x i8> @llvm.aarch64.sve.sqdmulh.nxv16i8(<vscale x 16 x i8> %a,
                                                                   <vscale x 16 x i8> %b)
  ret <vscale x 16 x i8> %res
}

define <vscale x 8 x i16> @sqdmulh_i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b) {
; CHECK-LABEL: sqdmulh_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqdmulh z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x i16> @llvm.aarch64.sve.sqdmulh.nxv8i16(<vscale x 8 x i16> %a,
                                                                   <vscale x 8 x i16> %b)
  ret <vscale x 8 x i16> %res
}

define <vscale x 4 x i32> @sqdmulh_i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: sqdmulh_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqdmulh z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x i32> @llvm.aarch64.sve.sqdmulh.nxv4i32(<vscale x 4 x i32> %a,
                                                                   <vscale x 4 x i32> %b)
  ret <vscale x 4 x i32> %res
}

define <vscale x 2 x i64> @sqdmulh_i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b) {
; CHECK-LABEL: sqdmulh_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqdmulh z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %res = call <vscale x 2 x i64> @llvm.aarch64.sve.sqdmulh.nxv2i64(<vscale x 2 x i64> %a,
                                                                   <vscale x 2 x i64> %b)
  ret <vscale x 2 x i64> %res
}

;
; SQRDMULH (vector, unpredicated)
;
define <vscale x 16 x i8> @sqrdmulh_i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b) {
; CHECK-LABEL: sqrdmulh_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrdmulh z0.b, z0.b, z1.b
; CHECK-NEXT:    ret
  %res = call <vscale x 16 x i8> @llvm.aarch64.sve.sqrdmulh.nxv16i8(<vscale x 16 x i8> %a,
                                                                    <vscale x 16 x i8> %b)
  ret <vscale x 16 x i8> %res
}

define <vscale x 8 x i16> @sqrdmulh_i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b) {
; CHECK-LABEL: sqrdmulh_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrdmulh z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x i16> @llvm.aarch64.sve.sqrdmulh.nxv8i16(<vscale x 8 x i16> %a,
                                                                    <vscale x 8 x i16> %b)
  ret <vscale x 8 x i16> %res
}

define <vscale x 4 x i32> @sqrdmulh_i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: sqrdmulh_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrdmulh z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x i32> @llvm.aarch64.sve.sqrdmulh.nxv4i32(<vscale x 4 x i32> %a,
                                                                    <vscale x 4 x i32> %b)
  ret <vscale x 4 x i32> %res
}

define <vscale x 2 x i64> @sqrdmulh_i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b) {
; CHECK-LABEL: sqrdmulh_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrdmulh z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %res = call <vscale x 2 x i64> @llvm.aarch64.sve.sqrdmulh.nxv2i64(<vscale x 2 x i64> %a,
                                                                    <vscale x 2 x i64> %b)
  ret <vscale x 2 x i64> %res
}

declare <vscale x 16 x i1> @llvm.aarch64.sve.ptrue.nxv16i1(i32)
declare <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32)
declare <vscale x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32)
declare <vscale x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32)
declare <vscale x 16 x  i8> @llvm.aarch64.sve.smulh.u.nxv16i8(<vscale x 16 x i1>, <vscale x 16 x  i8>, <vscale x 16 x  i8>)
declare <vscale x  8 x i16> @llvm.aarch64.sve.smulh.u.nxv8i16(<vscale x  8 x i1>, <vscale x  8 x i16>, <vscale x  8 x i16>)
declare <vscale x  4 x i32> @llvm.aarch64.sve.smulh.u.nxv4i32(<vscale x  4 x i1>, <vscale x  4 x i32>, <vscale x  4 x i32>)
declare <vscale x  2 x i64> @llvm.aarch64.sve.smulh.u.nxv2i64(<vscale x  2 x i1>, <vscale x  2 x i64>, <vscale x  2 x i64>)
declare <vscale x 16 x  i8> @llvm.aarch64.sve.umulh.u.nxv16i8(<vscale x 16 x i1>, <vscale x 16 x  i8>, <vscale x 16 x  i8>)
declare <vscale x  8 x i16> @llvm.aarch64.sve.umulh.u.nxv8i16(<vscale x  8 x i1>, <vscale x  8 x i16>, <vscale x  8 x i16>)
declare <vscale x  4 x i32> @llvm.aarch64.sve.umulh.u.nxv4i32(<vscale x  4 x i1>, <vscale x  4 x i32>, <vscale x  4 x i32>)
declare <vscale x  2 x i64> @llvm.aarch64.sve.umulh.u.nxv2i64(<vscale x  2 x i1>, <vscale x  2 x i64>, <vscale x  2 x i64>)
declare <vscale x 16 x i8> @llvm.aarch64.sve.pmul.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i8>)
declare <vscale x 16 x i8> @llvm.aarch64.sve.sqdmulh.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i8>)
declare <vscale x 8 x i16> @llvm.aarch64.sve.sqdmulh.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i16>)
declare <vscale x 4 x i32> @llvm.aarch64.sve.sqdmulh.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>)
declare <vscale x 2 x i64> @llvm.aarch64.sve.sqdmulh.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>)
declare <vscale x 16 x i8> @llvm.aarch64.sve.sqrdmulh.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i8>)
declare <vscale x 8 x i16> @llvm.aarch64.sve.sqrdmulh.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i16>)
declare <vscale x 4 x i32> @llvm.aarch64.sve.sqrdmulh.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>)
declare <vscale x 2 x i64> @llvm.aarch64.sve.sqrdmulh.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>)