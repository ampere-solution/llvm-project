; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -passes=loop-distribute -enable-loop-distribute -verify-loop-info -verify-dom-info -S < %s | FileCheck %s

; If we can't find the bounds for one of the arrays in order to generate the
; memchecks (e.g., C[i * i] below), loop shold not get distributed.
;
;   for (i = 0; i < n; i++) {
;     A[i + 1] = A[i] * 3;
; -------------------------------
;     C[i * i] = B[i] * 2;
;   }

; Verify that we didn't distribute by checking that we still have the original
; number of branches.

@A = common global ptr null, align 8
@B = common global ptr null, align 8
@C = common global ptr null, align 8

define void @f() {
; CHECK-LABEL: define void @f() {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    [[A:%.*]] = load ptr, ptr @A, align 8
; CHECK-NEXT:    [[B:%.*]] = load ptr, ptr @B, align 8
; CHECK-NEXT:    [[C:%.*]] = load ptr, ptr @C, align 8
; CHECK-NEXT:    br label %[[FOR_BODY:.*]]
; CHECK:       [[FOR_BODY]]:
; CHECK-NEXT:    [[IND:%.*]] = phi i64 [ 0, %[[ENTRY]] ], [ [[ADD:%.*]], %[[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDXA:%.*]] = getelementptr inbounds i32, ptr [[A]], i64 [[IND]]
; CHECK-NEXT:    [[LOADA:%.*]] = load i32, ptr [[ARRAYIDXA]], align 4
; CHECK-NEXT:    [[MULA:%.*]] = mul i32 [[LOADA]], 3
; CHECK-NEXT:    [[ADD]] = add nuw nsw i64 [[IND]], 1
; CHECK-NEXT:    [[ARRAYIDXA_PLUS_4:%.*]] = getelementptr inbounds i32, ptr [[A]], i64 [[ADD]]
; CHECK-NEXT:    store i32 [[MULA]], ptr [[ARRAYIDXA_PLUS_4]], align 4
; CHECK-NEXT:    [[ARRAYIDXB:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[IND]]
; CHECK-NEXT:    [[LOADB:%.*]] = load i32, ptr [[ARRAYIDXB]], align 4
; CHECK-NEXT:    [[MULC:%.*]] = mul i32 [[LOADB]], 2
; CHECK-NEXT:    [[IND_2:%.*]] = mul i64 [[IND]], [[IND]]
; CHECK-NEXT:    [[ARRAYIDXC:%.*]] = getelementptr inbounds i32, ptr [[C]], i64 [[IND_2]]
; CHECK-NEXT:    store i32 [[MULC]], ptr [[ARRAYIDXC]], align 4
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[ADD]], 20
; CHECK-NEXT:    br i1 [[EXITCOND]], label %[[FOR_END:.*]], label %[[FOR_BODY]]
; CHECK:       [[FOR_END]]:
; CHECK-NEXT:    ret void
;
entry:
  %a = load ptr, ptr @A, align 8
  %b = load ptr, ptr @B, align 8
  %c = load ptr, ptr @C, align 8
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %ind = phi i64 [ 0, %entry ], [ %add, %for.body ]

  %arrayidxA = getelementptr inbounds i32, ptr %a, i64 %ind
  %loadA = load i32, ptr %arrayidxA, align 4

  %mulA = mul i32 %loadA, 3

  %add = add nuw nsw i64 %ind, 1
  %arrayidxA_plus_4 = getelementptr inbounds i32, ptr %a, i64 %add
  store i32 %mulA, ptr %arrayidxA_plus_4, align 4

  %arrayidxB = getelementptr inbounds i32, ptr %b, i64 %ind
  %loadB = load i32, ptr %arrayidxB, align 4

  %mulC = mul i32 %loadB, 2

  %ind_2 = mul i64 %ind, %ind
  %arrayidxC = getelementptr inbounds i32, ptr %c, i64 %ind_2
  store i32 %mulC, ptr %arrayidxC, align 4

  %exitcond = icmp eq i64 %add, 20
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}