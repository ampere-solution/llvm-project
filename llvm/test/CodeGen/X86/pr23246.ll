; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple x86_64-unknown-unknown -mattr=mmx | FileCheck %s

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"

; PR23246
; We're really only interested in doing something sane with the shuffle.

define <2 x i64> @test(<1 x i64> %a) #0 {
; CHECK-LABEL: test:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rdi, %xmm0
; CHECK-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,1,0,1]
; CHECK-NEXT:    retq
entry:
  %s = shufflevector <1 x i64> %a, <1 x i64> undef, <2 x i32> <i32 undef, i32 0>
  ret <2 x i64> %s
}

attributes #0 = { nounwind }