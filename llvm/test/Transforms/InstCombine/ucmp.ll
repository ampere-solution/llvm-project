; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare void @use(i8 %value)

define i1 @ucmp_eq_0(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @ucmp_eq_0(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = icmp eq i8 %1, 0
  ret i1 %2
}

define i1 @ucmp_ne_0(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @ucmp_ne_0(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ne i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = icmp ne i8 %1, 0
  ret i1 %2
}

define i1 @ucmp_eq_1(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @ucmp_eq_1(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ugt i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = icmp eq i8 %1, 1
  ret i1 %2
}

define i1 @ucmp_ne_1(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @ucmp_ne_1(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ule i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = icmp ne i8 %1, 1
  ret i1 %2
}

define i1 @ucmp_eq_negative_1(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @ucmp_eq_negative_1(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ult i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = icmp eq i8 %1, -1
  ret i1 %2
}

define i1 @ucmp_ne_negative_1(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @ucmp_ne_negative_1(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp uge i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = icmp ne i8 %1, -1
  ret i1 %2
}

define i1 @ucmp_sgt_0(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @ucmp_sgt_0(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ugt i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = icmp sgt i8 %1, 0
  ret i1 %2
}

define i1 @ucmp_sgt_neg_1(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @ucmp_sgt_neg_1(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp uge i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = icmp sgt i8 %1, -1
  ret i1 %2
}

define i1 @ucmp_sge_0(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @ucmp_sge_0(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp uge i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = icmp sge i8 %1, 0
  ret i1 %2
}

define i1 @ucmp_sge_1(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @ucmp_sge_1(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ugt i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = icmp sge i8 %1, 1
  ret i1 %2
}

define i1 @ucmp_slt_0(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @ucmp_slt_0(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ult i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = icmp slt i8 %1, 0
  ret i1 %2
}

define i1 @ucmp_slt_1(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @ucmp_slt_1(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ule i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = icmp slt i8 %1, 1
  ret i1 %2
}

define i1 @ucmp_sle_0(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @ucmp_sle_0(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ule i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = icmp sle i8 %1, 0
  ret i1 %2
}

define i1 @ucmp_sle_neg_1(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @ucmp_sle_neg_1(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ult i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = icmp sle i8 %1, -1
  ret i1 %2
}

; ucmp(x, y) u< C => x u>= y when C u> 1 and C != -1
define i1 @ucmp_ult_positive_const_gt_than_1_lt_than_umax(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @ucmp_ult_positive_const_gt_than_1_lt_than_umax(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = icmp uge i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = icmp ult i8 %1, 4
  ret i1 %2
}

; ucmp(x, y) u> C => x u< y when C != 0 and C != -1
define i1 @ucmp_ugt_const_not_0_or_neg1(i32 %x, i32 %y) {
; CHECK-LABEL: define i1 @ucmp_ugt_const_not_0_or_neg1(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ult i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = icmp ugt i8 %1, 12
  ret i1 %2
}

; ========== Fold -ucmp(x, y) => ucmp(y, x) ==========
define i8 @ucmp_negated(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_negated(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[Y]], i32 [[X]])
; CHECK-NEXT:    ret i8 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  %2 = sub i8 0, %1
  ret i8 %2
}

; Negative test: do not fold if the original ucmp result is already used
define i8 @ucmp_negated_multiuse(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_negated_multiuse(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[X]], i32 [[Y]])
; CHECK-NEXT:    call void @use(i8 [[TMP1]])
; CHECK-NEXT:    [[TMP2:%.*]] = sub nsw i8 0, [[TMP1]]
; CHECK-NEXT:    ret i8 [[TMP2]]
;
  %1 = call i8 @llvm.ucmp(i32 %x, i32 %y)
  call void @use(i8 %1)
  %2 = sub i8 0, %1
  ret i8 %2
}

; Fold ((x u< y) ? -1 : (x != y)) into ucmp(x, y)
define i8 @ucmp_from_select_lt(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_lt(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[X]], i32 [[Y]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp ne i32 %x, %y
  %ne = zext i1 %ne_bool to i8
  %lt = icmp ult i32 %x, %y
  %r = select i1 %lt, i8 -1, i8 %ne
  ret i8 %r
}

; Fold (x u< y) ? -1 : zext(x u> y) into ucmp(x, y)
define i8 @ucmp_from_select_lt_and_gt(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_lt_and_gt(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[X]], i32 [[Y]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %gt_bool = icmp ugt i32 %x, %y
  %gt = zext i1 %gt_bool to i8
  %lt = icmp ult i32 %x, %y
  %r = select i1 %lt, i8 -1, i8 %gt
  ret i8 %r
}

; Vector version
define <4 x i8> @ucmp_from_select_vec_lt(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: define <4 x i8> @ucmp_from_select_vec_lt(
; CHECK-SAME: <4 x i32> [[X:%.*]], <4 x i32> [[Y:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call <4 x i8> @llvm.ucmp.v4i8.v4i32(<4 x i32> [[X]], <4 x i32> [[Y]])
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %ne_bool = icmp ne <4 x i32> %x, %y
  %ne = zext <4 x i1> %ne_bool to <4 x i8>
  %lt = icmp ult <4 x i32> %x, %y
  %r = select <4 x i1> %lt, <4 x i8> splat(i8 -1), <4 x i8> %ne
  ret <4 x i8> %r
}

; Commuted operands
define i8 @ucmp_from_select_lt_commuted_ops1(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_lt_commuted_ops1(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[X]], i32 [[Y]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp ne i32 %y, %x
  %ne = zext i1 %ne_bool to i8
  %lt = icmp ult i32 %x, %y
  %r = select i1 %lt, i8 -1, i8 %ne
  ret i8 %r
}

define i8 @ucmp_from_select_lt_commuted_ops2(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_lt_commuted_ops2(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[X]], i32 [[Y]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp ne i32 %x, %y
  %ne = zext i1 %ne_bool to i8
  %lt = icmp ugt i32 %y, %x
  %r = select i1 %lt, i8 -1, i8 %ne
  ret i8 %r
}

; Negative test: false value of the select is not `icmp ne x, y`
define i8 @ucmp_from_select_lt_neg1(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_lt_neg1(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[NE_BOOL:%.*]] = icmp eq i32 [[X]], [[Y]]
; CHECK-NEXT:    [[NE:%.*]] = zext i1 [[NE_BOOL]] to i8
; CHECK-NEXT:    [[LT:%.*]] = icmp ult i32 [[X]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = select i1 [[LT]], i8 -1, i8 [[NE]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp eq i32 %x, %y
  %ne = zext i1 %ne_bool to i8
  %lt = icmp ult i32 %x, %y
  %r = select i1 %lt, i8 -1, i8 %ne
  ret i8 %r
}

; Negative test: true value of select is not -1
define i8 @ucmp_from_select_lt_neg2(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_lt_neg2(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[NE_BOOL:%.*]] = icmp ne i32 [[X]], [[Y]]
; CHECK-NEXT:    [[NE:%.*]] = zext i1 [[NE_BOOL]] to i8
; CHECK-NEXT:    [[LT:%.*]] = icmp ult i32 [[X]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = select i1 [[LT]], i8 2, i8 [[NE]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp ne i32 %x, %y
  %ne = zext i1 %ne_bool to i8
  %lt = icmp ult i32 %x, %y
  %r = select i1 %lt, i8 2, i8 %ne
  ret i8 %r
}

; Negative test: false value of select is sign-extended instead of zero-extended
define i8 @ucmp_from_select_lt_neg3(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_lt_neg3(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[NE_BOOL:%.*]] = icmp ne i32 [[X]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = sext i1 [[NE_BOOL]] to i8
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp ne i32 %x, %y
  %ne = sext i1 %ne_bool to i8
  %lt = icmp ult i32 %x, %y
  %r = select i1 %lt, i8 -1, i8 %ne
  ret i8 %r
}

; Negative test: condition of select is not (x u< y)
define i8 @ucmp_from_select_lt_neg4(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_lt_neg4(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[NE_BOOL:%.*]] = icmp ne i32 [[X]], [[Y]]
; CHECK-NEXT:    [[NE:%.*]] = zext i1 [[NE_BOOL]] to i8
; CHECK-NEXT:    [[LT_NOT:%.*]] = icmp ugt i32 [[X]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = select i1 [[LT_NOT]], i8 [[NE]], i8 -1
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp ne i32 %x, %y
  %ne = zext i1 %ne_bool to i8
  %lt = icmp ule i32 %x, %y
  %r = select i1 %lt, i8 -1, i8 %ne
  ret i8 %r
}

; Fold (x u<= y) ? sext(x != y) : 1 into ucmp(x, y)
define i8 @ucmp_from_select_le(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_le(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[X]], i32 [[Y]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp ne i32 %x, %y
  %ne = sext i1 %ne_bool to i8
  %le = icmp ule i32 %x, %y
  %r = select i1 %le, i8 %ne, i8 1
  ret i8 %r
}

; Negative test: condition of select is not (x u<= y)
define i8 @ucmp_from_select_le_neg1(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_le_neg1(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[NE_BOOL:%.*]] = icmp ult i32 [[X]], [[Y]]
; CHECK-NEXT:    [[NE:%.*]] = sext i1 [[NE_BOOL]] to i8
; CHECK-NEXT:    [[LE_NOT:%.*]] = icmp ult i32 [[X]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = select i1 [[LE_NOT]], i8 1, i8 [[NE]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp ult i32 %x, %y
  %ne = sext i1 %ne_bool to i8
  %le = icmp uge i32 %x, %y
  %r = select i1 %le, i8 %ne, i8 1
  ret i8 %r
}

; Negative test: true value of select is zero-extended instead of sign-extended
define i8 @ucmp_from_select_le_neg2(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_le_neg2(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[NE_BOOL:%.*]] = icmp ne i32 [[X]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = zext i1 [[NE_BOOL]] to i8
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp ne i32 %x, %y
  %ne = zext i1 %ne_bool to i8
  %le = icmp ule i32 %x, %y
  %r = select i1 %le, i8 %ne, i8 1
  ret i8 %r
}

; Negative test: true value is not x != y
define i8 @ucmp_from_select_le_neg3(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_le_neg3(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[NE_BOOL:%.*]] = icmp sgt i32 [[X]], [[Y]]
; CHECK-NEXT:    [[NE:%.*]] = sext i1 [[NE_BOOL]] to i8
; CHECK-NEXT:    [[LE_NOT:%.*]] = icmp ugt i32 [[X]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = select i1 [[LE_NOT]], i8 1, i8 [[NE]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp sgt i32 %x, %y
  %ne = sext i1 %ne_bool to i8
  %le = icmp ule i32 %x, %y
  %r = select i1 %le, i8 %ne, i8 1
  ret i8 %r
}

; Negative test: false value is not 1
define i8 @ucmp_from_select_le_neg4(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_le_neg4(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[NE_BOOL:%.*]] = icmp ne i32 [[X]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = sext i1 [[NE_BOOL]] to i8
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp ne i32 %x, %y
  %ne = sext i1 %ne_bool to i8
  %le = icmp ule i32 %x, %y
  %r = select i1 %le, i8 %ne, i8 -1
  ret i8 %r
}

; Fold (x u>= y) ? zext(x != y) : -1 into ucmp(x, y)
define i8 @ucmp_from_select_ge(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_ge(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[X]], i32 [[Y]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp ne i32 %x, %y
  %ne = zext i1 %ne_bool to i8
  %ge = icmp uge i32 %x, %y
  %r = select i1 %ge, i8 %ne, i8 -1
  ret i8 %r
}

; Commuted operands
define i8 @ucmp_from_select_ge_commuted_ops1(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_ge_commuted_ops1(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[X]], i32 [[Y]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp ne i32 %y, %x
  %ne = zext i1 %ne_bool to i8
  %ge = icmp uge i32 %x, %y
  %r = select i1 %ge, i8 %ne, i8 -1
  ret i8 %r
}

define i8 @ucmp_from_select_ge_commuted_ops2(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_ge_commuted_ops2(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[X]], i32 [[Y]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp ne i32 %x, %y
  %ne = zext i1 %ne_bool to i8
  %ge = icmp ule i32 %y, %x
  %r = select i1 %ge, i8 %ne, i8 -1
  ret i8 %r
}

; Negative test: condition is not x u>= y
define i8 @ucmp_from_select_ge_neg1(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_ge_neg1(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[NE_BOOL:%.*]] = icmp ne i32 [[X]], [[Y]]
; CHECK-NEXT:    [[NE:%.*]] = zext i1 [[NE_BOOL]] to i8
; CHECK-NEXT:    [[GE:%.*]] = icmp ult i32 [[X]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = select i1 [[GE]], i8 [[NE]], i8 -1
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp ne i32 %x, %y
  %ne = zext i1 %ne_bool to i8
  %ge = icmp ult i32 %x, %y
  %r = select i1 %ge, i8 %ne, i8 -1
  ret i8 %r
}

; Negative test: true value is sign-extended instead of zero-extended
define i8 @ucmp_from_select_ge_neg2(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_ge_neg2(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[NE_BOOL:%.*]] = icmp ne i32 [[X]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = sext i1 [[NE_BOOL]] to i8
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp ne i32 %x, %y
  %ne = sext i1 %ne_bool to i8
  %ge = icmp uge i32 %x, %y
  %r = select i1 %ge, i8 %ne, i8 -1
  ret i8 %r
}

; Negative test: true value is not x != y
define i8 @ucmp_from_select_ge_neg3(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_ge_neg3(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[NE_BOOL:%.*]] = icmp sgt i32 [[X]], [[Y]]
; CHECK-NEXT:    [[NE:%.*]] = zext i1 [[NE_BOOL]] to i8
; CHECK-NEXT:    [[GE_NOT:%.*]] = icmp ult i32 [[X]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = select i1 [[GE_NOT]], i8 -1, i8 [[NE]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp sgt i32 %x, %y
  %ne = zext i1 %ne_bool to i8
  %ge = icmp uge i32 %x, %y
  %r = select i1 %ge, i8 %ne, i8 -1
  ret i8 %r
}

; Negative test: false value is not -1
define i8 @ucmp_from_select_ge_neg4(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_ge_neg4(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[NE_BOOL:%.*]] = icmp ne i32 [[X]], [[Y]]
; CHECK-NEXT:    [[NE:%.*]] = zext i1 [[NE_BOOL]] to i8
; CHECK-NEXT:    [[GE_NOT:%.*]] = icmp ult i32 [[X]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = select i1 [[GE_NOT]], i8 3, i8 [[NE]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %ne_bool = icmp ne i32 %x, %y
  %ne = zext i1 %ne_bool to i8
  %ge = icmp uge i32 %x, %y
  %r = select i1 %ge, i8 %ne, i8 3
  ret i8 %r
}

; Fold (x > y) ? 1 : sext(x < y)
define i8 @ucmp_from_select_gt_and_lt(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @ucmp_from_select_gt_and_lt(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[X]], i32 [[Y]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %lt_bool = icmp ult i32 %x, %y
  %lt = sext i1 %lt_bool to i8
  %gt = icmp ugt i32 %x, %y
  %r = select i1 %gt, i8 1, i8 %lt
  ret i8 %r
}

; (x == y) ? 0 : (x u> y ? 1 : -1) into ucmp(x, y)
define i8 @scmp_from_select_eq_and_gt(i32 %x, i32 %y) {
; CHECK-LABEL: define i8 @scmp_from_select_eq_and_gt(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[X]], i32 [[Y]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %eq = icmp eq i32 %x, %y
  %gt = icmp ugt i32 %x, %y
  %sel1 = select i1 %gt, i8 1, i8 -1
  %r = select i1 %eq, i8 0, i8 %sel1
  ret i8 %r
}