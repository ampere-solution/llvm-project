; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes='default<Os>' -S %s | FileCheck %s

target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"


declare void @use(i16)

define void @test_remove_check_with_incrementing_integer_induction(i16 %start, i8 %len.n, i16 %a) {
; CHECK-LABEL: @test_remove_check_with_incrementing_integer_induction(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = zext i8 [[LEN_N:%.*]] to i16
; CHECK-NEXT:    [[LEN_NEG_NOT:%.*]] = icmp ugt i16 [[A:%.*]], [[LEN]]
; CHECK-NEXT:    [[C1:%.*]] = icmp ne i8 [[LEN_N]], 0
; CHECK-NEXT:    [[OR_COND3:%.*]] = and i1 [[LEN_NEG_NOT]], [[C1]]
; CHECK-NEXT:    br i1 [[OR_COND3]], label [[LOOP_LATCH_PREHEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.latch.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = add i16 [[A]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = add nsw i16 [[LEN]], -1
; CHECK-NEXT:    [[UMIN:%.*]] = tail call i16 @llvm.umin.i16(i16 [[TMP0]], i16 [[TMP1]])
; CHECK-NEXT:    br label [[LOOP_LATCH:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[IV2:%.*]] = phi i16 [ [[IV_NEXT:%.*]], [[LOOP_LATCH]] ], [ 0, [[LOOP_LATCH_PREHEADER]] ]
; CHECK-NEXT:    tail call void @use(i16 [[IV2]])
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i16 [[IV2]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i16 [[IV2]], [[UMIN]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[EXIT]], label [[LOOP_LATCH]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %len = zext i8 %len.n to i16
  %upper = add nuw nsw i16 %start, %len
  %len.neg = icmp uge i16 %len, %a
  br i1 %len.neg, label %exit, label %loop.ph

loop.ph:
  br label %loop.header

loop.header:
  %iv = phi i16 [ 0, %loop.ph ], [ %iv.next, %loop.latch ]
  %c = icmp eq i16 %iv, %len
  br i1 %c, label %exit, label %for.body

for.body:
  %t.1 = icmp uge i16 %iv, 0
  %t.2 = icmp ult i16 %iv, %a
  %and = and i1 %t.1, %t.2
  br i1 %and, label %loop.latch, label %exit

loop.latch:
  call void @use(i16 %iv)
  %iv.next = add nuw nsw i16 %iv, 1
  br label %loop.header

exit:
  ret void
}


define void @chained_conditions(i64 noundef %a, i64 noundef %b, i64 noundef %c, i64 noundef %d) #0 {
; CHECK-LABEL: @chained_conditions(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret void
;
entry:
  %a.addr = alloca i64, align 8
  %b.addr = alloca i64, align 8
  %c.addr = alloca i64, align 8
  %d.addr = alloca i64, align 8
  store i64 %a, ptr %a.addr, align 8
  store i64 %b, ptr %b.addr, align 8
  store i64 %c, ptr %c.addr, align 8
  store i64 %d, ptr %d.addr, align 8
  %0 = load i64, ptr %a.addr, align 8
  %cmp = icmp ugt i64 %0, 2048
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %1 = load i64, ptr %b.addr, align 8
  %cmp1 = icmp ugt i64 %1, 1024
  br i1 %cmp1, label %if.then, label %lor.lhs.false2

lor.lhs.false2:                                   ; preds = %lor.lhs.false
  %2 = load i64, ptr %c.addr, align 8
  %cmp3 = icmp ugt i64 %2, 1024
  br i1 %cmp3, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false2, %lor.lhs.false, %entry
  br label %if.end10

if.end:                                           ; preds = %lor.lhs.false2
  %3 = load i64, ptr %a.addr, align 8
  %4 = load i64, ptr %b.addr, align 8
  %add = add i64 %3, %4
  %5 = load i64, ptr %c.addr, align 8
  %add4 = add i64 %add, %5
  %6 = load i64, ptr %d.addr, align 8
  %cmp5 = icmp uge i64 %add4, %6
  br i1 %cmp5, label %if.then6, label %if.end7

if.then6:                                         ; preds = %if.end
  br label %if.end10

if.end7:                                          ; preds = %if.end
  %7 = load i64, ptr %a.addr, align 8
  %8 = load i64, ptr %d.addr, align 8
  %cmp8 = icmp uge i64 %7, %8
  br i1 %cmp8, label %if.then9, label %if.end10

if.then9:                                         ; preds = %if.end7
  call void @bar()
  br label %if.end10

if.end10:                                         ; preds = %if.then, %if.then6, %if.then9, %if.end7
  ret void
}

declare void @bar()