; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S -passes='default<O3>' < %s | FileCheck %s

; Make sure that interaction of "writable" with various passes does not
; result in the elimination of the store prior to @j().
; FIXME: This is a miscompile.

declare void @use(i64)

define void @j(ptr %p) optnone noinline {
; CHECK-LABEL: define void @j(
; CHECK-SAME: ptr [[P:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    [[I:%.*]] = load i64, ptr [[P]], align 4
; CHECK-NEXT:    call void @use(i64 [[I]])
; CHECK-NEXT:    ret void
;
  %i = load i64, ptr %p
  call void @use(i64 %i)
  ret void
}

define void @h(ptr %p) {
; CHECK-LABEL: define void @h(
; CHECK-SAME: ptr [[P:%.*]]) local_unnamed_addr {
; CHECK-NEXT:    store i64 3, ptr [[P]], align 4
; CHECK-NEXT:    tail call void @j(ptr nonnull [[P]])
; CHECK-NEXT:    ret void
;
  store i64 3, ptr %p
  call void @j(ptr %p)
  ret void
}

define void @g(ptr dead_on_unwind noalias writable dereferenceable(8) align 8 %p) minsize {
; CHECK-LABEL: define void @g(
; CHECK-SAME: ptr dead_on_unwind noalias nocapture writable writeonly align 8 dereferenceable(8) [[P:%.*]]) local_unnamed_addr #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    tail call void @h(ptr nonnull [[P]])
; CHECK-NEXT:    ret void
;
  %a = alloca i64
  call void @h(ptr %a)
  call void @llvm.memcpy(ptr align 8 %p, ptr align 8 %a, i64 8, i1 false)
  ret void
}

define void @f(ptr dead_on_unwind noalias %p) {
; CHECK-LABEL: define void @f(
; CHECK-SAME: ptr dead_on_unwind noalias [[P:%.*]]) local_unnamed_addr {
; CHECK-NEXT:    store i64 3, ptr [[P]], align 4
; CHECK-NEXT:    tail call void @j(ptr nonnull align 8 dereferenceable(8) [[P]])
; CHECK-NEXT:    store i64 43, ptr [[P]], align 4
; CHECK-NEXT:    ret void
;
  call void @g(ptr %p)
  store i64 43, ptr %p
  ret void
}