; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mattr=+sve2                          < %s | FileCheck %s --check-prefixes=NOBF16
; RUN: llc -mattr=+sve2 --enable-no-nans-fp-math < %s | FileCheck %s --check-prefixes=NOBF16NNAN
; RUN: llc -mattr=+sve2,+bf16                    < %s | FileCheck %s --check-prefixes=BF16
; RUN: llc -mattr=+sme -force-streaming          < %s | FileCheck %s --check-prefixes=BF16

target triple = "aarch64-unknown-linux-gnu"

define <vscale x 2 x bfloat> @fptrunc_nxv2f64_to_nxv2bf16(<vscale x 2 x double> %a) {
; NOBF16-LABEL: fptrunc_nxv2f64_to_nxv2bf16:
; NOBF16:       // %bb.0:
; NOBF16-NEXT:    ptrue p0.d
; NOBF16-NEXT:    mov z1.s, #32767 // =0x7fff
; NOBF16-NEXT:    fcvtx z0.s, p0/m, z0.d
; NOBF16-NEXT:    lsr z2.s, z0.s, #16
; NOBF16-NEXT:    add z1.s, z0.s, z1.s
; NOBF16-NEXT:    fcmuo p0.s, p0/z, z0.s, z0.s
; NOBF16-NEXT:    orr z0.s, z0.s, #0x400000
; NOBF16-NEXT:    and z2.s, z2.s, #0x1
; NOBF16-NEXT:    add z1.s, z2.s, z1.s
; NOBF16-NEXT:    sel z0.s, p0, z0.s, z1.s
; NOBF16-NEXT:    lsr z0.s, z0.s, #16
; NOBF16-NEXT:    ret
;
; NOBF16NNAN-LABEL: fptrunc_nxv2f64_to_nxv2bf16:
; NOBF16NNAN:       // %bb.0:
; NOBF16NNAN-NEXT:    ptrue p0.d
; NOBF16NNAN-NEXT:    mov z1.s, #32767 // =0x7fff
; NOBF16NNAN-NEXT:    fcvtx z0.s, p0/m, z0.d
; NOBF16NNAN-NEXT:    lsr z2.s, z0.s, #16
; NOBF16NNAN-NEXT:    add z0.s, z0.s, z1.s
; NOBF16NNAN-NEXT:    and z2.s, z2.s, #0x1
; NOBF16NNAN-NEXT:    add z0.s, z2.s, z0.s
; NOBF16NNAN-NEXT:    lsr z0.s, z0.s, #16
; NOBF16NNAN-NEXT:    ret
;
; BF16-LABEL: fptrunc_nxv2f64_to_nxv2bf16:
; BF16:       // %bb.0:
; BF16-NEXT:    ptrue p0.d
; BF16-NEXT:    fcvtx z0.s, p0/m, z0.d
; BF16-NEXT:    bfcvt z0.h, p0/m, z0.s
; BF16-NEXT:    ret
  %res = fptrunc <vscale x 2 x double> %a to <vscale x 2 x bfloat>
  ret <vscale x 2 x bfloat> %res
}

define <vscale x 4 x bfloat> @fptrunc_nxv4f64_to_nxv4bf16(<vscale x 4 x double> %a) {
; NOBF16-LABEL: fptrunc_nxv4f64_to_nxv4bf16:
; NOBF16:       // %bb.0:
; NOBF16-NEXT:    ptrue p0.d
; NOBF16-NEXT:    mov z2.s, #32767 // =0x7fff
; NOBF16-NEXT:    fcvtx z1.s, p0/m, z1.d
; NOBF16-NEXT:    fcvtx z0.s, p0/m, z0.d
; NOBF16-NEXT:    lsr z3.s, z1.s, #16
; NOBF16-NEXT:    lsr z4.s, z0.s, #16
; NOBF16-NEXT:    add z5.s, z1.s, z2.s
; NOBF16-NEXT:    add z2.s, z0.s, z2.s
; NOBF16-NEXT:    fcmuo p1.s, p0/z, z1.s, z1.s
; NOBF16-NEXT:    fcmuo p0.s, p0/z, z0.s, z0.s
; NOBF16-NEXT:    orr z1.s, z1.s, #0x400000
; NOBF16-NEXT:    orr z0.s, z0.s, #0x400000
; NOBF16-NEXT:    and z3.s, z3.s, #0x1
; NOBF16-NEXT:    and z4.s, z4.s, #0x1
; NOBF16-NEXT:    add z3.s, z3.s, z5.s
; NOBF16-NEXT:    add z2.s, z4.s, z2.s
; NOBF16-NEXT:    sel z1.s, p1, z1.s, z3.s
; NOBF16-NEXT:    sel z0.s, p0, z0.s, z2.s
; NOBF16-NEXT:    lsr z1.s, z1.s, #16
; NOBF16-NEXT:    lsr z0.s, z0.s, #16
; NOBF16-NEXT:    uzp1 z0.s, z0.s, z1.s
; NOBF16-NEXT:    ret
;
; NOBF16NNAN-LABEL: fptrunc_nxv4f64_to_nxv4bf16:
; NOBF16NNAN:       // %bb.0:
; NOBF16NNAN-NEXT:    ptrue p0.d
; NOBF16NNAN-NEXT:    mov z2.s, #32767 // =0x7fff
; NOBF16NNAN-NEXT:    fcvtx z1.s, p0/m, z1.d
; NOBF16NNAN-NEXT:    fcvtx z0.s, p0/m, z0.d
; NOBF16NNAN-NEXT:    lsr z3.s, z1.s, #16
; NOBF16NNAN-NEXT:    lsr z4.s, z0.s, #16
; NOBF16NNAN-NEXT:    add z1.s, z1.s, z2.s
; NOBF16NNAN-NEXT:    add z0.s, z0.s, z2.s
; NOBF16NNAN-NEXT:    and z3.s, z3.s, #0x1
; NOBF16NNAN-NEXT:    and z4.s, z4.s, #0x1
; NOBF16NNAN-NEXT:    add z1.s, z3.s, z1.s
; NOBF16NNAN-NEXT:    add z0.s, z4.s, z0.s
; NOBF16NNAN-NEXT:    lsr z1.s, z1.s, #16
; NOBF16NNAN-NEXT:    lsr z0.s, z0.s, #16
; NOBF16NNAN-NEXT:    uzp1 z0.s, z0.s, z1.s
; NOBF16NNAN-NEXT:    ret
;
; BF16-LABEL: fptrunc_nxv4f64_to_nxv4bf16:
; BF16:       // %bb.0:
; BF16-NEXT:    ptrue p0.d
; BF16-NEXT:    fcvtx z1.s, p0/m, z1.d
; BF16-NEXT:    fcvtx z0.s, p0/m, z0.d
; BF16-NEXT:    bfcvt z1.h, p0/m, z1.s
; BF16-NEXT:    bfcvt z0.h, p0/m, z0.s
; BF16-NEXT:    uzp1 z0.s, z0.s, z1.s
; BF16-NEXT:    ret
  %res = fptrunc <vscale x 4 x double> %a to <vscale x 4 x bfloat>
  ret <vscale x 4 x bfloat> %res
}

define <vscale x 8 x bfloat> @fptrunc_nxv8f64_to_nxv8bf16(<vscale x 8 x double> %a) {
; NOBF16-LABEL: fptrunc_nxv8f64_to_nxv8bf16:
; NOBF16:       // %bb.0:
; NOBF16-NEXT:    ptrue p0.d
; NOBF16-NEXT:    mov z4.s, #32767 // =0x7fff
; NOBF16-NEXT:    fcvtx z3.s, p0/m, z3.d
; NOBF16-NEXT:    fcvtx z2.s, p0/m, z2.d
; NOBF16-NEXT:    fcvtx z1.s, p0/m, z1.d
; NOBF16-NEXT:    fcvtx z0.s, p0/m, z0.d
; NOBF16-NEXT:    lsr z5.s, z3.s, #16
; NOBF16-NEXT:    lsr z6.s, z2.s, #16
; NOBF16-NEXT:    lsr z7.s, z1.s, #16
; NOBF16-NEXT:    lsr z24.s, z0.s, #16
; NOBF16-NEXT:    add z25.s, z3.s, z4.s
; NOBF16-NEXT:    add z26.s, z2.s, z4.s
; NOBF16-NEXT:    add z27.s, z1.s, z4.s
; NOBF16-NEXT:    add z4.s, z0.s, z4.s
; NOBF16-NEXT:    fcmuo p1.s, p0/z, z3.s, z3.s
; NOBF16-NEXT:    and z5.s, z5.s, #0x1
; NOBF16-NEXT:    and z6.s, z6.s, #0x1
; NOBF16-NEXT:    and z7.s, z7.s, #0x1
; NOBF16-NEXT:    and z24.s, z24.s, #0x1
; NOBF16-NEXT:    fcmuo p2.s, p0/z, z2.s, z2.s
; NOBF16-NEXT:    fcmuo p3.s, p0/z, z1.s, z1.s
; NOBF16-NEXT:    fcmuo p0.s, p0/z, z0.s, z0.s
; NOBF16-NEXT:    orr z3.s, z3.s, #0x400000
; NOBF16-NEXT:    orr z2.s, z2.s, #0x400000
; NOBF16-NEXT:    add z5.s, z5.s, z25.s
; NOBF16-NEXT:    add z6.s, z6.s, z26.s
; NOBF16-NEXT:    add z7.s, z7.s, z27.s
; NOBF16-NEXT:    add z4.s, z24.s, z4.s
; NOBF16-NEXT:    orr z1.s, z1.s, #0x400000
; NOBF16-NEXT:    orr z0.s, z0.s, #0x400000
; NOBF16-NEXT:    sel z3.s, p1, z3.s, z5.s
; NOBF16-NEXT:    sel z2.s, p2, z2.s, z6.s
; NOBF16-NEXT:    sel z1.s, p3, z1.s, z7.s
; NOBF16-NEXT:    sel z0.s, p0, z0.s, z4.s
; NOBF16-NEXT:    lsr z3.s, z3.s, #16
; NOBF16-NEXT:    lsr z2.s, z2.s, #16
; NOBF16-NEXT:    lsr z1.s, z1.s, #16
; NOBF16-NEXT:    lsr z0.s, z0.s, #16
; NOBF16-NEXT:    uzp1 z2.s, z2.s, z3.s
; NOBF16-NEXT:    uzp1 z0.s, z0.s, z1.s
; NOBF16-NEXT:    uzp1 z0.h, z0.h, z2.h
; NOBF16-NEXT:    ret
;
; NOBF16NNAN-LABEL: fptrunc_nxv8f64_to_nxv8bf16:
; NOBF16NNAN:       // %bb.0:
; NOBF16NNAN-NEXT:    ptrue p0.d
; NOBF16NNAN-NEXT:    mov z4.s, #32767 // =0x7fff
; NOBF16NNAN-NEXT:    fcvtx z3.s, p0/m, z3.d
; NOBF16NNAN-NEXT:    fcvtx z2.s, p0/m, z2.d
; NOBF16NNAN-NEXT:    fcvtx z1.s, p0/m, z1.d
; NOBF16NNAN-NEXT:    fcvtx z0.s, p0/m, z0.d
; NOBF16NNAN-NEXT:    lsr z5.s, z3.s, #16
; NOBF16NNAN-NEXT:    lsr z6.s, z2.s, #16
; NOBF16NNAN-NEXT:    lsr z7.s, z1.s, #16
; NOBF16NNAN-NEXT:    lsr z24.s, z0.s, #16
; NOBF16NNAN-NEXT:    add z3.s, z3.s, z4.s
; NOBF16NNAN-NEXT:    add z2.s, z2.s, z4.s
; NOBF16NNAN-NEXT:    add z1.s, z1.s, z4.s
; NOBF16NNAN-NEXT:    add z0.s, z0.s, z4.s
; NOBF16NNAN-NEXT:    and z5.s, z5.s, #0x1
; NOBF16NNAN-NEXT:    and z6.s, z6.s, #0x1
; NOBF16NNAN-NEXT:    and z7.s, z7.s, #0x1
; NOBF16NNAN-NEXT:    and z24.s, z24.s, #0x1
; NOBF16NNAN-NEXT:    add z3.s, z5.s, z3.s
; NOBF16NNAN-NEXT:    add z2.s, z6.s, z2.s
; NOBF16NNAN-NEXT:    add z1.s, z7.s, z1.s
; NOBF16NNAN-NEXT:    add z0.s, z24.s, z0.s
; NOBF16NNAN-NEXT:    lsr z3.s, z3.s, #16
; NOBF16NNAN-NEXT:    lsr z2.s, z2.s, #16
; NOBF16NNAN-NEXT:    lsr z1.s, z1.s, #16
; NOBF16NNAN-NEXT:    lsr z0.s, z0.s, #16
; NOBF16NNAN-NEXT:    uzp1 z2.s, z2.s, z3.s
; NOBF16NNAN-NEXT:    uzp1 z0.s, z0.s, z1.s
; NOBF16NNAN-NEXT:    uzp1 z0.h, z0.h, z2.h
; NOBF16NNAN-NEXT:    ret
;
; BF16-LABEL: fptrunc_nxv8f64_to_nxv8bf16:
; BF16:       // %bb.0:
; BF16-NEXT:    ptrue p0.d
; BF16-NEXT:    fcvtx z3.s, p0/m, z3.d
; BF16-NEXT:    fcvtx z2.s, p0/m, z2.d
; BF16-NEXT:    fcvtx z1.s, p0/m, z1.d
; BF16-NEXT:    fcvtx z0.s, p0/m, z0.d
; BF16-NEXT:    bfcvt z3.h, p0/m, z3.s
; BF16-NEXT:    bfcvt z2.h, p0/m, z2.s
; BF16-NEXT:    bfcvt z1.h, p0/m, z1.s
; BF16-NEXT:    bfcvt z0.h, p0/m, z0.s
; BF16-NEXT:    uzp1 z2.s, z2.s, z3.s
; BF16-NEXT:    uzp1 z0.s, z0.s, z1.s
; BF16-NEXT:    uzp1 z0.h, z0.h, z2.h
; BF16-NEXT:    ret
  %res = fptrunc <vscale x 8 x double> %a to <vscale x 8 x bfloat>
  ret <vscale x 8 x bfloat> %res
}