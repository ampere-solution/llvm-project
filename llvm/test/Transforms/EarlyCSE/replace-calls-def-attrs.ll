; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-attributes --check-globals all --version 5
; RUN: opt -S -passes=early-cse  < %s | FileCheck %s

declare i8 @baz(i8, i8)
declare i8 @baz_side_effects(i8, i8)
declare i8 @buz(i8, i8)

declare ptr @baz.ptr(i8, i8)
declare i8 @buz.ptr(ptr, ptr)

declare float @baz.fp(float, float)
declare i8 @buz.fp(float, float)
define i8 @same_parent_combine_diff_attrs(i8 %x, i8 %y) {
; CHECK-LABEL: define i8 @same_parent_combine_diff_attrs(
; CHECK-SAME: i8 [[X:%.*]], i8 [[Y:%.*]]) {
; CHECK-NEXT:    [[C1:%.*]] = call i8 @baz(i8 [[X]], i8 noundef [[Y]]) #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    [[R:%.*]] = call i8 @buz(i8 [[C1]], i8 [[C1]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %c1 = call i8 @baz(i8 noundef %x, i8 noundef %y) readnone
  %c0 = call i8 @baz(i8 %x, i8 noundef %y) readnone
  %r = call i8 @buz(i8 %c0, i8 %c1)
  ret i8 %r

}

define i8 @same_parent_combine_diff_attrs_needs_intersect(i8 %x, i8 %y) {
; CHECK-LABEL: define i8 @same_parent_combine_diff_attrs_needs_intersect(
; CHECK-SAME: i8 [[X:%.*]], i8 [[Y:%.*]]) {
; CHECK-NEXT:    [[C1:%.*]] = call ptr @baz.ptr(i8 [[X]], i8 noundef [[Y]]) #[[ATTR0]]
; CHECK-NEXT:    [[R:%.*]] = call i8 @buz.ptr(ptr [[C1]], ptr [[C1]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %c1 = call nonnull ptr @baz.ptr(i8 noundef %x, i8 noundef %y) readnone
  %c0 = call ptr @baz.ptr(i8 %x, i8 noundef %y) readnone
  %r = call i8 @buz.ptr(ptr %c0, ptr %c1)
  ret i8 %r

}

define i8 @same_parent_combine_diff_attrs_fmf(float %x, float %y) {
; CHECK-LABEL: define i8 @same_parent_combine_diff_attrs_fmf(
; CHECK-SAME: float [[X:%.*]], float [[Y:%.*]]) {
; CHECK-NEXT:    [[C1:%.*]] = call nnan float @baz.fp(float [[X]], float noundef [[Y]]) #[[ATTR1:[0-9]+]]
; CHECK-NEXT:    [[R:%.*]] = call i8 @buz.fp(float [[C1]], float [[C1]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %c1 = call nnan nsz float @baz.fp(float noundef %x, float noundef %y) readonly
  %c0 = call nnan float @baz.fp(float %x, float noundef %y) readonly
  %r = call i8 @buz.fp(float %c0, float %c1)
  ret i8 %r

}

define i8 @same_parent_combine_diff_attrs_fmf2(float %x, float %y) {
; CHECK-LABEL: define i8 @same_parent_combine_diff_attrs_fmf2(
; CHECK-SAME: float [[X:%.*]], float [[Y:%.*]]) {
; CHECK-NEXT:    [[C1:%.*]] = call nnan float @baz.fp(float [[X]], float noundef [[Y]]) #[[ATTR0]]
; CHECK-NEXT:    [[R:%.*]] = call i8 @buz.fp(float [[C1]], float [[C1]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %c1 = call nnan float @baz.fp(float noundef %x, float noundef %y) readnone
  %c0 = call nnan nsz float @baz.fp(float %x, float noundef %y) readnone
  %r = call i8 @buz.fp(float %c0, float %c1)
  ret i8 %r

}

define i8 @same_parent_combine_diff_attrs_needs_intersect2(i8 %x, i8 %y) {
; CHECK-LABEL: define i8 @same_parent_combine_diff_attrs_needs_intersect2(
; CHECK-SAME: i8 [[X:%.*]], i8 [[Y:%.*]]) {
; CHECK-NEXT:    [[C1:%.*]] = call ptr @baz.ptr(i8 [[X]], i8 noundef [[Y]]) #[[ATTR1]]
; CHECK-NEXT:    [[R:%.*]] = call i8 @buz.ptr(ptr [[C1]], ptr [[C1]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %c1 = call nonnull ptr @baz.ptr(i8 noundef %x, i8 noundef %y) readonly
  %c0 = call ptr @baz.ptr(i8 %x, i8 noundef %y) readonly
  %r = call i8 @buz.ptr(ptr %c0, ptr %c1)
  ret i8 %r

}

define i8 @same_parent_combine_diff_attrs_really_needs_intersect(i8 %x, i8 %y) {
; CHECK-LABEL: define i8 @same_parent_combine_diff_attrs_really_needs_intersect(
; CHECK-SAME: i8 [[X:%.*]], i8 [[Y:%.*]]) {
; CHECK-NEXT:    [[C1:%.*]] = call ptr @baz.ptr(i8 [[X]], i8 noundef [[Y]]) #[[ATTR1]]
; CHECK-NEXT:    [[R:%.*]] = call i8 @buz.ptr(ptr [[C1]], ptr noundef [[C1]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %c1 = call nonnull ptr @baz.ptr(i8 noundef %x, i8 noundef %y) readonly
  %c0 = call ptr @baz.ptr(i8 %x, i8 noundef %y) readonly
  %r = call i8 @buz.ptr(ptr %c0, ptr noundef %c1)
  ret i8 %r

}

define i8 @same_parent_combine_diff_attrs_fail_side_effects(i8 %x, i8 %y) {
; CHECK-LABEL: define i8 @same_parent_combine_diff_attrs_fail_side_effects(
; CHECK-SAME: i8 [[X:%.*]], i8 [[Y:%.*]]) {
; CHECK-NEXT:    [[C1:%.*]] = call i8 @baz(i8 noundef [[X]], i8 noundef [[Y]])
; CHECK-NEXT:    [[C0:%.*]] = call i8 @baz(i8 [[X]], i8 noundef [[Y]])
; CHECK-NEXT:    [[R:%.*]] = call i8 @buz(i8 [[C0]], i8 [[C1]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %c1 = call i8 @baz(i8 noundef %x, i8 noundef %y)
  %c0 = call i8 @baz(i8 %x, i8 noundef %y)
  %r = call i8 @buz(i8 %c0, i8 %c1)
  ret i8 %r

}

define i8 @same_parent_combine_diff_attrs_quasi_side_effects2(i8 %x, i8 %y) {
; CHECK-LABEL: define i8 @same_parent_combine_diff_attrs_quasi_side_effects2(
; CHECK-SAME: i8 [[X:%.*]], i8 [[Y:%.*]]) {
; CHECK-NEXT:    [[C1:%.*]] = call i8 @baz(i8 noundef [[X]], i8 noundef [[Y]]) #[[ATTR0]]
; CHECK-NEXT:    [[C0:%.*]] = call i8 @baz(i8 [[X]], i8 noundef [[Y]])
; CHECK-NEXT:    [[R:%.*]] = call i8 @buz(i8 [[C0]], i8 [[C1]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %c1 = call i8 @baz(i8 noundef %x, i8 noundef %y) readnone
  %c0 = call i8 @baz(i8 %x, i8 noundef %y)
  %r = call i8 @buz(i8 %c0, i8 %c1)
  ret i8 %r

}

define i8 @diff_parent_combine_diff_attrs(i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: define i8 @diff_parent_combine_diff_attrs(
; CHECK-SAME: i1 [[C:%.*]], i8 [[X:%.*]], i8 [[Y:%.*]]) {
; CHECK-NEXT:    [[C1:%.*]] = call i8 @baz(i8 [[X]], i8 noundef [[Y]]) #[[ATTR0]]
; CHECK-NEXT:    br i1 [[C]], label %[[T:.*]], label %[[F:.*]]
; CHECK:       [[T]]:
; CHECK-NEXT:    [[C0:%.*]] = call i8 @baz(i8 noundef [[X]], i8 noundef [[Y]]) #[[ATTR1]]
; CHECK-NEXT:    [[R:%.*]] = call i8 @buz(i8 [[C0]], i8 [[C1]])
; CHECK-NEXT:    ret i8 [[R]]
; CHECK:       [[F]]:
; CHECK-NEXT:    [[R2:%.*]] = add i8 [[C1]], 4
; CHECK-NEXT:    ret i8 [[R2]]
;
  %c1 = call i8 @baz(i8 %x, i8 noundef %y) readnone
  br i1 %c, label %T, label %F
T:
  %c0 = call i8 @baz(i8 noundef %x, i8 noundef %y) readonly
  %r = call i8 @buz(i8 %c0, i8 %c1)
  ret i8 %r
F:
  %r2 = add i8 %c1, 4
  ret i8 %r2
}

define i8 @diff_parent_combine_diff_attrs_preserves_return_attrs(i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: define i8 @diff_parent_combine_diff_attrs_preserves_return_attrs(
; CHECK-SAME: i1 [[C:%.*]], i8 [[X:%.*]], i8 [[Y:%.*]]) {
; CHECK-NEXT:    [[C1:%.*]] = call nonnull ptr @baz.ptr(i8 [[X]], i8 noundef [[Y]]) #[[ATTR1]]
; CHECK-NEXT:    br i1 [[C]], label %[[T:.*]], label %[[F:.*]]
; CHECK:       [[T]]:
; CHECK-NEXT:    [[R:%.*]] = call i8 @buz.ptr(ptr [[C1]], ptr noundef [[C1]])
; CHECK-NEXT:    ret i8 [[R]]
; CHECK:       [[F]]:
; CHECK-NEXT:    ret i8 9
;
  %c1 = call nonnull ptr @baz.ptr(i8 %x, i8 noundef %y) readonly
  br i1 %c, label %T, label %F
T:
  %c0 = call nonnull ptr @baz.ptr(i8 noundef %x, i8 noundef %y) readonly
  %r = call i8 @buz.ptr(ptr %c0, ptr noundef %c1)
  ret i8 %r
F:
  ret i8 9
}

define i8 @same_parent_combine_diff_attrs_todo(i8 %x, i8 %y) {
; CHECK-LABEL: define i8 @same_parent_combine_diff_attrs_todo(
; CHECK-SAME: i8 [[X:%.*]], i8 [[Y:%.*]]) {
; CHECK-NEXT:    [[C1:%.*]] = call i8 @baz(i8 [[X]], i8 noundef [[Y]]) #[[ATTR0]]
; CHECK-NEXT:    [[C0:%.*]] = call i8 @baz(i8 noundef [[X]], i8 noundef [[Y]]) #[[ATTR2:[0-9]+]]
; CHECK-NEXT:    [[R:%.*]] = call i8 @buz(i8 [[C0]], i8 [[C1]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %c1 = call i8 @baz(i8 %x, i8 noundef %y) readnone
  %c0 = call i8 @baz(i8 noundef %x, i8 noundef %y) readnone alwaysinline
  %r = call i8 @buz(i8 %c0, i8 %c1)
  ret i8 %r

}

define i8 @same_parent_combine_diff_attrs_fail(i8 %x, i8 %y) {
; CHECK-LABEL: define i8 @same_parent_combine_diff_attrs_fail(
; CHECK-SAME: i8 [[X:%.*]], i8 [[Y:%.*]]) {
; CHECK-NEXT:    [[C1:%.*]] = call i8 @baz(i8 [[X]], i8 noundef [[Y]]) #[[ATTR0]]
; CHECK-NEXT:    [[C0:%.*]] = call i8 @baz(i8 noundef [[X]], i8 noundef [[Y]]) #[[ATTR3:[0-9]+]]
; CHECK-NEXT:    [[R:%.*]] = call i8 @buz(i8 [[C0]], i8 [[C1]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %c1 = call i8 @baz(i8 %x, i8 noundef %y) readnone
  %c0 = call i8 @baz(i8 noundef %x, i8 noundef %y) readnone strictfp
  %r = call i8 @buz(i8 %c0, i8 %c1)
  ret i8 %r

}

define i8 @diff_parent_combine_diff_attrs_todo(i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: define i8 @diff_parent_combine_diff_attrs_todo(
; CHECK-SAME: i1 [[C:%.*]], i8 [[X:%.*]], i8 [[Y:%.*]]) {
; CHECK-NEXT:    [[C1:%.*]] = call i8 @baz(i8 [[X]], i8 noundef [[Y]]) #[[ATTR0]]
; CHECK-NEXT:    br i1 [[C]], label %[[T:.*]], label %[[F:.*]]
; CHECK:       [[T]]:
; CHECK-NEXT:    [[C0:%.*]] = call i8 @baz(i8 noundef [[X]], i8 noundef [[Y]]) #[[ATTR4:[0-9]+]]
; CHECK-NEXT:    [[R:%.*]] = call i8 @buz(i8 [[C0]], i8 [[C1]])
; CHECK-NEXT:    ret i8 [[R]]
; CHECK:       [[F]]:
; CHECK-NEXT:    [[R2:%.*]] = add i8 [[C1]], 4
; CHECK-NEXT:    ret i8 [[R2]]
;
  %c1 = call i8 @baz(i8 %x, i8 noundef %y) readnone
  br i1 %c, label %T, label %F
T:
  %c0 = call i8 @baz(i8 noundef %x, i8 noundef %y) readnone optnone noinline
  %r = call i8 @buz(i8 %c0, i8 %c1)
  ret i8 %r
F:
  %r2 = add i8 %c1, 4
  ret i8 %r2
}

define i8 @diff_parent_combine_diff_attrs_fail(i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: define i8 @diff_parent_combine_diff_attrs_fail(
; CHECK-SAME: i1 [[C:%.*]], i8 [[X:%.*]], i8 [[Y:%.*]]) {
; CHECK-NEXT:    [[C1:%.*]] = call i8 @baz(i8 [[X]], i8 noundef [[Y]]) #[[ATTR0]]
; CHECK-NEXT:    br i1 [[C]], label %[[T:.*]], label %[[F:.*]]
; CHECK:       [[T]]:
; CHECK-NEXT:    [[C0:%.*]] = call i8 @baz(i8 noundef [[X]], i8 noundef [[Y]]) #[[ATTR3]]
; CHECK-NEXT:    [[R:%.*]] = call i8 @buz(i8 [[C0]], i8 [[C1]])
; CHECK-NEXT:    ret i8 [[R]]
; CHECK:       [[F]]:
; CHECK-NEXT:    [[R2:%.*]] = add i8 [[C1]], 4
; CHECK-NEXT:    ret i8 [[R2]]
;
  %c1 = call i8 @baz(i8 %x, i8 noundef %y) readnone
  br i1 %c, label %T, label %F
T:
  %c0 = call i8 @baz(i8 noundef %x, i8 noundef %y) readnone strictfp
  %r = call i8 @buz(i8 %c0, i8 %c1)
  ret i8 %r
F:
  %r2 = add i8 %c1, 4
  ret i8 %r2
}

;.
; CHECK: attributes #[[ATTR0]] = { memory(none) }
; CHECK: attributes #[[ATTR1]] = { memory(read) }
; CHECK: attributes #[[ATTR2]] = { alwaysinline memory(none) }
; CHECK: attributes #[[ATTR3]] = { strictfp memory(none) }
; CHECK: attributes #[[ATTR4]] = { noinline optnone memory(none) }
;.