; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

@glob = internal global [10 x [10 x [10 x i32]]] zeroinitializer

define ptr @x12(i64 %x) {
; CHECK-LABEL: define ptr @x12(
; CHECK-SAME: i64 [[X:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[GEP_IDX:%.*]] = mul nsw i64 [[X]], 400
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i8, ptr getelementptr inbounds (i8, ptr @glob, i64 84), i64 [[GEP_IDX]]
; CHECK-NEXT:    ret ptr [[GEP]]
;
entry:
  %gep = getelementptr inbounds [10 x [10 x [10 x i32]]], ptr getelementptr (i8, ptr @glob, i64 36), i64 0, i64 %x, i64 1, i64 2
  ret ptr %gep
}

define ptr @x1y(i64 %x, i64 %y) {
; CHECK-LABEL: define ptr @x1y(
; CHECK-SAME: i64 [[X:%.*]], i64 [[Y:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[GEP_IDX:%.*]] = mul nsw i64 [[X]], 400
; CHECK-NEXT:    [[GEP_IDX1:%.*]] = shl nsw i64 [[Y]], 2
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr i8, ptr getelementptr inbounds (i8, ptr @glob, i64 116), i64 [[GEP_IDX]]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i8, ptr [[TMP0]], i64 [[GEP_IDX1]]
; CHECK-NEXT:    ret ptr [[GEP]]
;
entry:
  %gep = getelementptr inbounds [10 x [10 x [10 x i32]]], ptr getelementptr (i8, ptr @glob, i64 36), i64 0, i64 %x, i64 2, i64 %y
  ret ptr %gep
}

define ptr @xzy(i64 %x, i64 %y, i64 %z) {
; CHECK-LABEL: define ptr @xzy(
; CHECK-SAME: i64 [[X:%.*]], i64 [[Y:%.*]], i64 [[Z:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds [10 x [10 x [10 x i32]]], ptr getelementptr inbounds (i8, ptr @glob, i64 40), i64 0, i64 [[X]], i64 [[Z]], i64 [[Y]]
; CHECK-NEXT:    ret ptr [[GEP]]
;
entry:
  %gep = getelementptr inbounds [10 x [10 x [10 x i32]]], ptr getelementptr (i8, ptr @glob, i64 40), i64 0, i64 %x, i64 %z, i64 %y
  ret ptr %gep
}

define ptr @zerox(i64 %x) {
; CHECK-LABEL: define ptr @zerox(
; CHECK-SAME: i64 [[X:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds [10 x i32], ptr getelementptr inbounds (i8, ptr @glob, i64 32), i64 0, i64 [[X]]
; CHECK-NEXT:    ret ptr [[GEP]]
;
entry:
  %gep = getelementptr inbounds [10 x i32], ptr getelementptr (i8, ptr @glob, i64 32), i64 0, i64 %x
  ret ptr %gep
}

define i32 @twoloads(i64 %x) {
; CHECK-LABEL: define i32 @twoloads(
; CHECK-SAME: i64 [[X:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[GEP1_IDX:%.*]] = mul nsw i64 [[X]], 400
; CHECK-NEXT:    [[GEP1:%.*]] = getelementptr i8, ptr getelementptr inbounds (i8, ptr @glob, i64 134), i64 [[GEP1_IDX]]
; CHECK-NEXT:    [[GEP2_IDX:%.*]] = mul nsw i64 [[X]], 400
; CHECK-NEXT:    [[GEP2:%.*]] = getelementptr i8, ptr getelementptr inbounds (i8, ptr @glob, i64 132), i64 [[GEP2_IDX]]
; CHECK-NEXT:    [[A:%.*]] = load i32, ptr [[GEP1]], align 4
; CHECK-NEXT:    [[B:%.*]] = load i32, ptr [[GEP2]], align 4
; CHECK-NEXT:    [[C:%.*]] = add i32 [[A]], [[B]]
; CHECK-NEXT:    ret i32 [[C]]
;
entry:
  %gep1 = getelementptr inbounds [10 x [10 x [10 x i32]]], ptr getelementptr (i8, ptr @glob, i64 50), i64 0, i64 %x, i64 2, i64 1
  %gep2 = getelementptr inbounds [10 x [10 x [10 x i32]]], ptr getelementptr (i8, ptr @glob, i64 36), i64 0, i64 %x, i64 2, i64 4
  %a = load i32, ptr %gep1
  %b = load i32, ptr %gep2
  %c = add i32 %a, %b
  ret i32 %c
}