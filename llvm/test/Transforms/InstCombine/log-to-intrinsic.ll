; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S -passes=instcombine < %s | FileCheck %s

define float @test_logf_pos(float %f) {
; CHECK-LABEL: define float @test_logf_pos(
; CHECK-SAME: float [[F:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[ISINF:%.*]] = fcmp ugt float [[F]], 0.000000e+00
; CHECK-NEXT:    br i1 [[ISINF]], label %[[IF_END:.*]], label %[[RETURN:.*]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    [[CALL:%.*]] = tail call float @llvm.log.f32(float [[F]])
; CHECK-NEXT:    ret float [[CALL]]
; CHECK:       [[RETURN]]:
; CHECK-NEXT:    ret float 0.000000e+00
;
entry:
  %isinf = fcmp ole float %f, 0x0000000000000000
  br i1 %isinf, label %return, label %if.end

if.end:
  %call = tail call float @logf(float %f)
  ret float %call

return:
  ret float 0.0
}

define double @test_log_pos(double %f) {
; CHECK-LABEL: define double @test_log_pos(
; CHECK-SAME: double [[F:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[ISINF:%.*]] = fcmp ugt double [[F]], 0.000000e+00
; CHECK-NEXT:    br i1 [[ISINF]], label %[[IF_END:.*]], label %[[RETURN:.*]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    [[CALL:%.*]] = tail call double @llvm.log.f64(double [[F]])
; CHECK-NEXT:    ret double [[CALL]]
; CHECK:       [[RETURN]]:
; CHECK-NEXT:    ret double 0.000000e+00
;
entry:
  %isinf = fcmp ole double %f, 0x0000000000000000
  br i1 %isinf, label %return, label %if.end

if.end:
  %call = tail call double @log(double %f)
  ret double %call

return:
  ret double 0.0
}

define fp128 @test_logl_pos(fp128 %f) {
; CHECK-LABEL: define fp128 @test_logl_pos(
; CHECK-SAME: fp128 [[F:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[ISINF:%.*]] = fcmp ugt fp128 [[F]], 0xL00000000000000000000000000000000
; CHECK-NEXT:    br i1 [[ISINF]], label %[[IF_END:.*]], label %[[RETURN:.*]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    [[CALL:%.*]] = tail call fp128 @llvm.log.f128(fp128 [[F]])
; CHECK-NEXT:    ret fp128 [[CALL]]
; CHECK:       [[RETURN]]:
; CHECK-NEXT:    ret fp128 0xL00000000000000000000000000000000
;
entry:
  %isinf = fcmp ole fp128 %f, 0xL00000000000000000000000000000000
  br i1 %isinf, label %return, label %if.end

if.end:
  %call = tail call fp128 @logl(fp128 %f)
  ret fp128 %call

return:
  ret fp128 0xL00000000000000000000000000000000
}

define float @test_log10f_pos(float %f) {
; CHECK-LABEL: define float @test_log10f_pos(
; CHECK-SAME: float [[F:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[ISINF:%.*]] = fcmp ugt float [[F]], 0.000000e+00
; CHECK-NEXT:    br i1 [[ISINF]], label %[[IF_END:.*]], label %[[RETURN:.*]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    [[CALL:%.*]] = tail call float @llvm.log10.f32(float [[F]])
; CHECK-NEXT:    ret float [[CALL]]
; CHECK:       [[RETURN]]:
; CHECK-NEXT:    ret float 0.000000e+00
;
entry:
  %isinf = fcmp ole float %f, 0x0000000000000000
  br i1 %isinf, label %return, label %if.end

if.end:
  %call = tail call float @log10f(float %f)
  ret float %call

return:
  ret float 0.0
}

define double @test_log10_pos(double %f) {
; CHECK-LABEL: define double @test_log10_pos(
; CHECK-SAME: double [[F:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[ISINF:%.*]] = fcmp ugt double [[F]], 0.000000e+00
; CHECK-NEXT:    br i1 [[ISINF]], label %[[IF_END:.*]], label %[[RETURN:.*]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    [[CALL:%.*]] = tail call double @llvm.log10.f64(double [[F]])
; CHECK-NEXT:    ret double [[CALL]]
; CHECK:       [[RETURN]]:
; CHECK-NEXT:    ret double 0.000000e+00
;
entry:
  %isinf = fcmp ole double %f, 0x0000000000000000
  br i1 %isinf, label %return, label %if.end

if.end:
  %call = tail call double @log10(double %f)
  ret double %call

return:
  ret double 0.0
}

define fp128 @test_log10l_pos(fp128 %f) {
; CHECK-LABEL: define fp128 @test_log10l_pos(
; CHECK-SAME: fp128 [[F:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[ISINF:%.*]] = fcmp ugt fp128 [[F]], 0xL00000000000000000000000000000000
; CHECK-NEXT:    br i1 [[ISINF]], label %[[IF_END:.*]], label %[[RETURN:.*]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    [[CALL:%.*]] = tail call fp128 @llvm.log10.f128(fp128 [[F]])
; CHECK-NEXT:    ret fp128 [[CALL]]
; CHECK:       [[RETURN]]:
; CHECK-NEXT:    ret fp128 0xL00000000000000000000000000000000
;
entry:
  %isinf = fcmp ole fp128 %f, 0xL00000000000000000000000000000000
  br i1 %isinf, label %return, label %if.end

if.end:
  %call = tail call fp128 @log10l(fp128 %f)
  ret fp128 %call

return:
  ret fp128 0xL00000000000000000000000000000000
}

define float @test_log2f_pos(float %f) {
; CHECK-LABEL: define float @test_log2f_pos(
; CHECK-SAME: float [[F:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[ISINF:%.*]] = fcmp ugt float [[F]], 0.000000e+00
; CHECK-NEXT:    br i1 [[ISINF]], label %[[IF_END:.*]], label %[[RETURN:.*]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    [[CALL:%.*]] = tail call float @llvm.log2.f32(float [[F]])
; CHECK-NEXT:    ret float [[CALL]]
; CHECK:       [[RETURN]]:
; CHECK-NEXT:    ret float 0.000000e+00
;
entry:
  %isinf = fcmp ole float %f, 0x0000000000000000
  br i1 %isinf, label %return, label %if.end

if.end:
  %call = tail call float @log2f(float %f)
  ret float %call

return:
  ret float 0.0
}

define double @test_log2_pos(double %f) {
; CHECK-LABEL: define double @test_log2_pos(
; CHECK-SAME: double [[F:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[ISINF:%.*]] = fcmp ugt double [[F]], 0.000000e+00
; CHECK-NEXT:    br i1 [[ISINF]], label %[[IF_END:.*]], label %[[RETURN:.*]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    [[CALL:%.*]] = tail call double @llvm.log2.f64(double [[F]])
; CHECK-NEXT:    ret double [[CALL]]
; CHECK:       [[RETURN]]:
; CHECK-NEXT:    ret double 0.000000e+00
;
entry:
  %isinf = fcmp ole double %f, 0x0000000000000000
  br i1 %isinf, label %return, label %if.end

if.end:
  %call = tail call double @log2(double %f)
  ret double %call

return:
  ret double 0.0
}

define fp128 @test_log2l_pos(fp128 %f) {
; CHECK-LABEL: define fp128 @test_log2l_pos(
; CHECK-SAME: fp128 [[F:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[ISINF:%.*]] = fcmp ugt fp128 [[F]], 0xL00000000000000000000000000000000
; CHECK-NEXT:    br i1 [[ISINF]], label %[[IF_END:.*]], label %[[RETURN:.*]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    [[CALL:%.*]] = tail call fp128 @llvm.log2.f128(fp128 [[F]])
; CHECK-NEXT:    ret fp128 [[CALL]]
; CHECK:       [[RETURN]]:
; CHECK-NEXT:    ret fp128 0xL00000000000000000000000000000000
;
entry:
  %isinf = fcmp ole fp128 %f, 0xL00000000000000000000000000000000
  br i1 %isinf, label %return, label %if.end

if.end:
  %call = tail call fp128 @log2l(fp128 %f)
  ret fp128 %call

return:
  ret fp128 0xL00000000000000000000000000000000
}


define double @test_logb_pos(double %f) {
; CHECK-LABEL: define double @test_logb_pos(
; CHECK-SAME: double [[F:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[ISINF:%.*]] = fcmp ugt double [[F]], 0.000000e+00
; CHECK-NEXT:    br i1 [[ISINF]], label %[[IF_END:.*]], label %[[RETURN:.*]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    [[CALL:%.*]] = tail call double @logb(double [[F]])
; CHECK-NEXT:    ret double [[CALL]]
; CHECK:       [[RETURN]]:
; CHECK-NEXT:    ret double 0.000000e+00
;
entry:
  %isinf = fcmp ole double %f, 0x0000000000000000
  br i1 %isinf, label %return, label %if.end

if.end:
  %call = tail call double @logb(double %f)
  ret double %call

return:
  ret double 0.0
}

define double @test_log1p_pos(double %f) {
; CHECK-LABEL: define double @test_log1p_pos(
; CHECK-SAME: double [[F:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[ISINF:%.*]] = fcmp ugt double [[F]], 0.000000e+00
; CHECK-NEXT:    br i1 [[ISINF]], label %[[IF_END:.*]], label %[[RETURN:.*]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    [[CALL:%.*]] = tail call double @log1p(double [[F]])
; CHECK-NEXT:    ret double [[CALL]]
; CHECK:       [[RETURN]]:
; CHECK-NEXT:    ret double 0.000000e+00
;
entry:
  %isinf = fcmp ole double %f, 0x0000000000000000
  br i1 %isinf, label %return, label %if.end

if.end:
  %call = tail call double @log1p(double %f)
  ret double %call

return:
  ret double 0.0
}

define float @metadata(float %f) {
; CHECK-LABEL: define float @metadata(
; CHECK-SAME: float [[F:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[ISINF:%.*]] = fcmp ugt float [[F]], 0.000000e+00
; CHECK-NEXT:    br i1 [[ISINF]], label %[[IF_END:.*]], label %[[RETURN:.*]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    [[CALL:%.*]] = tail call float @llvm.log.f32(float [[F]]), !fpmath [[META0:![0-9]+]]
; CHECK-NEXT:    ret float [[CALL]]
; CHECK:       [[RETURN]]:
; CHECK-NEXT:    ret float 0.000000e+00
;
entry:
  %isinf = fcmp ole float %f, 0x0000000000000000
  br i1 %isinf, label %return, label %if.end

if.end:
  %call = tail call float @logf(float %f), !fpmath !0
  ret float %call

return:
  ret float 0.0
}
!0 = !{ float 2.5 }

define float @test_logf_pos_denormalpreserve(float %f) "denormal-fp-math"="preserve-sign,preserve-sign"  {
; CHECK-LABEL: define float @test_logf_pos_denormalpreserve(
; CHECK-SAME: float [[F:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[ISINF:%.*]] = fcmp ugt float [[F]], 0.000000e+00
; CHECK-NEXT:    br i1 [[ISINF]], label %[[IF_END:.*]], label %[[RETURN:.*]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    [[CALL:%.*]] = tail call float @logf(float [[F]])
; CHECK-NEXT:    ret float [[CALL]]
; CHECK:       [[RETURN]]:
; CHECK-NEXT:    ret float 0.000000e+00
;
entry:
  %isinf = fcmp ole float %f, 0x0000000000000000
  br i1 %isinf, label %return, label %if.end

if.end:
  %call = tail call float @logf(float %f)
  ret float %call

return:
  ret float 0.0
}

define float @test_logf_pos_denormaldynamic(float %f) "denormal-fp-math"="dynamic,dynamic"  {
; CHECK-LABEL: define float @test_logf_pos_denormaldynamic(
; CHECK-SAME: float [[F:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[ISINF:%.*]] = fcmp ugt float [[F]], 0.000000e+00
; CHECK-NEXT:    br i1 [[ISINF]], label %[[IF_END:.*]], label %[[RETURN:.*]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    [[CALL:%.*]] = tail call float @logf(float [[F]])
; CHECK-NEXT:    ret float [[CALL]]
; CHECK:       [[RETURN]]:
; CHECK-NEXT:    ret float 0.000000e+00
;
entry:
  %isinf = fcmp ole float %f, 0x0000000000000000
  br i1 %isinf, label %return, label %if.end

if.end:
  %call = tail call float @logf(float %f)
  ret float %call

return:
  ret float 0.0
}

declare double @log(double)
declare float @logf(float)
declare fp128 @logl(fp128)
declare double @log10(double)
declare float @log10f(float)
declare fp128 @log10l(fp128)
declare double @log2(double)
declare float @log2f(float)
declare fp128 @log2l(fp128)
declare double @logb(double)
declare double @log1p(double)
;.
; CHECK: [[META0]] = !{float 2.500000e+00}
;.