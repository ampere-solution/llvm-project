; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare i8 @llvm.fshl.i8(i8, i8, i8)
declare i8 @llvm.fshr.i8(i8, i8, i8)
declare <2 x i5> @llvm.fshl.v2i5(<2 x i5>, <2 x i5>, <2 x i5>)
declare <2 x i5> @llvm.fshr.v2i5(<2 x i5>, <2 x i5>, <2 x i5>)
declare void @use(i8)

define i1 @rol_eq(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @rol_eq(
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %f = tail call i8 @llvm.fshl.i8(i8 %x, i8 %x, i8 %z)
  %f2 = tail call i8 @llvm.fshl.i8(i8 %y, i8 %y, i8 %z)
  %r = icmp eq i8 %f, %f2
  ret i1 %r
}

define i1 @rol_ne(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @rol_ne(
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %f = tail call i8 @llvm.fshl.i8(i8 %x, i8 %x, i8 %z)
  %f2 = tail call i8 @llvm.fshl.i8(i8 %y, i8 %y, i8 %z)
  %r = icmp ne i8 %f, %f2
  ret i1 %r
}

define i1 @ror_eq(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @ror_eq(
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %f = tail call i8 @llvm.fshr.i8(i8 %x, i8 %x, i8 %z)
  %f2 = tail call i8 @llvm.fshr.i8(i8 %y, i8 %y, i8 %z)
  %r = icmp eq i8 %f, %f2
  ret i1 %r
}


define i1 @ror_ne(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @ror_ne(
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %f = tail call i8 @llvm.fshr.i8(i8 %x, i8 %x, i8 %z)
  %f2 = tail call i8 @llvm.fshr.i8(i8 %y, i8 %y, i8 %z)
  %r = icmp ne i8 %f, %f2
  ret i1 %r
}

define i1 @rol_eq_use(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @rol_eq_use(
; CHECK-NEXT:    [[F:%.*]] = tail call i8 @llvm.fshl.i8(i8 [[X:%.*]], i8 [[X]], i8 [[Z:%.*]])
; CHECK-NEXT:    call void @use(i8 [[F]])
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[X]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %f = tail call i8 @llvm.fshl.i8(i8 %x, i8 %x, i8 %z)
  call void @use(i8 %f)
  %f2 = tail call i8 @llvm.fshl.i8(i8 %y, i8 %y, i8 %z)
  %r = icmp eq i8 %f, %f2
  ret i1 %r
}

define i1 @rol_eq_uses(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @rol_eq_uses(
; CHECK-NEXT:    [[F:%.*]] = tail call i8 @llvm.fshl.i8(i8 [[X:%.*]], i8 [[X]], i8 [[Z:%.*]])
; CHECK-NEXT:    call void @use(i8 [[F]])
; CHECK-NEXT:    [[F2:%.*]] = tail call i8 @llvm.fshl.i8(i8 [[Y:%.*]], i8 [[Y]], i8 [[Z]])
; CHECK-NEXT:    call void @use(i8 [[F2]])
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %f = tail call i8 @llvm.fshl.i8(i8 %x, i8 %x, i8 %z)
  call void @use(i8 %f)
  %f2 = tail call i8 @llvm.fshl.i8(i8 %y, i8 %y, i8 %z)
  call void @use(i8 %f2)
  %r = icmp eq i8 %f, %f2
  ret i1 %r
}

define <2 x i1> @rol_eq_vec(<2 x i5> %x, <2 x i5> %y, <2 x i5> %z) {
; CHECK-LABEL: @rol_eq_vec(
; CHECK-NEXT:    [[R:%.*]] = icmp eq <2 x i5> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %f = tail call <2 x i5> @llvm.fshl.v2i5(<2 x i5> %x, <2 x i5> %x, <2 x i5> %z)
  %f2 = tail call <2 x i5> @llvm.fshl.v2i5(<2 x i5> %y, <2 x i5> %y, <2 x i5> %z)
  %r = icmp eq <2 x i5> %f, %f2
  ret <2 x i1> %r
}

define <2 x i1> @ror_eq_vec(<2 x i5> %x, <2 x i5> %y, <2 x i5> %z) {
; CHECK-LABEL: @ror_eq_vec(
; CHECK-NEXT:    [[R:%.*]] = icmp eq <2 x i5> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %f = tail call <2 x i5> @llvm.fshr.v2i5(<2 x i5> %x, <2 x i5> %x, <2 x i5> %z)
  %f2 = tail call <2 x i5> @llvm.fshr.v2i5(<2 x i5> %y, <2 x i5> %y, <2 x i5> %z)
  %r = icmp eq <2 x i5> %f, %f2
  ret <2 x i1> %r
}


define i1 @rol_eq_cst(i8 %x) {
; CHECK-LABEL: @rol_eq_cst(
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[X:%.*]], 64
; CHECK-NEXT:    ret i1 [[R]]
;
  %f = tail call i8 @llvm.fshl.i8(i8 %x, i8 %x, i8 3)
  %r = icmp eq i8 %f, 2
  ret i1 %r
}

define i1 @rol_ne_cst(i8 %x) {
; CHECK-LABEL: @rol_ne_cst(
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[X:%.*]], 64
; CHECK-NEXT:    ret i1 [[R]]
;
  %f = tail call i8 @llvm.fshl.i8(i8 %x, i8 %x, i8 3)
  %r = icmp ne i8 %f, 2
  ret i1 %r
}

define i1 @rol_eq_cst_use(i8 %x) {
; CHECK-LABEL: @rol_eq_cst_use(
; CHECK-NEXT:    [[F:%.*]] = tail call i8 @llvm.fshl.i8(i8 [[X:%.*]], i8 [[X]], i8 3)
; CHECK-NEXT:    call void @use(i8 [[F]])
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[X]], 64
; CHECK-NEXT:    ret i1 [[R]]
;
  %f = tail call i8 @llvm.fshl.i8(i8 %x, i8 %x, i8 3)
  call void @use(i8 %f)
  %r = icmp eq i8 %f, 2
  ret i1 %r
}

define i1 @ror_eq_cst(i8 %x) {
; CHECK-LABEL: @ror_eq_cst(
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[X:%.*]], 12
; CHECK-NEXT:    ret i1 [[R]]
;
  %f = tail call i8 @llvm.fshr.i8(i8 %x, i8 %x, i8 2)
  %r = icmp eq i8 %f, 3
  ret i1 %r
}

define i1 @ror_ne_cst(i8 %x) {
; CHECK-LABEL: @ror_ne_cst(
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[X:%.*]], 12
; CHECK-NEXT:    ret i1 [[R]]
;
  %f = tail call i8 @llvm.fshr.i8(i8 %x, i8 %x, i8 2)
  %r = icmp ne i8 %f, 3
  ret i1 %r
}

define <2 x i1> @rol_eq_cst_vec(<2 x i5> %x) {
; CHECK-LABEL: @rol_eq_cst_vec(
; CHECK-NEXT:    [[R:%.*]] = icmp eq <2 x i5> [[X:%.*]], <i5 8, i5 8>
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %f = tail call <2 x i5> @llvm.fshl.v2i5(<2 x i5> %x, <2 x i5> %x, <2 x i5> <i5 3, i5 3>)
  %r = icmp eq <2 x i5> %f, <i5 2, i5 2>
  ret <2 x i1> %r
}

define <2 x i1> @rol_eq_cst_undef(<2 x i5> %x) {
; CHECK-LABEL: @rol_eq_cst_undef(
; CHECK-NEXT:    [[F:%.*]] = tail call <2 x i5> @llvm.fshl.v2i5(<2 x i5> [[X:%.*]], <2 x i5> [[X]], <2 x i5> <i5 3, i5 3>)
; CHECK-NEXT:    [[R:%.*]] = icmp eq <2 x i5> [[F]], <i5 2, i5 undef>
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %f = tail call <2 x i5> @llvm.fshl.v2i5(<2 x i5> %x, <2 x i5> %x, <2 x i5> <i5 3, i5 3>)
  %r = icmp eq <2 x i5> %f, <i5 2, i5 undef>
  ret <2 x i1> %r
}

; negative test - not a rotate
define i1 @no_rotate(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @no_rotate(
; CHECK-NEXT:    [[F:%.*]] = tail call i8 @llvm.fshl.i8(i8 [[X:%.*]], i8 [[Y:%.*]], i8 [[Z:%.*]])
; CHECK-NEXT:    [[F2:%.*]] = tail call i8 @llvm.fshl.i8(i8 [[Y]], i8 [[Y]], i8 [[Z]])
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[F]], [[F2]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %f = tail call i8 @llvm.fshl.i8(i8 %x, i8 %y, i8 %z)
  %f2 = tail call i8 @llvm.fshl.i8(i8 %y, i8 %y, i8 %z)
  %r = icmp eq i8 %f, %f2
  ret i1 %r
}

; negative test - wrong predicate
define i1 @wrong_pred(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @wrong_pred(
; CHECK-NEXT:    [[F:%.*]] = tail call i8 @llvm.fshl.i8(i8 [[X:%.*]], i8 [[X]], i8 [[Z:%.*]])
; CHECK-NEXT:    [[F2:%.*]] = tail call i8 @llvm.fshl.i8(i8 [[Y:%.*]], i8 [[Y]], i8 [[Z]])
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[F]], [[F2]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %f = tail call i8 @llvm.fshl.i8(i8 %x, i8 %x, i8 %z)
  %f2 = tail call i8 @llvm.fshl.i8(i8 %y, i8 %y, i8 %z)
  %r = icmp ult i8 %f, %f2
  ret i1 %r
}

; negative test - rotate amounts mismatch
define i1 @amounts_mismatch(i8 %x, i8 %y, i8 %z, i8 %w) {
; CHECK-LABEL: @amounts_mismatch(
; CHECK-NEXT:    [[TMP1:%.*]] = sub i8 [[Z:%.*]], [[W:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i8 @llvm.fshl.i8(i8 [[X:%.*]], i8 [[X]], i8 [[TMP1]])
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[Y:%.*]], [[TMP2]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %f = tail call i8 @llvm.fshl.i8(i8 %x, i8 %x, i8 %z)
  %f2 = tail call i8 @llvm.fshl.i8(i8 %y, i8 %y, i8 %w)
  %r = icmp eq i8 %f, %f2
  ret i1 %r
}

; negative test - wrong predicate
define i1 @wrong_pred2(i8 %x) {
; CHECK-LABEL: @wrong_pred2(
; CHECK-NEXT:    [[F:%.*]] = call i8 @llvm.fshl.i8(i8 [[X:%.*]], i8 [[X]], i8 5)
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[F]], 2
; CHECK-NEXT:    ret i1 [[R]]
;
  %f = tail call i8 @llvm.fshr.i8(i8 %x, i8 %x, i8 27)
  %r = icmp ugt i8 %f, 2
  ret i1 %r
}