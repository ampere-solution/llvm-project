; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version -5
; RUN: llc %s -mtriple=aarch64 -o - | FileCheck %s

define <4 x i16> @NarrowAShrI32By5(<4 x i32> %x) {
; CHECK-LABEL: NarrowAShrI32By5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrshrn v0.4h, v0.4s, #5
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.aarch64.neon.srshl.v4i32(<4 x i32> %x, <4 x i32>  <i32 -5, i32 -5, i32 -5, i32 -5>)
  %r = tail call <4 x i16> @llvm.aarch64.neon.sqxtn.v4i16(<4 x i32> %s)
  ret <4 x i16> %r
}

define <4 x i16> @NarrowAShrU32By5(<4 x i32> %x) {
; CHECK-LABEL: NarrowAShrU32By5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    srshr v0.4s, v0.4s, #5
; CHECK-NEXT:    uqxtn v0.4h, v0.4s
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.aarch64.neon.srshl.v4i32(<4 x i32> %x, <4 x i32> <i32 -5, i32 -5, i32 -5, i32 -5>)
  %r = tail call <4 x i16> @llvm.aarch64.neon.uqxtn.v4i16(<4 x i32> %s)
  ret <4 x i16> %r
}

define <4 x i16> @NarrowAShrI32By5ToU16(<4 x i32> %x) {
; CHECK-LABEL: NarrowAShrI32By5ToU16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrshrun v0.4h, v0.4s, #5
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.aarch64.neon.srshl.v4i32(<4 x i32> %x, <4 x i32> <i32 -5, i32 -5, i32 -5, i32 -5>)
  %r = tail call <4 x i16> @llvm.aarch64.neon.sqxtun.v4i16(<4 x i32> %s)
  ret <4 x i16> %r
}

define <4 x i16> @NarrowLShrI32By5(<4 x i32> %x) {
; CHECK-LABEL: NarrowLShrI32By5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    urshr v0.4s, v0.4s, #5
; CHECK-NEXT:    sqxtn v0.4h, v0.4s
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.aarch64.neon.urshl.v4i32(<4 x i32> %x, <4 x i32> <i32 -5, i32 -5, i32 -5, i32 -5>)
  %r = tail call <4 x i16> @llvm.aarch64.neon.sqxtn.v4i16(<4 x i32> %s)
  ret <4 x i16> %r
}

define <4 x i16> @NarrowLShrU32By5(<4 x i32> %x) {
; CHECK-LABEL: NarrowLShrU32By5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqrshrn v0.4h, v0.4s, #5
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.aarch64.neon.urshl.v4i32(<4 x i32> %x, <4 x i32> <i32 -5, i32 -5, i32 -5, i32 -5>)
  %r = tail call <4 x i16> @llvm.aarch64.neon.uqxtn.v4i16(<4 x i32> %s)
  ret <4 x i16> %r
}

define <4 x i16> @NarrowLShrI32By5ToU16(<4 x i32> %x) {
; CHECK-LABEL: NarrowLShrI32By5ToU16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    urshr v0.4s, v0.4s, #5
; CHECK-NEXT:    sqxtun v0.4h, v0.4s
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.aarch64.neon.urshl.v4i32(<4 x i32> %x, <4 x i32> <i32 -5, i32 -5, i32 -5, i32 -5>)
  %r = tail call <4 x i16> @llvm.aarch64.neon.sqxtun.v4i16(<4 x i32> %s)
  ret <4 x i16> %r
}


define <2 x i32> @NarrowAShri64By5(<2 x i64> %x) {
; CHECK-LABEL: NarrowAShri64By5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrshrn v0.2s, v0.2d, #5
; CHECK-NEXT:    ret
  %s = call <2 x i64> @llvm.aarch64.neon.srshl.v2i64(<2 x i64> %x, <2 x i64> <i64 -5, i64 -5>)
  %r = tail call <2 x i32> @llvm.aarch64.neon.sqxtn.v2i32(<2 x i64> %s)
  ret <2 x i32> %r
}

define <2 x i32> @NarrowAShrU64By5(<2 x i64> %x) {
; CHECK-LABEL: NarrowAShrU64By5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    srshr v0.2d, v0.2d, #5
; CHECK-NEXT:    uqxtn v0.2s, v0.2d
; CHECK-NEXT:    ret
  %s = call <2 x i64> @llvm.aarch64.neon.srshl.v2i64(<2 x i64> %x, <2 x i64> <i64 -5, i64 -5>)
  %r = tail call <2 x i32> @llvm.aarch64.neon.uqxtn.v2i32(<2 x i64> %s)
  ret <2 x i32> %r
}

define <2 x i32> @NarrowAShri64By5ToU32(<2 x i64> %x) {
; CHECK-LABEL: NarrowAShri64By5ToU32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrshrun v0.2s, v0.2d, #5
; CHECK-NEXT:    ret
  %s = call <2 x i64> @llvm.aarch64.neon.srshl.v2i64(<2 x i64> %x, <2 x i64> <i64 -5, i64 -5>)
  %r = tail call <2 x i32> @llvm.aarch64.neon.sqxtun.v2i32(<2 x i64> %s)
  ret <2 x i32> %r
}

define <2 x i32> @NarrowLShri64By5(<2 x i64> %x) {
; CHECK-LABEL: NarrowLShri64By5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    urshr v0.2d, v0.2d, #5
; CHECK-NEXT:    sqxtn v0.2s, v0.2d
; CHECK-NEXT:    ret
  %s = call <2 x i64> @llvm.aarch64.neon.urshl.v2i64(<2 x i64> %x, <2 x i64> <i64 -5, i64 -5>)
  %r = tail call <2 x i32> @llvm.aarch64.neon.sqxtn.v2i32(<2 x i64> %s)
  ret <2 x i32> %r
}

define <2 x i32> @NarrowLShrU64By5(<2 x i64> %x) {
; CHECK-LABEL: NarrowLShrU64By5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqrshrn v0.2s, v0.2d, #5
; CHECK-NEXT:    ret
  %s = call <2 x i64> @llvm.aarch64.neon.urshl.v2i64(<2 x i64> %x, <2 x i64> <i64 -5, i64 -5>)
  %r = tail call <2 x i32> @llvm.aarch64.neon.uqxtn.v2i32(<2 x i64> %s)
  ret <2 x i32> %r
}

define <2 x i32> @NarrowLShri64By5ToU32(<2 x i64> %x) {
; CHECK-LABEL: NarrowLShri64By5ToU32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    urshr v0.2d, v0.2d, #5
; CHECK-NEXT:    sqxtun v0.2s, v0.2d
; CHECK-NEXT:    ret
  %s = call <2 x i64> @llvm.aarch64.neon.urshl.v2i64(<2 x i64> %x, <2 x i64> <i64 -5, i64 -5>)
  %r = tail call <2 x i32> @llvm.aarch64.neon.sqxtun.v2i32(<2 x i64> %s)
  ret <2 x i32> %r
}


define <8 x i8> @NarrowAShri16By5(<8 x i16> %x) {
; CHECK-LABEL: NarrowAShri16By5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrshrn v0.8b, v0.8h, #5
; CHECK-NEXT:    ret
  %s = call <8 x i16> @llvm.aarch64.neon.srshl.v8i16(<8 x i16> %x, <8 x i16> <i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5>)
  %r = tail call <8 x i8> @llvm.aarch64.neon.sqxtn.v8i8(<8 x i16> %s)
  ret <8 x i8> %r
}

define <8 x i8> @NarrowAShrU16By5(<8 x i16> %x) {
; CHECK-LABEL: NarrowAShrU16By5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    srshr v0.8h, v0.8h, #5
; CHECK-NEXT:    uqxtn v0.8b, v0.8h
; CHECK-NEXT:    ret
  %s = call <8 x i16> @llvm.aarch64.neon.srshl.v8i16(<8 x i16> %x, <8 x i16> <i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5>)
  %r = tail call <8 x i8> @llvm.aarch64.neon.uqxtn.v8i8(<8 x i16> %s)
  ret <8 x i8> %r
}

define <8 x i8> @NarrowAShri16By5ToU8(<8 x i16> %x) {
; CHECK-LABEL: NarrowAShri16By5ToU8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrshrun v0.8b, v0.8h, #5
; CHECK-NEXT:    ret
  %s = call <8 x i16> @llvm.aarch64.neon.srshl.v8i16(<8 x i16> %x, <8 x i16> <i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5>)
  %r = tail call <8 x i8> @llvm.aarch64.neon.sqxtun.v8i8(<8 x i16> %s)
  ret <8 x i8> %r
}

define <8 x i8> @NarrowLShri16By5(<8 x i16> %x) {
; CHECK-LABEL: NarrowLShri16By5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    urshr v0.8h, v0.8h, #5
; CHECK-NEXT:    sqxtn v0.8b, v0.8h
; CHECK-NEXT:    ret
  %s = call <8 x i16> @llvm.aarch64.neon.urshl.v8i16(<8 x i16> %x, <8 x i16> <i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5>)
  %r = tail call <8 x i8> @llvm.aarch64.neon.sqxtn.v8i8(<8 x i16> %s)
  ret <8 x i8> %r
}

define <8 x i8> @NarrowLShrU16By5(<8 x i16> %x) {
; CHECK-LABEL: NarrowLShrU16By5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqrshrn v0.8b, v0.8h, #5
; CHECK-NEXT:    ret
  %s = call <8 x i16> @llvm.aarch64.neon.urshl.v8i16(<8 x i16> %x, <8 x i16> <i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5>)
  %r = tail call <8 x i8> @llvm.aarch64.neon.uqxtn.v8i8(<8 x i16> %s)
  ret <8 x i8> %r
}

define <8 x i8> @NarrowLShri16By5ToU8(<8 x i16> %x) {
; CHECK-LABEL: NarrowLShri16By5ToU8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    urshr v0.8h, v0.8h, #5
; CHECK-NEXT:    sqxtun v0.8b, v0.8h
; CHECK-NEXT:    ret
  %s = call <8 x i16> @llvm.aarch64.neon.urshl.v8i16(<8 x i16> %x, <8 x i16> <i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5>)
  %r = tail call <8 x i8> @llvm.aarch64.neon.sqxtun.v8i8(<8 x i16> %s)
  ret <8 x i8> %r
}





define <4 x i16> @NarrowAShrI32By31(<4 x i32> %x) {
; CHECK-LABEL: NarrowAShrI32By31:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrshrn v0.4h, v0.4s, #16
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.aarch64.neon.srshl(<4 x i32> %x, <4 x i32> <i32 -16, i32 -16, i32 -16, i32 -16>)
  %r = tail call <4 x i16> @llvm.aarch64.neon.sqxtn.v4i16(<4 x i32> %s)
  ret <4 x i16> %r
}

define <4 x i16> @NarrowAShrI32By31ToU16(<4 x i32> %x) {
; CHECK-LABEL: NarrowAShrI32By31ToU16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrshrun v0.4h, v0.4s, #16
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.aarch64.neon.srshl(<4 x i32> %x, <4 x i32> <i32 -16, i32 -16, i32 -16, i32 -16>)
  %r = tail call <4 x i16> @llvm.aarch64.neon.sqxtun.v4i16(<4 x i32> %s)
  ret <4 x i16> %r
}

define <4 x i16> @NarrowLShrU32By31(<4 x i32> %x) {
; CHECK-LABEL: NarrowLShrU32By31:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqrshrn v0.4h, v0.4s, #16
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.aarch64.neon.urshl(<4 x i32> %x, <4 x i32> <i32 -16, i32 -16, i32 -16, i32 -16>)
  %r = tail call <4 x i16> @llvm.aarch64.neon.uqxtn.v4i16(<4 x i32> %s)
  ret <4 x i16> %r
}


define <16 x i8> @signed_minmax_v8i16_to_v16i8(<8 x i16> %x, <8 x i16> %y) {
; CHECK-LABEL: signed_minmax_v8i16_to_v16i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrshrn v0.8b, v0.8h, #5
; CHECK-NEXT:    sqrshrn2 v0.16b, v1.8h, #5
; CHECK-NEXT:    ret
entry:
  %l = call <8 x i16> @llvm.aarch64.neon.srshl(<8 x i16> %x, <8 x i16> <i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5>)
  %h = call <8 x i16> @llvm.aarch64.neon.srshl(<8 x i16> %y, <8 x i16> <i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5>)
  %s = shufflevector <8 x i16> %l, <8 x i16> %h, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %min = call <16 x i16> @llvm.smin.v8i16(<16 x i16> %s, <16 x i16> <i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127>)
  %max = call <16 x i16> @llvm.smax.v8i16(<16 x i16> %min, <16 x i16> <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>)
  %trunc = trunc <16 x i16> %max to <16 x i8>
  ret <16 x i8> %trunc
}

define <16 x i8> @unsigned_minmax_v8i16_to_v16i8(<8 x i16> %x, <8 x i16> %y) {
; CHECK-LABEL: unsigned_minmax_v8i16_to_v16i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uqrshrn v0.8b, v0.8h, #5
; CHECK-NEXT:    uqrshrn2 v0.16b, v1.8h, #5
; CHECK-NEXT:    ret
entry:
  %l = call <8 x i16> @llvm.aarch64.neon.urshl(<8 x i16> %x, <8 x i16> <i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5>)
  %h = call <8 x i16> @llvm.aarch64.neon.urshl(<8 x i16> %y, <8 x i16> <i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5>)
  %s = shufflevector <8 x i16> %l, <8 x i16> %h, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %min = call <16 x i16> @llvm.umin.v8i16(<16 x i16> %s, <16 x i16> <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>)
  %trunc = trunc <16 x i16> %min to <16 x i8>
  ret <16 x i8> %trunc
}

define <16 x i8> @unsigned_signed_minmax_v8i16_to_v16i8(<8 x i16> %x, <8 x i16> %y) {
; CHECK-LABEL: unsigned_signed_minmax_v8i16_to_v16i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrshrun v0.8b, v0.8h, #5
; CHECK-NEXT:    sqrshrun2 v0.16b, v1.8h, #5
; CHECK-NEXT:    ret
entry:
  %l = call <8 x i16> @llvm.aarch64.neon.srshl(<8 x i16> %x, <8 x i16> <i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5>)
  %h = call <8 x i16> @llvm.aarch64.neon.srshl(<8 x i16> %y, <8 x i16> <i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5, i16 -5>)
  %s = shufflevector <8 x i16> %l, <8 x i16> %h, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %max = call <16 x i16> @llvm.smax.v8i16(<16 x i16> %s, <16 x i16> <i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0>)
  %min = call <16 x i16> @llvm.umin.v8i16(<16 x i16> %max, <16 x i16> <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>)
  %trunc = trunc <16 x i16> %min to <16 x i8>
  ret <16 x i8> %trunc
}


define <8 x i16> @signed_minmax_v4i32_to_v8i16(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: signed_minmax_v4i32_to_v8i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrshrn v0.4h, v0.4s, #5
; CHECK-NEXT:    sqrshrn2 v0.8h, v1.4s, #5
; CHECK-NEXT:    ret
entry:
  %l = call <4 x i32> @llvm.aarch64.neon.srshl(<4 x i32> %x, <4 x i32> <i32 -5, i32 -5, i32 -5, i32 -5>)
  %h = call <4 x i32> @llvm.aarch64.neon.srshl(<4 x i32> %y, <4 x i32> <i32 -5, i32 -5, i32 -5, i32 -5>)
  %s = shufflevector <4 x i32> %l, <4 x i32> %h, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %min = call <8 x i32> @llvm.smin.v8i32(<8 x i32> %s, <8 x i32> <i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767>)
  %max = call <8 x i32> @llvm.smax.v8i32(<8 x i32> %min, <8 x i32> <i32 -32768, i32 -32768, i32 -32768, i32 -32768, i32 -32768, i32 -32768, i32 -32768, i32 -32768>)
  %trunc = trunc <8 x i32> %max to <8 x i16>
  ret <8 x i16> %trunc
}

define <8 x i16> @unsigned_minmax_v4i32_to_v8i16(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: unsigned_minmax_v4i32_to_v8i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uqrshrn v0.4h, v0.4s, #5
; CHECK-NEXT:    uqrshrn2 v0.8h, v1.4s, #5
; CHECK-NEXT:    ret
entry:
  %l = call <4 x i32> @llvm.aarch64.neon.urshl(<4 x i32> %x, <4 x i32> <i32 -5, i32 -5, i32 -5, i32 -5>)
  %h = call <4 x i32> @llvm.aarch64.neon.urshl(<4 x i32> %y, <4 x i32> <i32 -5, i32 -5, i32 -5, i32 -5>)
  %s = shufflevector <4 x i32> %l, <4 x i32> %h, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %min = call <8 x i32> @llvm.umin.v8i32(<8 x i32> %s, <8 x i32> <i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535>)
  %trunc = trunc <8 x i32> %min to <8 x i16>
  ret <8 x i16> %trunc
}

define <8 x i16> @unsigned_signed_minmax_v4i32_to_v8i16(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: unsigned_signed_minmax_v4i32_to_v8i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrshrun v0.4h, v0.4s, #5
; CHECK-NEXT:    sqrshrun2 v0.8h, v1.4s, #5
; CHECK-NEXT:    ret
entry:
  %l = call <4 x i32> @llvm.aarch64.neon.srshl(<4 x i32> %x, <4 x i32> <i32 -5, i32 -5, i32 -5, i32 -5>)
  %h = call <4 x i32> @llvm.aarch64.neon.srshl(<4 x i32> %y, <4 x i32> <i32 -5, i32 -5, i32 -5, i32 -5>)
  %s = shufflevector <4 x i32> %l, <4 x i32> %h, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %max = call <8 x i32> @llvm.smax.v8i32(<8 x i32> %s, <8 x i32> <i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>)
  %min = call <8 x i32> @llvm.umin.v8i32(<8 x i32> %max, <8 x i32> <i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535>)
  %trunc = trunc <8 x i32> %min to <8 x i16>
  ret <8 x i16> %trunc
}


define <4 x i32> @signed_minmax_v4i64_to_v8i32(<2 x i64> %x, <2 x i64> %y) {
; CHECK-LABEL: signed_minmax_v4i64_to_v8i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrshrn v0.2s, v0.2d, #5
; CHECK-NEXT:    sqrshrn2 v0.4s, v1.2d, #5
; CHECK-NEXT:    ret
entry:
  %l = call <2 x i64> @llvm.aarch64.neon.srshl.v2i64(<2 x i64> %x, <2 x i64> <i64 -5, i64 -5>)
  %h = call <2 x i64> @llvm.aarch64.neon.srshl.v2i64(<2 x i64> %y, <2 x i64> <i64 -5, i64 -5>)
  %s = shufflevector <2 x i64> %l, <2 x i64> %h, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %min = call <4 x i64> @llvm.smin.v8i64(<4 x i64> %s, <4 x i64> <i64 2147483647, i64 2147483647, i64 2147483647, i64 2147483647>)
  %max = call <4 x i64> @llvm.smax.v8i64(<4 x i64> %min, <4 x i64> <i64 -2147483648, i64 -2147483648, i64 -2147483648, i64 -2147483648>)
  %trunc = trunc <4 x i64> %max to <4 x i32>
  ret <4 x i32> %trunc
}

define <4 x i32> @unsigned_minmax_v4i64_to_v8i32(<2 x i64> %x, <2 x i64> %y) {
; CHECK-LABEL: unsigned_minmax_v4i64_to_v8i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uqrshrn v0.2s, v0.2d, #5
; CHECK-NEXT:    uqrshrn2 v0.4s, v1.2d, #5
; CHECK-NEXT:    ret
entry:
  %l = call <2 x i64> @llvm.aarch64.neon.urshl.v2i64(<2 x i64> %x, <2 x i64> <i64 -5, i64 -5>)
  %h = call <2 x i64> @llvm.aarch64.neon.urshl.v2i64(<2 x i64> %y, <2 x i64> <i64 -5, i64 -5>)
  %s = shufflevector <2 x i64> %l, <2 x i64> %h, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %min = call <4 x i64> @llvm.umin.v8i64(<4 x i64> %s, <4 x i64> <i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295>)
  %trunc = trunc <4 x i64> %min to <4 x i32>
  ret <4 x i32> %trunc
}

define <4 x i32> @unsigned_signed_minmax_v4i64_to_v8i32(<2 x i64> %x, <2 x i64> %y) {
; CHECK-LABEL: unsigned_signed_minmax_v4i64_to_v8i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrshrun v0.2s, v0.2d, #5
; CHECK-NEXT:    sqrshrun2 v0.4s, v1.2d, #5
; CHECK-NEXT:    ret
entry:
  %l = call <2 x i64> @llvm.aarch64.neon.srshl.v2i64(<2 x i64> %x, <2 x i64> <i64 -5, i64 -5>)
  %h = call <2 x i64> @llvm.aarch64.neon.srshl.v2i64(<2 x i64> %y, <2 x i64> <i64 -5, i64 -5>)
  %s = shufflevector <2 x i64> %l, <2 x i64> %h, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %max = call <4 x i64> @llvm.smax.v8i64(<4 x i64> %s, <4 x i64> <i64 0, i64 0, i64 0, i64 0>)
  %min = call <4 x i64> @llvm.umin.v8i64(<4 x i64> %max, <4 x i64> <i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295>)
  %trunc = trunc <4 x i64> %min to <4 x i32>
  ret <4 x i32> %trunc
}