; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -p loop-vectorize -mtriple=arm64-apple-macosx -S %s | FileCheck %s

target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"

define i32 @multi_exit_iv_uniform(i32 %a, i64 %N, ptr %dst) {
; CHECK-LABEL: define i32 @multi_exit_iv_uniform(
; CHECK-SAME: i32 [[A:%.*]], i64 [[N:%.*]], ptr [[DST:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UMIN:%.*]] = call i64 @llvm.umin.i64(i64 [[N]], i64 2147483648)
; CHECK-NEXT:    [[TMP0:%.*]] = add nuw nsw i64 [[UMIN]], 1
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ule i64 [[TMP0]], 8
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[TMP0]], 8
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i64 [[N_MOD_VF]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], i64 8, i64 [[N_MOD_VF]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[TMP0]], [[TMP2]]
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <4 x i32> poison, i32 [[A]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <4 x i32> [[BROADCAST_SPLATINSERT]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP7:%.*]] = zext <4 x i32> [[BROADCAST_SPLAT]] to <4 x i64>
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP10:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI1:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP11:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP3:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr i64, ptr [[DST]], i64 [[TMP3]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr i64, ptr [[TMP5]], i32 0
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr i64, ptr [[TMP5]], i32 4
; CHECK-NEXT:    store <4 x i64> [[TMP7]], ptr [[TMP8]], align 8
; CHECK-NEXT:    store <4 x i64> [[TMP7]], ptr [[TMP9]], align 8
; CHECK-NEXT:    [[TMP10]] = add <4 x i32> [[VEC_PHI]], <i32 -1, i32 -1, i32 -1, i32 -1>
; CHECK-NEXT:    [[TMP11]] = add <4 x i32> [[VEC_PHI1]], <i32 -1, i32 -1, i32 -1, i32 -1>
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 8
; CHECK-NEXT:    [[TMP12:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP12]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = add <4 x i32> [[TMP11]], [[TMP10]]
; CHECK-NEXT:    [[TMP13:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[BIN_RDX]])
; CHECK-NEXT:    br label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i32 [ [[TMP13]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY]] ]
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[IV_2:%.*]] = phi i32 [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ], [ [[IV_2_NEXT:%.*]], [[LOOP_LATCH]] ]
; CHECK-NEXT:    [[C_1:%.*]] = icmp eq i64 [[IV]], [[N]]
; CHECK-NEXT:    br i1 [[C_1]], label [[EXIT_1:%.*]], label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[ARRAYIDX_I:%.*]] = getelementptr i64, ptr [[DST]], i64 [[IV]]
; CHECK-NEXT:    [[CONV7:%.*]] = zext i32 [[A]] to i64
; CHECK-NEXT:    store i64 [[CONV7]], ptr [[ARRAYIDX_I]], align 8
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; CHECK-NEXT:    [[IV_2_NEXT]] = add i32 [[IV_2]], -1
; CHECK-NEXT:    [[C_2:%.*]] = icmp eq i64 [[IV]], 2147483648
; CHECK-NEXT:    br i1 [[C_2]], label [[EXIT_2:%.*]], label [[LOOP_HEADER]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       exit.1:
; CHECK-NEXT:    ret i32 10
; CHECK:       exit.2:
; CHECK-NEXT:    [[IV_2_NEXT_LCSSA:%.*]] = phi i32 [ [[IV_2_NEXT]], [[LOOP_LATCH]] ]
; CHECK-NEXT:    ret i32 [[IV_2_NEXT_LCSSA]]
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %iv.2 = phi i32 [ 0, %entry ], [ %iv.2.next, %loop.latch ]
  %c.1 = icmp eq i64 %iv, %N
  br i1 %c.1, label %exit.1, label %loop.latch

loop.latch:
  %arrayidx.i = getelementptr i64, ptr %dst, i64 %iv
  %conv7 = zext i32 %a to i64
  store i64 %conv7, ptr %arrayidx.i, align 8
  %iv.next = add i64 %iv, 1
  %iv.2.next = add i32 %iv.2, -1
  %c.2 = icmp eq i64 %iv, 2147483648
  br i1 %c.2, label %exit.2, label %loop.header

exit.1:
  ret i32 10

exit.2:
  ret i32 %iv.2.next
}

define i64 @pointer_induction_only(ptr %start, ptr %end) {
; CHECK-LABEL: define i64 @pointer_induction_only(
; CHECK-SAME: ptr [[START:%.*]], ptr [[END:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[START2:%.*]] = ptrtoint ptr [[START]] to i64
; CHECK-NEXT:    [[END1:%.*]] = ptrtoint ptr [[END]] to i64
; CHECK-NEXT:    [[TMP0:%.*]] = sub i64 [[END1]], [[START2]]
; CHECK-NEXT:    [[TMP1:%.*]] = lshr i64 [[TMP0]], 2
; CHECK-NEXT:    [[TMP2:%.*]] = add nuw nsw i64 [[TMP1]], 1
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[TMP2]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[TMP2]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[TMP2]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP3:%.*]] = mul i64 [[N_VEC]], 4
; CHECK-NEXT:    [[IND_END:%.*]] = getelementptr i8, ptr [[START]], i64 [[TMP3]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VECTOR_RECUR:%.*]] = phi <2 x i64> [ <i64 poison, i64 0>, [[VECTOR_PH]] ], [ [[TMP9:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = mul i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP4:%.*]] = add i64 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[NEXT_GEP:%.*]] = getelementptr i8, ptr [[START]], i64 [[TMP4]]
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr i32, ptr [[NEXT_GEP]], i32 2
; CHECK-NEXT:    [[WIDE_LOAD4:%.*]] = load <2 x i32>, ptr [[TMP7]], align 1
; CHECK-NEXT:    [[TMP9]] = zext <2 x i32> [[WIDE_LOAD4]] to <2 x i64>
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP12:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP12]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[VECTOR_RECUR_EXTRACT:%.*]] = extractelement <2 x i64> [[TMP9]], i32 1
; CHECK-NEXT:    [[VECTOR_RECUR_EXTRACT_FOR_PHI:%.*]] = extractelement <2 x i64> [[TMP9]], i32 0
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[TMP2]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi ptr [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ [[START]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[SCALAR_RECUR_INIT:%.*]] = phi i64 [ [[VECTOR_RECUR_EXTRACT]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi ptr [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[SCALAR_RECUR:%.*]] = phi i64 [ [[SCALAR_RECUR_INIT]], [[SCALAR_PH]] ], [ [[RECUR_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[L:%.*]] = load i32, ptr [[IV]], align 1
; CHECK-NEXT:    [[RECUR_NEXT]] = zext i32 [[L]] to i64
; CHECK-NEXT:    [[IV_NEXT]] = getelementptr inbounds i8, ptr [[IV]], i64 4
; CHECK-NEXT:    [[C:%.*]] = icmp eq ptr [[IV]], [[END]]
; CHECK-NEXT:    br i1 [[C]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    [[RECUR_LCSSA:%.*]] = phi i64 [ [[SCALAR_RECUR]], [[LOOP]] ], [ [[VECTOR_RECUR_EXTRACT_FOR_PHI]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i64 [[RECUR_LCSSA]]
;
entry:
  br label %loop

loop:
  %iv = phi ptr [ %start, %entry ], [ %iv.next, %loop ]
  %recur = phi i64 [ 0, %entry ], [ %recur.next, %loop ]
  %l = load i32, ptr %iv, align 1
  %recur.next = zext i32 %l to i64
  %iv.next = getelementptr inbounds i8, ptr %iv, i64 4
  %c = icmp eq ptr %iv, %end
  br i1 %c, label %exit, label %loop

exit:
  ret i64 %recur
}


define i64 @int_and_pointer_iv(ptr %start, i32 %N) {
; CHECK-LABEL: define i64 @int_and_pointer_iv(
; CHECK-SAME: ptr [[START:%.*]], i32 [[N:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[IND_END:%.*]] = getelementptr i8, ptr [[START]], i64 4000
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VECTOR_RECUR:%.*]] = phi <4 x i64> [ <i64 poison, i64 poison, i64 poison, i64 0>, [[VECTOR_PH]] ], [ [[TMP5:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = mul i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[NEXT_GEP:%.*]] = getelementptr i8, ptr [[START]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr i32, ptr [[NEXT_GEP]], i32 4
; CHECK-NEXT:    [[WIDE_LOAD3:%.*]] = load <4 x i32>, ptr [[TMP3]], align 4
; CHECK-NEXT:    [[TMP5]] = zext <4 x i32> [[WIDE_LOAD3]] to <4 x i64>
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 8
; CHECK-NEXT:    [[TMP8:%.*]] = icmp eq i64 [[INDEX_NEXT]], 1000
; CHECK-NEXT:    br i1 [[TMP8]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[VECTOR_RECUR_EXTRACT:%.*]] = extractelement <4 x i64> [[TMP5]], i32 3
; CHECK-NEXT:    [[VECTOR_RECUR_EXTRACT_FOR_PHI:%.*]] = extractelement <4 x i64> [[TMP5]], i32 2
; CHECK-NEXT:    br i1 true, label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 1000, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL1:%.*]] = phi ptr [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ [[START]], [[ENTRY]] ]
; CHECK-NEXT:    [[SCALAR_RECUR_INIT:%.*]] = phi i64 [ [[VECTOR_RECUR_EXTRACT]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[BC_RESUME_VAL1]], [[SCALAR_PH]] ], [ [[PTR_IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[SCALAR_RECUR:%.*]] = phi i64 [ [[SCALAR_RECUR_INIT]], [[SCALAR_PH]] ], [ [[RECUR_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[L:%.*]] = load i32, ptr [[PTR_IV]], align 4
; CHECK-NEXT:    [[RECUR_NEXT]] = zext i32 [[L]] to i64
; CHECK-NEXT:    [[PTR_IV_NEXT]] = getelementptr i8, ptr [[PTR_IV]], i64 4
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    [[TOBOOL_NOT:%.*]] = icmp eq i32 [[IV_NEXT]], 1000
; CHECK-NEXT:    br i1 [[TOBOOL_NOT]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP7:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    [[RECUR_LCSSA:%.*]] = phi i64 [ [[SCALAR_RECUR]], [[LOOP]] ], [ [[VECTOR_RECUR_EXTRACT_FOR_PHI]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i64 [[RECUR_LCSSA]]
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %ptr.iv = phi ptr [ %start, %entry ], [ %ptr.iv.next, %loop ]
  %recur = phi i64 [ 0, %entry ], [ %recur.next, %loop ]
  %l = load i32, ptr %ptr.iv, align 4
  %recur.next = zext i32 %l to i64
  %ptr.iv.next = getelementptr i8, ptr %ptr.iv, i64 4
  %iv.next = add i32 %iv, 1
  %tobool.not = icmp eq i32 %iv.next, 1000
  br i1 %tobool.not, label %exit, label %loop

exit:
  ret i64 %recur
}

define void @wide_truncated_iv(ptr %dst) {
; CHECK-LABEL: define void @wide_truncated_iv(
; CHECK-SAME: ptr [[DST:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <8 x i8> [ <i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[STEP_ADD:%.*]] = add <8 x i8> [[VEC_IND]], <i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8>
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr i8, ptr [[DST]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr i8, ptr [[TMP2]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr i8, ptr [[TMP2]], i32 8
; CHECK-NEXT:    store <8 x i8> [[VEC_IND]], ptr [[TMP4]], align 1
; CHECK-NEXT:    store <8 x i8> [[STEP_ADD]], ptr [[TMP5]], align 1
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <8 x i8> [[STEP_ADD]], <i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8>
; CHECK-NEXT:    [[TMP6:%.*]] = icmp eq i64 [[INDEX_NEXT]], 192
; CHECK-NEXT:    br i1 [[TMP6]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP8:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 false, label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 192, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[TRUNC_IV:%.*]] = trunc i64 [[IV]] to i8
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i8, ptr [[DST]], i64 [[IV]]
; CHECK-NEXT:    store i8 [[TRUNC_IV]], ptr [[GEP]], align 1
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; CHECK-NEXT:    [[C:%.*]] = icmp eq i64 [[IV]], 200
; CHECK-NEXT:    br i1 [[C]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP9:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %trunc.iv = trunc i64 %iv to i8
  %gep = getelementptr i8, ptr %dst, i64 %iv
  store i8 %trunc.iv, ptr %gep, align 1
  %iv.next = add i64 %iv, 1
  %c = icmp eq i64 %iv, 200
  br i1 %c, label %exit, label %loop

exit:
  ret void
}

define i64 @test_ptr_ivs_and_widened_ivs(ptr %src, i32 %N) {
; DEFAULT-LABEL: define i64 @test_ptr_ivs_and_widened_ivs(
; DEFAULT-SAME: ptr [[SRC:%.*]], i32 [[N:%.*]]) {
; DEFAULT-NEXT:  entry:
; DEFAULT-NEXT:    [[TMP0:%.*]] = add i32 [[N]], -1
; DEFAULT-NEXT:    [[TMP1:%.*]] = zext i32 [[TMP0]] to i64
; DEFAULT-NEXT:    [[TMP2:%.*]] = add nuw nsw i64 [[TMP1]], 1
; DEFAULT-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[TMP2]], 8
; DEFAULT-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; DEFAULT:       vector.ph:
; DEFAULT-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[TMP2]], 8
; DEFAULT-NEXT:    [[N_VEC:%.*]] = sub i64 [[TMP2]], [[N_MOD_VF]]
; DEFAULT-NEXT:    [[TMP3:%.*]] = mul i64 [[N_VEC]], 4
; DEFAULT-NEXT:    [[IND_END:%.*]] = getelementptr i8, ptr [[SRC]], i64 [[TMP3]]
; DEFAULT-NEXT:    [[IND_END1:%.*]] = trunc i64 [[N_VEC]] to i32
; DEFAULT-NEXT:    [[IND_END3:%.*]] = trunc i64 [[N_VEC]] to i32
; DEFAULT-NEXT:    br label [[VECTOR_BODY:%.*]]
; DEFAULT:       vector.body:
; DEFAULT-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; DEFAULT-NEXT:    [[VECTOR_RECUR:%.*]] = phi <4 x i64> [ <i64 poison, i64 poison, i64 poison, i64 0>, [[VECTOR_PH]] ], [ [[TMP15:%.*]], [[VECTOR_BODY]] ]
; DEFAULT-NEXT:    [[VEC_IND:%.*]] = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; DEFAULT-NEXT:    [[STEP_ADD:%.*]] = add <4 x i32> [[VEC_IND]], <i32 4, i32 4, i32 4, i32 4>
; DEFAULT-NEXT:    [[OFFSET_IDX:%.*]] = mul i64 [[INDEX]], 4
; DEFAULT-NEXT:    [[TMP4:%.*]] = add i64 [[OFFSET_IDX]], 0
; DEFAULT-NEXT:    [[TMP5:%.*]] = add i64 [[OFFSET_IDX]], 16
; DEFAULT-NEXT:    [[NEXT_GEP:%.*]] = getelementptr i8, ptr [[SRC]], i64 [[TMP4]]
; DEFAULT-NEXT:    [[NEXT_GEP6:%.*]] = getelementptr i8, ptr [[SRC]], i64 [[TMP5]]
; DEFAULT-NEXT:    [[TMP6:%.*]] = getelementptr i32, ptr [[NEXT_GEP]], i32 0
; DEFAULT-NEXT:    [[TMP7:%.*]] = getelementptr i32, ptr [[NEXT_GEP]], i32 4
; DEFAULT-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP6]], align 4
; DEFAULT-NEXT:    [[WIDE_LOAD7:%.*]] = load <4 x i32>, ptr [[TMP7]], align 4
; DEFAULT-NEXT:    [[TMP8:%.*]] = xor <4 x i32> [[WIDE_LOAD]], <i32 1, i32 1, i32 1, i32 1>
; DEFAULT-NEXT:    [[TMP9:%.*]] = xor <4 x i32> [[WIDE_LOAD7]], <i32 1, i32 1, i32 1, i32 1>
; DEFAULT-NEXT:    [[TMP10:%.*]] = zext <4 x i32> [[TMP8]] to <4 x i64>
; DEFAULT-NEXT:    [[TMP11:%.*]] = zext <4 x i32> [[TMP9]] to <4 x i64>
; DEFAULT-NEXT:    [[TMP12:%.*]] = zext <4 x i32> [[VEC_IND]] to <4 x i64>
; DEFAULT-NEXT:    [[TMP13:%.*]] = zext <4 x i32> [[STEP_ADD]] to <4 x i64>
; DEFAULT-NEXT:    [[TMP14:%.*]] = shl <4 x i64> [[TMP10]], [[TMP12]]
; DEFAULT-NEXT:    [[TMP15]] = shl <4 x i64> [[TMP11]], [[TMP13]]
; DEFAULT-NEXT:    [[TMP16:%.*]] = shufflevector <4 x i64> [[VECTOR_RECUR]], <4 x i64> [[TMP14]], <4 x i32> <i32 3, i32 4, i32 5, i32 6>
; DEFAULT-NEXT:    [[TMP17:%.*]] = shufflevector <4 x i64> [[TMP14]], <4 x i64> [[TMP15]], <4 x i32> <i32 3, i32 4, i32 5, i32 6>
; DEFAULT-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 8
; DEFAULT-NEXT:    [[VEC_IND_NEXT]] = add <4 x i32> [[STEP_ADD]], <i32 4, i32 4, i32 4, i32 4>
; DEFAULT-NEXT:    [[TMP18:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; DEFAULT-NEXT:    br i1 [[TMP18]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; DEFAULT:       middle.block:
; DEFAULT-NEXT:    [[VECTOR_RECUR_EXTRACT_FOR_PHI:%.*]] = extractelement <4 x i64> [[TMP15]], i32 2
; DEFAULT-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[TMP2]], [[N_VEC]]
; DEFAULT-NEXT:    [[VECTOR_RECUR_EXTRACT:%.*]] = extractelement <4 x i64> [[TMP15]], i32 3
; DEFAULT-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; DEFAULT:       scalar.ph:
; DEFAULT-NEXT:    [[SCALAR_RECUR_INIT:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[VECTOR_RECUR_EXTRACT]], [[MIDDLE_BLOCK]] ]
; DEFAULT-NEXT:    [[BC_RESUME_VAL:%.*]] = phi ptr [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ [[SRC]], [[ENTRY]] ]
; DEFAULT-NEXT:    [[BC_RESUME_VAL2:%.*]] = phi i32 [ [[IND_END1]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY]] ]
; DEFAULT-NEXT:    [[BC_RESUME_VAL4:%.*]] = phi i32 [ [[IND_END3]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY]] ]
; DEFAULT-NEXT:    br label [[LOOP:%.*]]
; DEFAULT:       loop:
; DEFAULT-NEXT:    [[SCALAR_RECUR:%.*]] = phi i64 [ [[SCALAR_RECUR_INIT]], [[SCALAR_PH]] ], [ [[SHL:%.*]], [[LOOP]] ]
; DEFAULT-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[PTR_IV_NEXT:%.*]], [[LOOP]] ]
; DEFAULT-NEXT:    [[IV_1:%.*]] = phi i32 [ [[BC_RESUME_VAL2]], [[SCALAR_PH]] ], [ [[IV_1_NEXT:%.*]], [[LOOP]] ]
; DEFAULT-NEXT:    [[IV_2:%.*]] = phi i32 [ [[BC_RESUME_VAL4]], [[SCALAR_PH]] ], [ [[IV_2_NEXT:%.*]], [[LOOP]] ]
; DEFAULT-NEXT:    [[L:%.*]] = load i32, ptr [[PTR_IV]], align 4
; DEFAULT-NEXT:    [[NOT:%.*]] = xor i32 [[L]], 1
; DEFAULT-NEXT:    [[NOT_EXT:%.*]] = zext i32 [[NOT]] to i64
; DEFAULT-NEXT:    [[IV_EXT:%.*]] = zext i32 [[IV_1]] to i64
; DEFAULT-NEXT:    [[SHL]] = shl i64 [[NOT_EXT]], [[IV_EXT]]
; DEFAULT-NEXT:    [[PTR_IV_NEXT]] = getelementptr i8, ptr [[PTR_IV]], i64 4
; DEFAULT-NEXT:    [[IV_1_NEXT]] = add i32 [[IV_1]], 1
; DEFAULT-NEXT:    [[IV_2_NEXT]] = add i32 [[IV_2]], 1
; DEFAULT-NEXT:    [[EC:%.*]] = icmp eq i32 [[IV_2_NEXT]], [[N]]
; DEFAULT-NEXT:    br i1 [[EC]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP7:![0-9]+]]
; DEFAULT:       exit:
; DEFAULT-NEXT:    [[P_LCSSA:%.*]] = phi i64 [ [[SCALAR_RECUR]], [[LOOP]] ], [ [[VECTOR_RECUR_EXTRACT_FOR_PHI]], [[MIDDLE_BLOCK]] ]
; DEFAULT-NEXT:    ret i64 [[P_LCSSA]]
;
; PRED-LABEL: define i64 @test_ptr_ivs_and_widened_ivs(
; PRED-SAME: ptr [[SRC:%.*]], i32 [[N:%.*]]) {
; PRED-NEXT:  entry:
; PRED-NEXT:    [[TMP0:%.*]] = add i32 [[N]], -1
; PRED-NEXT:    [[TMP1:%.*]] = zext i32 [[TMP0]] to i64
; PRED-NEXT:    [[TMP2:%.*]] = add nuw nsw i64 [[TMP1]], 1
; PRED-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[TMP2]], 8
; PRED-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; PRED:       vector.ph:
; PRED-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[TMP2]], 8
; PRED-NEXT:    [[N_VEC:%.*]] = sub i64 [[TMP2]], [[N_MOD_VF]]
; PRED-NEXT:    [[TMP3:%.*]] = mul i64 [[N_VEC]], 4
; PRED-NEXT:    [[IND_END:%.*]] = getelementptr i8, ptr [[SRC]], i64 [[TMP3]]
; PRED-NEXT:    [[IND_END1:%.*]] = trunc i64 [[N_VEC]] to i32
; PRED-NEXT:    [[IND_END3:%.*]] = trunc i64 [[N_VEC]] to i32
; PRED-NEXT:    br label [[VECTOR_BODY:%.*]]
; PRED:       vector.body:
; PRED-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; PRED-NEXT:    [[VECTOR_RECUR:%.*]] = phi <4 x i64> [ <i64 poison, i64 poison, i64 poison, i64 0>, [[VECTOR_PH]] ], [ [[TMP15:%.*]], [[VECTOR_BODY]] ]
; PRED-NEXT:    [[VEC_IND:%.*]] = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; PRED-NEXT:    [[STEP_ADD:%.*]] = add <4 x i32> [[VEC_IND]], <i32 4, i32 4, i32 4, i32 4>
; PRED-NEXT:    [[OFFSET_IDX:%.*]] = mul i64 [[INDEX]], 4
; PRED-NEXT:    [[TMP4:%.*]] = add i64 [[OFFSET_IDX]], 0
; PRED-NEXT:    [[TMP5:%.*]] = add i64 [[OFFSET_IDX]], 16
; PRED-NEXT:    [[NEXT_GEP:%.*]] = getelementptr i8, ptr [[SRC]], i64 [[TMP4]]
; PRED-NEXT:    [[NEXT_GEP6:%.*]] = getelementptr i8, ptr [[SRC]], i64 [[TMP5]]
; PRED-NEXT:    [[TMP6:%.*]] = getelementptr i32, ptr [[NEXT_GEP]], i32 0
; PRED-NEXT:    [[TMP7:%.*]] = getelementptr i32, ptr [[NEXT_GEP]], i32 4
; PRED-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP6]], align 4
; PRED-NEXT:    [[WIDE_LOAD7:%.*]] = load <4 x i32>, ptr [[TMP7]], align 4
; PRED-NEXT:    [[TMP8:%.*]] = xor <4 x i32> [[WIDE_LOAD]], <i32 1, i32 1, i32 1, i32 1>
; PRED-NEXT:    [[TMP9:%.*]] = xor <4 x i32> [[WIDE_LOAD7]], <i32 1, i32 1, i32 1, i32 1>
; PRED-NEXT:    [[TMP10:%.*]] = zext <4 x i32> [[TMP8]] to <4 x i64>
; PRED-NEXT:    [[TMP11:%.*]] = zext <4 x i32> [[TMP9]] to <4 x i64>
; PRED-NEXT:    [[TMP12:%.*]] = zext <4 x i32> [[VEC_IND]] to <4 x i64>
; PRED-NEXT:    [[TMP13:%.*]] = zext <4 x i32> [[STEP_ADD]] to <4 x i64>
; PRED-NEXT:    [[TMP14:%.*]] = shl <4 x i64> [[TMP10]], [[TMP12]]
; PRED-NEXT:    [[TMP15]] = shl <4 x i64> [[TMP11]], [[TMP13]]
; PRED-NEXT:    [[TMP16:%.*]] = shufflevector <4 x i64> [[VECTOR_RECUR]], <4 x i64> [[TMP14]], <4 x i32> <i32 3, i32 4, i32 5, i32 6>
; PRED-NEXT:    [[TMP17:%.*]] = shufflevector <4 x i64> [[TMP14]], <4 x i64> [[TMP15]], <4 x i32> <i32 3, i32 4, i32 5, i32 6>
; PRED-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 8
; PRED-NEXT:    [[VEC_IND_NEXT]] = add <4 x i32> [[STEP_ADD]], <i32 4, i32 4, i32 4, i32 4>
; PRED-NEXT:    [[TMP18:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; PRED-NEXT:    br i1 [[TMP18]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; PRED:       middle.block:
; PRED-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[TMP2]], [[N_VEC]]
; PRED-NEXT:    [[VECTOR_RECUR_EXTRACT:%.*]] = extractelement <4 x i64> [[TMP15]], i32 3
; PRED-NEXT:    [[VECTOR_RECUR_EXTRACT_FOR_PHI:%.*]] = extractelement <4 x i64> [[TMP15]], i32 2
; PRED-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; PRED:       scalar.ph:
; PRED-NEXT:    [[SCALAR_RECUR_INIT:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[VECTOR_RECUR_EXTRACT]], [[MIDDLE_BLOCK]] ]
; PRED-NEXT:    [[BC_RESUME_VAL:%.*]] = phi ptr [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ [[SRC]], [[ENTRY]] ]
; PRED-NEXT:    [[BC_RESUME_VAL2:%.*]] = phi i32 [ [[IND_END1]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY]] ]
; PRED-NEXT:    [[BC_RESUME_VAL4:%.*]] = phi i32 [ [[IND_END3]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY]] ]
; PRED-NEXT:    br label [[LOOP:%.*]]
; PRED:       loop:
; PRED-NEXT:    [[SCALAR_RECUR:%.*]] = phi i64 [ [[SCALAR_RECUR_INIT]], [[SCALAR_PH]] ], [ [[SHL:%.*]], [[LOOP]] ]
; PRED-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[PTR_IV_NEXT:%.*]], [[LOOP]] ]
; PRED-NEXT:    [[IV_1:%.*]] = phi i32 [ [[BC_RESUME_VAL2]], [[SCALAR_PH]] ], [ [[IV_1_NEXT:%.*]], [[LOOP]] ]
; PRED-NEXT:    [[IV_2:%.*]] = phi i32 [ [[BC_RESUME_VAL4]], [[SCALAR_PH]] ], [ [[IV_2_NEXT:%.*]], [[LOOP]] ]
; PRED-NEXT:    [[L:%.*]] = load i32, ptr [[PTR_IV]], align 4
; PRED-NEXT:    [[NOT:%.*]] = xor i32 [[L]], 1
; PRED-NEXT:    [[NOT_EXT:%.*]] = zext i32 [[NOT]] to i64
; PRED-NEXT:    [[IV_EXT:%.*]] = zext i32 [[IV_1]] to i64
; PRED-NEXT:    [[SHL]] = shl i64 [[NOT_EXT]], [[IV_EXT]]
; PRED-NEXT:    [[PTR_IV_NEXT]] = getelementptr i8, ptr [[PTR_IV]], i64 4
; PRED-NEXT:    [[IV_1_NEXT]] = add i32 [[IV_1]], 1
; PRED-NEXT:    [[IV_2_NEXT]] = add i32 [[IV_2]], 1
; PRED-NEXT:    [[EC:%.*]] = icmp eq i32 [[IV_2_NEXT]], [[N]]
; PRED-NEXT:    br i1 [[EC]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP5:![0-9]+]]
; PRED:       exit:
; PRED-NEXT:    [[P_LCSSA:%.*]] = phi i64 [ [[SCALAR_RECUR]], [[LOOP]] ], [ [[VECTOR_RECUR_EXTRACT_FOR_PHI]], [[MIDDLE_BLOCK]] ]
; PRED-NEXT:    ret i64 [[P_LCSSA]]
;
entry:
  br label %loop

loop:
  %p = phi i64 [ 0, %entry ], [ %shl, %loop ]
  %ptr.iv = phi ptr [ %src, %entry ], [ %ptr.iv.next, %loop ]
  %iv.1 = phi i32 [ 0, %entry ], [ %iv.1.next, %loop ]
  %iv.2 = phi i32 [ 0, %entry ], [ %iv.2.next, %loop ]
  %l = load i32, ptr %ptr.iv, align 4
  %not = xor i32 %l, 1
  %not.ext = zext i32 %not to i64
  %iv.ext = zext i32 %iv.1 to i64
  %shl = shl i64 %not.ext , %iv.ext
  %ptr.iv.next = getelementptr i8, ptr %ptr.iv, i64 4
  %iv.1.next = add i32 %iv.1, 1
  %iv.2.next = add i32 %iv.2, 1
  %ec = icmp eq i32 %iv.2.next, %N
  br i1 %ec, label %exit, label %loop

exit:
  ret i64 %p
}

define void @zext_iv_increment(ptr %dst, i64 %N) {
; DEFAULT-LABEL: define void @zext_iv_increment(
; DEFAULT-SAME: ptr [[DST:%.*]], i64 [[N:%.*]]) {
; DEFAULT-NEXT:  entry:
; DEFAULT-NEXT:    [[UMAX1:%.*]] = call i64 @llvm.umax.i64(i64 [[N]], i64 1)
; DEFAULT-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[UMAX1]], 2
; DEFAULT-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_SCEVCHECK:%.*]]
; DEFAULT:       vector.scevcheck:
; DEFAULT-NEXT:    [[UMAX:%.*]] = call i64 @llvm.umax.i64(i64 [[N]], i64 1)
; DEFAULT-NEXT:    [[TMP0:%.*]] = add i64 [[UMAX]], -1
; DEFAULT-NEXT:    [[TMP1:%.*]] = icmp ugt i64 [[TMP0]], 4294967295
; DEFAULT-NEXT:    [[TMP2:%.*]] = trunc i64 [[TMP0]] to i32
; DEFAULT-NEXT:    [[TMP3:%.*]] = add i32 1, [[TMP2]]
; DEFAULT-NEXT:    [[TMP4:%.*]] = icmp ult i32 [[TMP3]], 1
; DEFAULT-NEXT:    [[TMP5:%.*]] = icmp ugt i64 [[TMP0]], 4294967295
; DEFAULT-NEXT:    [[TMP6:%.*]] = or i1 [[TMP4]], [[TMP5]]
; DEFAULT-NEXT:    br i1 [[TMP6]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]
; DEFAULT:       vector.ph:
; DEFAULT-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[UMAX1]], 2
; DEFAULT-NEXT:    [[N_VEC:%.*]] = sub i64 [[UMAX1]], [[N_MOD_VF]]
; DEFAULT-NEXT:    [[IND_END:%.*]] = trunc i64 [[N_VEC]] to i32
; DEFAULT-NEXT:    br label [[VECTOR_BODY:%.*]]
; DEFAULT:       vector.body:
; DEFAULT-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; DEFAULT-NEXT:    [[TMP7:%.*]] = add i64 [[INDEX]], 0
; DEFAULT-NEXT:    [[TMP8:%.*]] = add i64 [[INDEX]], 1
; DEFAULT-NEXT:    [[TMP9:%.*]] = getelementptr { i32, i32, i32 }, ptr [[DST]], i64 [[TMP7]], i32 2
; DEFAULT-NEXT:    [[TMP10:%.*]] = getelementptr { i32, i32, i32 }, ptr [[DST]], i64 [[TMP8]], i32 2
; DEFAULT-NEXT:    store i32 0, ptr [[TMP9]], align 8
; DEFAULT-NEXT:    store i32 0, ptr [[TMP10]], align 8
; DEFAULT-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 2
; DEFAULT-NEXT:    [[TMP11:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; DEFAULT-NEXT:    br i1 [[TMP11]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP8:![0-9]+]]
; DEFAULT:       middle.block:
; DEFAULT-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[UMAX1]], [[N_VEC]]
; DEFAULT-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP173_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; DEFAULT:       scalar.ph:
; DEFAULT-NEXT:    [[BC_RESUME_VAL2:%.*]] = phi i32 [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ], [ 0, [[VECTOR_SCEVCHECK]] ]
; DEFAULT-NEXT:    [[BC_RESUME_VAL3:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY]] ], [ 0, [[VECTOR_SCEVCHECK]] ]
; DEFAULT-NEXT:    br label [[FOR_BODY174:%.*]]
; DEFAULT:       loop:
; DEFAULT-NEXT:    [[I167_0800:%.*]] = phi i32 [ [[BC_RESUME_VAL2]], [[SCALAR_PH]] ], [ [[INC179:%.*]], [[FOR_BODY174]] ]
; DEFAULT-NEXT:    [[CONV169801:%.*]] = phi i64 [ [[BC_RESUME_VAL3]], [[SCALAR_PH]] ], [ [[CONV169:%.*]], [[FOR_BODY174]] ]
; DEFAULT-NEXT:    [[PATCH_INDEX:%.*]] = getelementptr { i32, i32, i32 }, ptr [[DST]], i64 [[CONV169801]], i32 2
; DEFAULT-NEXT:    store i32 0, ptr [[PATCH_INDEX]], align 8
; DEFAULT-NEXT:    [[INC179]] = add i32 [[I167_0800]], 1
; DEFAULT-NEXT:    [[CONV169]] = zext i32 [[INC179]] to i64
; DEFAULT-NEXT:    [[CMP172:%.*]] = icmp ult i64 [[CONV169]], [[N]]
; DEFAULT-NEXT:    br i1 [[CMP172]], label [[FOR_BODY174]], label [[FOR_COND_CLEANUP173_LOOPEXIT]], !llvm.loop [[LOOP9:![0-9]+]]
; DEFAULT:       exit:
; DEFAULT-NEXT:    ret void
;
; PRED-LABEL: define void @zext_iv_increment(
; PRED-SAME: ptr [[DST:%.*]], i64 [[N:%.*]]) {
; PRED-NEXT:  entry:
; PRED-NEXT:    br label [[FOR_BODY174:%.*]]
; PRED:       loop:
; PRED-NEXT:    [[I167_0800:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[INC179:%.*]], [[FOR_BODY174]] ]
; PRED-NEXT:    [[CONV169801:%.*]] = phi i64 [ 0, [[ENTRY]] ], [ [[CONV169:%.*]], [[FOR_BODY174]] ]
; PRED-NEXT:    [[PATCH_INDEX:%.*]] = getelementptr { i32, i32, i32 }, ptr [[DST]], i64 [[CONV169801]], i32 2
; PRED-NEXT:    store i32 0, ptr [[PATCH_INDEX]], align 8
; PRED-NEXT:    [[INC179]] = add i32 [[I167_0800]], 1
; PRED-NEXT:    [[CONV169]] = zext i32 [[INC179]] to i64
; PRED-NEXT:    [[CMP172:%.*]] = icmp ult i64 [[CONV169]], [[N]]
; PRED-NEXT:    br i1 [[CMP172]], label [[FOR_BODY174]], label [[FOR_COND_CLEANUP173_LOOPEXIT:%.*]]
; PRED:       exit:
; PRED-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %iv.wide = phi i64 [ 0, %entry ], [ %iv.next.ext, %loop ]
  %patch_index = getelementptr { i32, i32, i32 }, ptr %dst, i64 %iv.wide, i32 2
  store i32 0, ptr %patch_index, align 8
  %iv.next = add i32 %iv, 1
  %iv.next.ext = zext i32 %iv.next to i64
  %ec = icmp ult i64 %iv.next.ext, %N
  br i1 %ec, label %loop, label %exit

exit:
  ret void
}

;.
; CHECK: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]], [[META2:![0-9]+]]}
; CHECK: [[META1]] = !{!"llvm.loop.isvectorized", i32 1}
; CHECK: [[META2]] = !{!"llvm.loop.unroll.runtime.disable"}
; CHECK: [[LOOP3]] = distinct !{[[LOOP3]], [[META2]], [[META1]]}
; CHECK: [[LOOP4]] = distinct !{[[LOOP4]], [[META1]], [[META2]]}
; CHECK: [[LOOP5]] = distinct !{[[LOOP5]], [[META2]], [[META1]]}
; CHECK: [[LOOP6]] = distinct !{[[LOOP6]], [[META1]], [[META2]]}
; CHECK: [[LOOP7]] = distinct !{[[LOOP7]], [[META2]], [[META1]]}
; CHECK: [[LOOP8]] = distinct !{[[LOOP8]], [[META1]], [[META2]]}
; CHECK: [[LOOP9]] = distinct !{[[LOOP9]], [[META2]], [[META1]]}
;.