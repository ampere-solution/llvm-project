; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-attributes --check-globals all --version 5
; This test checks in the second run, function is not instrumented again.
; RUN: opt < %s -passes=asan,asan -S | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function with sanitize_address is instrumented.
; Function Attrs: nounwind uwtable
;.
; CHECK: @___asan_globals_registered = common hidden global i64 0
; CHECK: @__start_asan_globals = extern_weak hidden global i64
; CHECK: @__stop_asan_globals = extern_weak hidden global i64
;.
define void @instr_sa(ptr %a) sanitize_address {
; CHECK: Function Attrs: sanitize_address
; CHECK-LABEL: define void @instr_sa(
; CHECK-SAME: ptr [[A:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[TMP0:%.*]] = ptrtoint ptr [[A]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = lshr i64 [[TMP0]], 3
; CHECK-NEXT:    [[TMP2:%.*]] = add i64 [[TMP1]], 2147450880
; CHECK-NEXT:    [[TMP3:%.*]] = inttoptr i64 [[TMP2]] to ptr
; CHECK-NEXT:    [[TMP4:%.*]] = load i8, ptr [[TMP3]], align 1
; CHECK-NEXT:    [[TMP5:%.*]] = icmp ne i8 [[TMP4]], 0
; CHECK-NEXT:    br i1 [[TMP5]], label %[[BB6:.*]], label %[[BB12:.*]], !prof [[PROF1:![0-9]+]]
; CHECK:       [[BB6]]:
; CHECK-NEXT:    [[TMP7:%.*]] = and i64 [[TMP0]], 7
; CHECK-NEXT:    [[TMP8:%.*]] = add i64 [[TMP7]], 3
; CHECK-NEXT:    [[TMP9:%.*]] = trunc i64 [[TMP8]] to i8
; CHECK-NEXT:    [[TMP10:%.*]] = icmp sge i8 [[TMP9]], [[TMP4]]
; CHECK-NEXT:    br i1 [[TMP10]], label %[[BB11:.*]], label %[[BB12]]
; CHECK:       [[BB11]]:
; CHECK-NEXT:    call void @__asan_report_load4(i64 [[TMP0]]) #[[ATTR2:[0-9]+]]
; CHECK-NEXT:    unreachable
; CHECK:       [[BB12]]:
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[A]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = add i32 [[TMP1]], 1
; CHECK-NEXT:    store i32 [[TMP2]], ptr [[A]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %tmp1 = load i32, ptr %a, align 4
  %tmp2 = add i32 %tmp1,  1
  store i32 %tmp2, ptr %a, align 4
  ret void
}
;.
; CHECK: attributes #[[ATTR0]] = { sanitize_address }
; CHECK: attributes #[[ATTR1:[0-9]+]] = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
; CHECK: attributes #[[ATTR2]] = { nomerge }
;.
; CHECK: [[META0:![0-9]+]] = !{i32 4, !"nosanitize_address", i32 1}
; CHECK: [[PROF1]] = !{!"branch_weights", i32 1, i32 1048575}
;.