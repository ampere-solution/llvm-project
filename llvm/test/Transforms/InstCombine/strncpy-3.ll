; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals
; RUN: opt < %s -passes=instcombine -S | FileCheck %s


@str = constant [2 x i8] c"a\00"
@str2 = constant [3 x i8] c"abc"
@str3 = constant [4 x i8] c"abcd"

declare ptr @strncpy(ptr, ptr, i64)


;.
; CHECK: @str = constant [2 x i8] c"a\00"
; CHECK: @str2 = constant [3 x i8] c"abc"
; CHECK: @str3 = constant [4 x i8] c"abcd"
; CHECK: @str.1 = private unnamed_addr constant [4 x i8] c"a\00\00\00", align 1
; CHECK: @str.2 = private unnamed_addr constant [128 x i8] c"abcd\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", align 1
;.
define void @fill_with_zeros(ptr %dst) {
; CHECK-LABEL: @fill_with_zeros(
; CHECK-NEXT:    store i32 97, ptr [[DST:%.*]], align 1
; CHECK-NEXT:    ret void
;
  tail call ptr @strncpy(ptr %dst, ptr @str, i64 4)
  ret void
}

define void @fill_with_zeros2(ptr %dst) {
; CHECK-LABEL: @fill_with_zeros2(
; CHECK-NEXT:    store i32 6513249, ptr [[DST:%.*]], align 1
; CHECK-NEXT:    ret void
;
  tail call ptr @strncpy(ptr %dst, ptr @str2, i64 4)
  ret void
}

define void @fill_with_zeros3(ptr %dst) {
; CHECK-LABEL: @fill_with_zeros3(
; CHECK-NEXT:    store i32 1684234849, ptr [[DST:%.*]], align 1
; CHECK-NEXT:    ret void
;
  tail call ptr @strncpy(ptr %dst, ptr @str3, i64 4)
  ret void
}

define void @fill_with_zeros4(ptr %dst) {
; CHECK-LABEL: @fill_with_zeros4(
; CHECK-NEXT:    tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(128) [[DST:%.*]], ptr noundef nonnull align 1 dereferenceable(128) @str.2, i64 128, i1 false)
; CHECK-NEXT:    ret void
;
  tail call ptr @strncpy(ptr %dst, ptr @str3, i64 128)
  ret void
}

define void @no_simplify(ptr %dst) {
; CHECK-LABEL: @no_simplify(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call ptr @strncpy(ptr noundef nonnull dereferenceable(1) [[DST:%.*]], ptr noundef nonnull dereferenceable(5) @str3, i64 129)
; CHECK-NEXT:    ret void
;
  tail call ptr @strncpy(ptr %dst, ptr @str3, i64 129)
  ret void
}
;.
; CHECK: attributes #[[ATTR0:[0-9]+]] = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
;.