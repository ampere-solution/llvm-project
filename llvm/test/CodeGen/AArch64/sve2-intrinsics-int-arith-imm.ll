; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve2 < %s | FileCheck %s

; SQADD

define <vscale x 16 x i8> @sqadd_b_lowimm(<vscale x 16 x i8> %a) {
; CHECK-LABEL: sqadd_b_lowimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqadd z0.b, z0.b, #27 // =0x1b
; CHECK-NEXT:    ret
  %pg = call <vscale x 16 x i1> @llvm.aarch64.sve.ptrue.nxv16i1(i32 31)
  %out = call <vscale x 16 x i8> @llvm.aarch64.sve.sqadd.nxv16i8(<vscale x 16 x i1> %pg,
                                                                 <vscale x 16 x i8> %a,
                                                                 <vscale x 16 x i8> splat(i8 27))
  ret <vscale x 16 x i8> %out
}

define <vscale x 8 x i16> @sqadd_h_lowimm(<vscale x 8 x i16> %a) {
; CHECK-LABEL: sqadd_h_lowimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqadd z0.h, z0.h, #43 // =0x2b
; CHECK-NEXT:    ret
  %pg = call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 31)
  %out = call <vscale x 8 x i16> @llvm.aarch64.sve.sqadd.nxv8i16(<vscale x 8 x i1> %pg,
                                                                 <vscale x 8 x i16> %a,
                                                                 <vscale x 8 x i16> splat(i16 43))
  ret <vscale x 8 x i16> %out
}

define <vscale x 8 x i16> @sqadd_h_highimm(<vscale x 8 x i16> %a) {
; CHECK-LABEL: sqadd_h_highimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqadd z0.h, z0.h, #2048 // =0x800
; CHECK-NEXT:    ret
  %pg = call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 31)
  %out = call <vscale x 8 x i16> @llvm.aarch64.sve.sqadd.nxv8i16(<vscale x 8 x i1> %pg,
                                                                 <vscale x 8 x i16> %a,
                                                                 <vscale x 8 x i16> splat(i16 2048))
  ret <vscale x 8 x i16> %out
}

define <vscale x 4 x i32> @sqadd_s_lowimm(<vscale x 4 x i32> %a) {
; CHECK-LABEL: sqadd_s_lowimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqadd z0.s, z0.s, #1 // =0x1
; CHECK-NEXT:    ret
  %pg = call <vscale x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 31)
  %out = call <vscale x 4 x i32> @llvm.aarch64.sve.sqadd.nxv4i32(<vscale x 4 x i1> %pg,
                                                                 <vscale x 4 x i32> %a,
                                                                 <vscale x 4 x i32> splat(i32 1))
  ret <vscale x 4 x i32> %out
}

define <vscale x 4 x i32> @sqadd_s_highimm(<vscale x 4 x i32> %a) {
; CHECK-LABEL: sqadd_s_highimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqadd z0.s, z0.s, #8192 // =0x2000
; CHECK-NEXT:    ret
  %pg = call <vscale x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 31)
  %out = call <vscale x 4 x i32> @llvm.aarch64.sve.sqadd.nxv4i32(<vscale x 4 x i1> %pg,
                                                                 <vscale x 4 x i32> %a,
                                                                 <vscale x 4 x i32> splat(i32 8192))
  ret <vscale x 4 x i32> %out
}

define <vscale x 2 x i64> @sqadd_d_lowimm(<vscale x 2 x i64> %a) {
; CHECK-LABEL: sqadd_d_lowimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqadd z0.d, z0.d, #255 // =0xff
; CHECK-NEXT:    ret
  %pg = call <vscale x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 31)
  %out = call <vscale x 2 x i64> @llvm.aarch64.sve.sqadd.nxv2i64(<vscale x 2 x i1> %pg,
                                                                 <vscale x 2 x i64> %a,
                                                                 <vscale x 2 x i64> splat(i64 255))
  ret <vscale x 2 x i64> %out
}

define <vscale x 2 x i64> @sqadd_d_highimm(<vscale x 2 x i64> %a) {
; CHECK-LABEL: sqadd_d_highimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqadd z0.d, z0.d, #65280 // =0xff00
; CHECK-NEXT:    ret
  %pg = call <vscale x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 31)
  %out = call <vscale x 2 x i64> @llvm.aarch64.sve.sqadd.nxv2i64(<vscale x 2 x i1> %pg,
                                                                 <vscale x 2 x i64> %a,
                                                                 <vscale x 2 x i64> splat(i64 65280))
  ret <vscale x 2 x i64> %out
}

; SQSUB

define <vscale x 16 x i8> @sqsub_b_lowimm(<vscale x 16 x i8> %a) {
; CHECK-LABEL: sqsub_b_lowimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqsub z0.b, z0.b, #27 // =0x1b
; CHECK-NEXT:    ret
  %pg = call <vscale x 16 x i1> @llvm.aarch64.sve.ptrue.nxv16i1(i32 31)
  %out = call <vscale x 16 x i8> @llvm.aarch64.sve.sqsub.u.nxv16i8(<vscale x 16 x i1> %pg,
                                                                   <vscale x 16 x i8> %a,
                                                                   <vscale x 16 x i8> splat(i8 27))
  ret <vscale x 16 x i8> %out
}

define <vscale x 8 x i16> @sqsub_h_lowimm(<vscale x 8 x i16> %a) {
; CHECK-LABEL: sqsub_h_lowimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqsub z0.h, z0.h, #43 // =0x2b
; CHECK-NEXT:    ret
  %pg = call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 31)
  %out = call <vscale x 8 x i16> @llvm.aarch64.sve.sqsub.u.nxv8i16(<vscale x 8 x i1> %pg,
                                                                   <vscale x 8 x i16> %a,
                                                                   <vscale x 8 x i16> splat(i16 43))
  ret <vscale x 8 x i16> %out
}

define <vscale x 8 x i16> @sqsub_h_highimm(<vscale x 8 x i16> %a) {
; CHECK-LABEL: sqsub_h_highimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqsub z0.h, z0.h, #2048 // =0x800
; CHECK-NEXT:    ret
  %pg = call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 31)
  %out = call <vscale x 8 x i16> @llvm.aarch64.sve.sqsub.u.nxv8i16(<vscale x 8 x i1> %pg,
                                                                   <vscale x 8 x i16> %a,
                                                                   <vscale x 8 x i16> splat(i16 2048))
  ret <vscale x 8 x i16> %out
}

define <vscale x 4 x i32> @sqsub_s_lowimm(<vscale x 4 x i32> %a) {
; CHECK-LABEL: sqsub_s_lowimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqsub z0.s, z0.s, #1 // =0x1
; CHECK-NEXT:    ret
  %pg = call <vscale x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 31)
  %out = call <vscale x 4 x i32> @llvm.aarch64.sve.sqsub.u.nxv4i32(<vscale x 4 x i1> %pg,
                                                                   <vscale x 4 x i32> %a,
                                                                   <vscale x 4 x i32> splat(i32 1))
  ret <vscale x 4 x i32> %out
}

define <vscale x 4 x i32> @sqsub_s_highimm(<vscale x 4 x i32> %a) {
; CHECK-LABEL: sqsub_s_highimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqsub z0.s, z0.s, #8192 // =0x2000
; CHECK-NEXT:    ret
  %pg = call <vscale x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 31)
  %out = call <vscale x 4 x i32> @llvm.aarch64.sve.sqsub.u.nxv4i32(<vscale x 4 x i1> %pg,
                                                                   <vscale x 4 x i32> %a,
                                                                   <vscale x 4 x i32> splat(i32 8192))
  ret <vscale x 4 x i32> %out
}

define <vscale x 2 x i64> @sqsub_d_lowimm(<vscale x 2 x i64> %a) {
; CHECK-LABEL: sqsub_d_lowimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqsub z0.d, z0.d, #255 // =0xff
; CHECK-NEXT:    ret
  %pg = call <vscale x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 31)
  %out = call <vscale x 2 x i64> @llvm.aarch64.sve.sqsub.u.nxv2i64(<vscale x 2 x i1> %pg,
                                                                   <vscale x 2 x i64> %a,
                                                                   <vscale x 2 x i64> splat(i64 255))
  ret <vscale x 2 x i64> %out
}

define <vscale x 2 x i64> @sqsub_d_highimm(<vscale x 2 x i64> %a) {
; CHECK-LABEL: sqsub_d_highimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqsub z0.d, z0.d, #65280 // =0xff00
; CHECK-NEXT:    ret
  %pg = call <vscale x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 31)
  %out = call <vscale x 2 x i64> @llvm.aarch64.sve.sqsub.u.nxv2i64(<vscale x 2 x i1> %pg,
                                                                   <vscale x 2 x i64> %a,
                                                                   <vscale x 2 x i64> splat(i64 65280))
  ret <vscale x 2 x i64> %out
}

; UQADD

define <vscale x 16 x i8> @uqadd_b_lowimm(<vscale x 16 x i8> %a) {
; CHECK-LABEL: uqadd_b_lowimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqadd z0.b, z0.b, #27 // =0x1b
; CHECK-NEXT:    ret
  %pg = call <vscale x 16 x i1> @llvm.aarch64.sve.ptrue.nxv16i1(i32 31)
  %out = call <vscale x 16 x i8> @llvm.aarch64.sve.uqadd.nxv16i8(<vscale x 16 x i1> %pg,
                                                                 <vscale x 16 x i8> %a,
                                                                 <vscale x 16 x i8> splat(i8 27))
  ret <vscale x 16 x i8> %out
}

define <vscale x 8 x i16> @uqadd_h_lowimm(<vscale x 8 x i16> %a) {
; CHECK-LABEL: uqadd_h_lowimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqadd z0.h, z0.h, #43 // =0x2b
; CHECK-NEXT:    ret
  %pg = call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 31)
  %out = call <vscale x 8 x i16> @llvm.aarch64.sve.uqadd.nxv8i16(<vscale x 8 x i1> %pg,
                                                                 <vscale x 8 x i16> %a,
                                                                 <vscale x 8 x i16> splat(i16 43))
  ret <vscale x 8 x i16> %out
}

define <vscale x 8 x i16> @uqadd_h_highimm(<vscale x 8 x i16> %a) {
; CHECK-LABEL: uqadd_h_highimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqadd z0.h, z0.h, #2048 // =0x800
; CHECK-NEXT:    ret
  %pg = call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 31)
  %out = call <vscale x 8 x i16> @llvm.aarch64.sve.uqadd.nxv8i16(<vscale x 8 x i1> %pg,
                                                                 <vscale x 8 x i16> %a,
                                                                 <vscale x 8 x i16> splat(i16 2048))
  ret <vscale x 8 x i16> %out
}

define <vscale x 4 x i32> @uqadd_s_lowimm(<vscale x 4 x i32> %a) {
; CHECK-LABEL: uqadd_s_lowimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqadd z0.s, z0.s, #1 // =0x1
; CHECK-NEXT:    ret
  %pg = call <vscale x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 31)
  %out = call <vscale x 4 x i32> @llvm.aarch64.sve.uqadd.nxv4i32(<vscale x 4 x i1> %pg,
                                                                 <vscale x 4 x i32> %a,
                                                                 <vscale x 4 x i32> splat(i32 1))
  ret <vscale x 4 x i32> %out
}

define <vscale x 4 x i32> @uqadd_s_highimm(<vscale x 4 x i32> %a) {
; CHECK-LABEL: uqadd_s_highimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqadd z0.s, z0.s, #8192 // =0x2000
; CHECK-NEXT:    ret
  %pg = call <vscale x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 31)
  %out = call <vscale x 4 x i32> @llvm.aarch64.sve.uqadd.nxv4i32(<vscale x 4 x i1> %pg,
                                                                 <vscale x 4 x i32> %a,
                                                                 <vscale x 4 x i32> splat(i32 8192))
  ret <vscale x 4 x i32> %out
}

define <vscale x 2 x i64> @uqadd_d_lowimm(<vscale x 2 x i64> %a) {
; CHECK-LABEL: uqadd_d_lowimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqadd z0.d, z0.d, #255 // =0xff
; CHECK-NEXT:    ret
  %pg = call <vscale x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 31)
  %out = call <vscale x 2 x i64> @llvm.aarch64.sve.uqadd.nxv2i64(<vscale x 2 x i1> %pg,
                                                                 <vscale x 2 x i64> %a,
                                                                 <vscale x 2 x i64> splat(i64 255))
  ret <vscale x 2 x i64> %out
}

define <vscale x 2 x i64> @uqadd_d_highimm(<vscale x 2 x i64> %a) {
; CHECK-LABEL: uqadd_d_highimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqadd z0.d, z0.d, #65280 // =0xff00
; CHECK-NEXT:    ret
  %pg = call <vscale x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 31)
  %out = call <vscale x 2 x i64> @llvm.aarch64.sve.uqadd.nxv2i64(<vscale x 2 x i1> %pg,
                                                                 <vscale x 2 x i64> %a,
                                                                 <vscale x 2 x i64> splat(i64 65280))
  ret <vscale x 2 x i64> %out
}

; UQSUB

define <vscale x 16 x i8> @uqsub_b_lowimm(<vscale x 16 x i8> %a) {
; CHECK-LABEL: uqsub_b_lowimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqsub z0.b, z0.b, #27 // =0x1b
; CHECK-NEXT:    ret
  %pg = call <vscale x 16 x i1> @llvm.aarch64.sve.ptrue.nxv16i1(i32 31)
  %out = call <vscale x 16 x i8> @llvm.aarch64.sve.uqsub.u.nxv16i8(<vscale x 16 x i1> %pg,
                                                                   <vscale x 16 x i8> %a,
                                                                   <vscale x 16 x i8> splat(i8 27))
  ret <vscale x 16 x i8> %out
}

define <vscale x 8 x i16> @uqsub_h_lowimm(<vscale x 8 x i16> %a) {
; CHECK-LABEL: uqsub_h_lowimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqsub z0.h, z0.h, #43 // =0x2b
; CHECK-NEXT:    ret
  %pg = call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 31)
  %out = call <vscale x 8 x i16> @llvm.aarch64.sve.uqsub.u.nxv8i16(<vscale x 8 x i1> %pg,
                                                                   <vscale x 8 x i16> %a,
                                                                   <vscale x 8 x i16> splat(i16 43))
  ret <vscale x 8 x i16> %out
}

define <vscale x 8 x i16> @uqsub_h_highimm(<vscale x 8 x i16> %a) {
; CHECK-LABEL: uqsub_h_highimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqsub z0.h, z0.h, #2048 // =0x800
; CHECK-NEXT:    ret
  %pg = call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 31)
  %out = call <vscale x 8 x i16> @llvm.aarch64.sve.uqsub.u.nxv8i16(<vscale x 8 x i1> %pg,
                                                                   <vscale x 8 x i16> %a,
                                                                   <vscale x 8 x i16> splat(i16 2048))
  ret <vscale x 8 x i16> %out
}

define <vscale x 4 x i32> @uqsub_s_lowimm(<vscale x 4 x i32> %a) {
; CHECK-LABEL: uqsub_s_lowimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqsub z0.s, z0.s, #1 // =0x1
; CHECK-NEXT:    ret
  %pg = call <vscale x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 31)
  %out = call <vscale x 4 x i32> @llvm.aarch64.sve.uqsub.u.nxv4i32(<vscale x 4 x i1> %pg,
                                                                   <vscale x 4 x i32> %a,
                                                                   <vscale x 4 x i32> splat(i32 1))
  ret <vscale x 4 x i32> %out
}

define <vscale x 4 x i32> @uqsub_s_highimm(<vscale x 4 x i32> %a) {
; CHECK-LABEL: uqsub_s_highimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqsub z0.s, z0.s, #8192 // =0x2000
; CHECK-NEXT:    ret
  %pg = call <vscale x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 31)
  %out = call <vscale x 4 x i32> @llvm.aarch64.sve.uqsub.u.nxv4i32(<vscale x 4 x i1> %pg,
                                                                   <vscale x 4 x i32> %a,
                                                                   <vscale x 4 x i32> splat(i32 8192))
  ret <vscale x 4 x i32> %out
}

define <vscale x 2 x i64> @uqsub_d_lowimm(<vscale x 2 x i64> %a) {
; CHECK-LABEL: uqsub_d_lowimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqsub z0.d, z0.d, #255 // =0xff
; CHECK-NEXT:    ret
  %pg = call <vscale x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 31)
  %out = call <vscale x 2 x i64> @llvm.aarch64.sve.uqsub.u.nxv2i64(<vscale x 2 x i1> %pg,
                                                                   <vscale x 2 x i64> %a,
                                                                   <vscale x 2 x i64> splat(i64 255))
  ret <vscale x 2 x i64> %out
}

define <vscale x 2 x i64> @uqsub_d_highimm(<vscale x 2 x i64> %a) {
; CHECK-LABEL: uqsub_d_highimm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqsub z0.d, z0.d, #65280 // =0xff00
; CHECK-NEXT:    ret
  %pg = call <vscale x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 31)
  %out = call <vscale x 2 x i64> @llvm.aarch64.sve.uqsub.u.nxv2i64(<vscale x 2 x i1> %pg,
                                                                   <vscale x 2 x i64> %a,
                                                                   <vscale x 2 x i64> splat(i64 65280))
  ret <vscale x 2 x i64> %out
}

; As uqsub_i32 but where pg is i8 based and thus compatible for i32.
define <vscale x 4 x i32> @uqsub_i32_ptrue_all_b(<vscale x 4 x i32> %a) #0 {
; CHECK-LABEL: uqsub_i32_ptrue_all_b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqsub z0.s, z0.s, #1 // =0x1
; CHECK-NEXT:    ret
  %pg.b = tail call <vscale x 16 x i1> @llvm.aarch64.sve.ptrue.nxv16i1(i32 31)
  %pg.s = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> %pg.b)
  %b = tail call <vscale x 4 x i32> @llvm.aarch64.sve.dup.x.nxv4i32(i32 1)
  %out = tail call <vscale x 4 x i32> @llvm.aarch64.sve.uqsub.u.nxv4i32(<vscale x 4 x i1> %pg.s,
                                                                        <vscale x 4 x i32> %a,
                                                                        <vscale x 4 x i32> %b)
  ret <vscale x 4 x i32> %out
}

; As uqsub_i32 but where pg is i16 based and thus compatible for i32.
define <vscale x 4 x i32> @uqsub_i32_ptrue_all_h(<vscale x 4 x i32> %a) #0 {
; CHECK-LABEL: uqsub_i32_ptrue_all_h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqsub z0.s, z0.s, #1 // =0x1
; CHECK-NEXT:    ret
  %pg.h = tail call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 31)
  %pg.b = tail call <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv8i1(<vscale x 8 x i1> %pg.h)
  %pg.s = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> %pg.b)
  %b = tail call <vscale x 4 x i32> @llvm.aarch64.sve.dup.x.nxv4i32(i32 1)
  %out = tail call <vscale x 4 x i32> @llvm.aarch64.sve.uqsub.u.nxv4i32(<vscale x 4 x i1> %pg.s,
                                                                        <vscale x 4 x i32> %a,
                                                                        <vscale x 4 x i32> %b)
  ret <vscale x 4 x i32> %out
}

; As uqsub_i32 but where pg is i64 based, which is not compatibile for i32 and
; thus inactive lanes are important and the immediate form cannot be used.
define <vscale x 4 x i32> @uqsub_i32_ptrue_all_d(<vscale x 4 x i32> %a) #0 {
; CHECK-LABEL: uqsub_i32_ptrue_all_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.s, #1 // =0x1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    uqsub z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT:    ret
  %pg.d = tail call <vscale x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 31)
  %pg.b = tail call <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv2i1(<vscale x 2 x i1> %pg.d)
  %pg.s = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> %pg.b)
  %b = tail call <vscale x 4 x i32> @llvm.aarch64.sve.dup.x.nxv4i32(i32 1)
  %out = tail call <vscale x 4 x i32> @llvm.aarch64.sve.uqsub.nxv4i32(<vscale x 4 x i1> %pg.s,
                                                                      <vscale x 4 x i32> %a,
                                                                      <vscale x 4 x i32> %b)
  ret <vscale x 4 x i32> %out
}

declare <vscale x 16 x i8> @llvm.aarch64.sve.sqadd.nxv16i8(<vscale x 16 x i1>, <vscale x 16 x i8>, <vscale x 16 x i8>)
declare <vscale x 8 x i16> @llvm.aarch64.sve.sqadd.nxv8i16(<vscale x 8 x i1>, <vscale x 8 x i16>, <vscale x 8 x i16>)
declare <vscale x 4 x i32> @llvm.aarch64.sve.sqadd.nxv4i32(<vscale x 4 x i1>, <vscale x 4 x i32>, <vscale x 4 x i32>)
declare <vscale x 2 x i64> @llvm.aarch64.sve.sqadd.nxv2i64(<vscale x 2 x i1>, <vscale x 2 x i64>, <vscale x 2 x i64>)

declare <vscale x 16 x i8> @llvm.aarch64.sve.sqsub.u.nxv16i8(<vscale x 16 x i1>, <vscale x 16 x i8>, <vscale x 16 x i8>)
declare <vscale x 8 x i16> @llvm.aarch64.sve.sqsub.u.nxv8i16(<vscale x 8 x i1>, <vscale x 8 x i16>, <vscale x 8 x i16>)
declare <vscale x 4 x i32> @llvm.aarch64.sve.sqsub.u.nxv4i32(<vscale x 4 x i1>, <vscale x 4 x i32>, <vscale x 4 x i32>)
declare <vscale x 2 x i64> @llvm.aarch64.sve.sqsub.u.nxv2i64(<vscale x 2 x i1>, <vscale x 2 x i64>, <vscale x 2 x i64>)

declare <vscale x 16 x i8> @llvm.aarch64.sve.uqadd.nxv16i8(<vscale x 16 x i1>, <vscale x 16 x i8>, <vscale x 16 x i8>)
declare <vscale x 8 x i16> @llvm.aarch64.sve.uqadd.nxv8i16(<vscale x 8 x i1>, <vscale x 8 x i16>, <vscale x 8 x i16>)
declare <vscale x 4 x i32> @llvm.aarch64.sve.uqadd.nxv4i32(<vscale x 4 x i1>, <vscale x 4 x i32>, <vscale x 4 x i32>)
declare <vscale x 2 x i64> @llvm.aarch64.sve.uqadd.nxv2i64(<vscale x 2 x i1>, <vscale x 2 x i64>, <vscale x 2 x i64>)

declare <vscale x 4 x i32> @llvm.aarch64.sve.uqsub.nxv4i32(<vscale x 4 x i1>, <vscale x 4 x i32>, <vscale x 4 x i32>)

declare <vscale x 16 x i8> @llvm.aarch64.sve.uqsub.u.nxv16i8(<vscale x 16 x i1>, <vscale x 16 x i8>, <vscale x 16 x i8>)
declare <vscale x 8 x i16> @llvm.aarch64.sve.uqsub.u.nxv8i16(<vscale x 8 x i1>, <vscale x 8 x i16>, <vscale x 8 x i16>)
declare <vscale x 4 x i32> @llvm.aarch64.sve.uqsub.u.nxv4i32(<vscale x 4 x i1>, <vscale x 4 x i32>, <vscale x 4 x i32>)
declare <vscale x 2 x i64> @llvm.aarch64.sve.uqsub.u.nxv2i64(<vscale x 2 x i1>, <vscale x 2 x i64>, <vscale x 2 x i64>)

declare <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1>)
declare <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1>)
declare <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1>)

declare <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv4i1(<vscale x 16 x i1>)
declare <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv8i1(<vscale x 8 x i1>)
declare <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv2i1(<vscale x 2 x i1>)

declare <vscale x 4 x i32> @llvm.aarch64.sve.dup.x.nxv4i32(i32)

declare <vscale x 16 x i1> @llvm.aarch64.sve.ptrue.nxv16i1(i32 %pattern)
declare <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 %pattern)
declare <vscale x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 %pattern)
declare <vscale x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 %pattern)