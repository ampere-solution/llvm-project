; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt < %s -passes=ipsccp -S | FileCheck %s

; if IPSCCP determines a function returns undef,
; then the "returned" attribute of input arguments
; should be cleared.

define i32 @main() {
; CHECK-LABEL: define i32 @main() {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[CALL:%.*]] = call i32 @func_return_undef(i32 1)
; CHECK-NEXT:    ret i32 1
;
entry:
  %call = call i32 @func_return_undef(i32 returned 1)
  ret i32 %call
}

define internal i32 @func_return_undef(i32 returned %arg) {
; CHECK-LABEL: define internal i32 @func_return_undef(
; CHECK-SAME: i32 [[ARG:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    ret i32 poison
;
entry:
  ret i32 %arg
}

; The only case that users of zapped functions are non-call site
; users is that they are blockaddr users. Skip them because we
; want to remove the returned attribute for call sites
define internal i32 @blockaddr_user(i1 %c, i32 returned %d) {
; CHECK-LABEL: define internal i32 @blockaddr_user(
; CHECK-SAME: i1 [[C:%.*]], i32 [[D:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    br i1 [[C]], label %[[BB1:.*]], label %[[BB2:.*]]
; CHECK:       [[BB1]]:
; CHECK-NEXT:    br label %[[BRANCH_BLOCK:.*]]
; CHECK:       [[BB2]]:
; CHECK-NEXT:    br label %[[BRANCH_BLOCK]]
; CHECK:       [[BRANCH_BLOCK]]:
; CHECK-NEXT:    [[ADDR:%.*]] = phi ptr [ blockaddress(@blockaddr_user, %[[TARGET1:.*]]), %[[BB1]] ], [ blockaddress(@blockaddr_user, %[[TARGET2:.*]]), %[[BB2]] ]
; CHECK-NEXT:    indirectbr ptr [[ADDR]], [label %[[TARGET1]], label %target2]
; CHECK:       [[TARGET1]]:
; CHECK-NEXT:    br label %[[TARGET2]]
; CHECK:       [[TARGET2]]:
; CHECK-NEXT:    ret i32 poison
;
entry:
  br i1 %c, label %bb1, label %bb2

bb1:
  br label %branch.block

bb2:
  br label %branch.block

branch.block:
  %addr = phi ptr [blockaddress(@blockaddr_user, %target1), %bb1], [blockaddress(@blockaddr_user, %target2), %bb2]
  indirectbr ptr %addr, [label %target1, label %target2]

target1:
  br label %target2

target2:
  ret i32 %d
}

define i32 @call_blockaddr_user(i1 %c) {
; CHECK-LABEL: define i32 @call_blockaddr_user(
; CHECK-SAME: i1 [[C:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call i32 @blockaddr_user(i1 [[C]], i32 10)
; CHECK-NEXT:    ret i32 10
;
  %r = call i32 @blockaddr_user(i1 %c, i32 returned 10)
  ret i32 %r
}