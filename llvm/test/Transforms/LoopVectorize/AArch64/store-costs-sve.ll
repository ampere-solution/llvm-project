; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -p loop-vectorize -S %s | FileCheck --check-prefixes=DEFAULT %s
; RUN: opt -p loop-vectorize -prefer-predicate-over-epilogue=predicate-else-scalar-epilogue -S %s | FileCheck --check-prefixes=PRED %s

target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx14.0.0"

define void @cost_store_i8(ptr %dst) #0 {
; DEFAULT-LABEL: define void @cost_store_i8(
; DEFAULT-SAME: ptr [[DST:%.*]]) #[[ATTR0:[0-9]+]] {
; DEFAULT-NEXT:  iter.check:
; DEFAULT-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; DEFAULT-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 8
; DEFAULT-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 101, [[TMP1]]
; DEFAULT-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[VEC_EPILOG_SCALAR_PH:%.*]], label [[VECTOR_MAIN_LOOP_ITER_CHECK:%.*]]
; DEFAULT:       vector.main.loop.iter.check:
; DEFAULT-NEXT:    [[TMP2:%.*]] = call i64 @llvm.vscale.i64()
; DEFAULT-NEXT:    [[TMP3:%.*]] = mul i64 [[TMP2]], 16
; DEFAULT-NEXT:    [[MIN_ITERS_CHECK1:%.*]] = icmp ult i64 101, [[TMP3]]
; DEFAULT-NEXT:    br i1 [[MIN_ITERS_CHECK1]], label [[VEC_EPILOG_PH:%.*]], label [[VECTOR_PH:%.*]]
; DEFAULT:       vector.ph:
; DEFAULT-NEXT:    [[TMP4:%.*]] = call i64 @llvm.vscale.i64()
; DEFAULT-NEXT:    [[TMP5:%.*]] = mul i64 [[TMP4]], 16
; DEFAULT-NEXT:    [[N_MOD_VF:%.*]] = urem i64 101, [[TMP5]]
; DEFAULT-NEXT:    [[N_VEC:%.*]] = sub i64 101, [[N_MOD_VF]]
; DEFAULT-NEXT:    [[TMP6:%.*]] = call i64 @llvm.vscale.i64()
; DEFAULT-NEXT:    [[TMP7:%.*]] = mul i64 [[TMP6]], 16
; DEFAULT-NEXT:    br label [[VECTOR_BODY:%.*]]
; DEFAULT:       vector.body:
; DEFAULT-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; DEFAULT-NEXT:    [[TMP8:%.*]] = add i64 [[INDEX]], 0
; DEFAULT-NEXT:    [[TMP9:%.*]] = getelementptr i8, ptr [[DST]], i64 [[TMP8]]
; DEFAULT-NEXT:    [[TMP10:%.*]] = getelementptr i8, ptr [[TMP9]], i32 0
; DEFAULT-NEXT:    store <vscale x 16 x i8> zeroinitializer, ptr [[TMP10]], align 1
; DEFAULT-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], [[TMP7]]
; DEFAULT-NEXT:    [[TMP11:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; DEFAULT-NEXT:    br i1 [[TMP11]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; DEFAULT:       middle.block:
; DEFAULT-NEXT:    [[CMP_N:%.*]] = icmp eq i64 101, [[N_VEC]]
; DEFAULT-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[VEC_EPILOG_ITER_CHECK:%.*]]
; DEFAULT:       vec.epilog.iter.check:
; DEFAULT-NEXT:    [[N_VEC_REMAINING:%.*]] = sub i64 101, [[N_VEC]]
; DEFAULT-NEXT:    [[TMP12:%.*]] = call i64 @llvm.vscale.i64()
; DEFAULT-NEXT:    [[TMP13:%.*]] = mul i64 [[TMP12]], 8
; DEFAULT-NEXT:    [[MIN_EPILOG_ITERS_CHECK:%.*]] = icmp ult i64 [[N_VEC_REMAINING]], [[TMP13]]
; DEFAULT-NEXT:    br i1 [[MIN_EPILOG_ITERS_CHECK]], label [[VEC_EPILOG_SCALAR_PH]], label [[VEC_EPILOG_PH]]
; DEFAULT:       vec.epilog.ph:
; DEFAULT-NEXT:    [[VEC_EPILOG_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[VEC_EPILOG_ITER_CHECK]] ], [ 0, [[VECTOR_MAIN_LOOP_ITER_CHECK]] ]
; DEFAULT-NEXT:    [[TMP14:%.*]] = call i64 @llvm.vscale.i64()
; DEFAULT-NEXT:    [[TMP15:%.*]] = mul i64 [[TMP14]], 8
; DEFAULT-NEXT:    [[N_MOD_VF2:%.*]] = urem i64 101, [[TMP15]]
; DEFAULT-NEXT:    [[N_VEC3:%.*]] = sub i64 101, [[N_MOD_VF2]]
; DEFAULT-NEXT:    [[TMP16:%.*]] = call i64 @llvm.vscale.i64()
; DEFAULT-NEXT:    [[TMP17:%.*]] = mul i64 [[TMP16]], 8
; DEFAULT-NEXT:    br label [[VEC_EPILOG_VECTOR_BODY:%.*]]
; DEFAULT:       vec.epilog.vector.body:
; DEFAULT-NEXT:    [[INDEX5:%.*]] = phi i64 [ [[VEC_EPILOG_RESUME_VAL]], [[VEC_EPILOG_PH]] ], [ [[INDEX_NEXT6:%.*]], [[VEC_EPILOG_VECTOR_BODY]] ]
; DEFAULT-NEXT:    [[TMP18:%.*]] = add i64 [[INDEX5]], 0
; DEFAULT-NEXT:    [[TMP19:%.*]] = getelementptr i8, ptr [[DST]], i64 [[TMP18]]
; DEFAULT-NEXT:    [[TMP20:%.*]] = getelementptr i8, ptr [[TMP19]], i32 0
; DEFAULT-NEXT:    store <vscale x 8 x i8> zeroinitializer, ptr [[TMP20]], align 1
; DEFAULT-NEXT:    [[INDEX_NEXT6]] = add nuw i64 [[INDEX5]], [[TMP17]]
; DEFAULT-NEXT:    [[TMP21:%.*]] = icmp eq i64 [[INDEX_NEXT6]], [[N_VEC3]]
; DEFAULT-NEXT:    br i1 [[TMP21]], label [[VEC_EPILOG_MIDDLE_BLOCK:%.*]], label [[VEC_EPILOG_VECTOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
; DEFAULT:       vec.epilog.middle.block:
; DEFAULT-NEXT:    [[CMP_N4:%.*]] = icmp eq i64 101, [[N_VEC3]]
; DEFAULT-NEXT:    br i1 [[CMP_N4]], label [[EXIT]], label [[VEC_EPILOG_SCALAR_PH]]
; DEFAULT:       vec.epilog.scalar.ph:
; DEFAULT-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC3]], [[VEC_EPILOG_MIDDLE_BLOCK]] ], [ [[N_VEC]], [[VEC_EPILOG_ITER_CHECK]] ], [ 0, [[ITER_CHECK:%.*]] ]
; DEFAULT-NEXT:    br label [[LOOP:%.*]]
; DEFAULT:       loop:
; DEFAULT-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[VEC_EPILOG_SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; DEFAULT-NEXT:    [[GEP:%.*]] = getelementptr i8, ptr [[DST]], i64 [[IV]]
; DEFAULT-NEXT:    store i8 0, ptr [[GEP]], align 1
; DEFAULT-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; DEFAULT-NEXT:    [[EC:%.*]] = icmp eq i64 [[IV]], 100
; DEFAULT-NEXT:    br i1 [[EC]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP4:![0-9]+]]
; DEFAULT:       exit:
; DEFAULT-NEXT:    ret void
;
; PRED-LABEL: define void @cost_store_i8(
; PRED-SAME: ptr [[DST:%.*]]) #[[ATTR0:[0-9]+]] {
; PRED-NEXT:  entry:
; PRED-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; PRED:       vector.ph:
; PRED-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; PRED-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 16
; PRED-NEXT:    [[TMP4:%.*]] = sub i64 [[TMP1]], 1
; PRED-NEXT:    [[N_RND_UP:%.*]] = add i64 101, [[TMP4]]
; PRED-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N_RND_UP]], [[TMP1]]
; PRED-NEXT:    [[N_VEC:%.*]] = sub i64 [[N_RND_UP]], [[N_MOD_VF]]
; PRED-NEXT:    [[TMP5:%.*]] = call i64 @llvm.vscale.i64()
; PRED-NEXT:    [[TMP6:%.*]] = mul i64 [[TMP5]], 16
; PRED-NEXT:    [[TMP7:%.*]] = call i64 @llvm.vscale.i64()
; PRED-NEXT:    [[TMP8:%.*]] = mul i64 [[TMP7]], 16
; PRED-NEXT:    [[TMP9:%.*]] = sub i64 101, [[TMP8]]
; PRED-NEXT:    [[TMP10:%.*]] = icmp ugt i64 101, [[TMP8]]
; PRED-NEXT:    [[TMP11:%.*]] = select i1 [[TMP10]], i64 [[TMP9]], i64 0
; PRED-NEXT:    [[ACTIVE_LANE_MASK_ENTRY:%.*]] = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 0, i64 101)
; PRED-NEXT:    br label [[VECTOR_BODY:%.*]]
; PRED:       vector.body:
; PRED-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; PRED-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = phi <vscale x 16 x i1> [ [[ACTIVE_LANE_MASK_ENTRY]], [[VECTOR_PH]] ], [ [[ACTIVE_LANE_MASK_NEXT:%.*]], [[VECTOR_BODY]] ]
; PRED-NEXT:    [[TMP12:%.*]] = add i64 [[INDEX]], 0
; PRED-NEXT:    [[TMP13:%.*]] = getelementptr i8, ptr [[DST]], i64 [[TMP12]]
; PRED-NEXT:    [[TMP14:%.*]] = getelementptr i8, ptr [[TMP13]], i32 0
; PRED-NEXT:    call void @llvm.masked.store.nxv16i8.p0(<vscale x 16 x i8> zeroinitializer, ptr [[TMP14]], i32 1, <vscale x 16 x i1> [[ACTIVE_LANE_MASK]])
; PRED-NEXT:    [[INDEX_NEXT]] = add i64 [[INDEX]], [[TMP6]]
; PRED-NEXT:    [[ACTIVE_LANE_MASK_NEXT]] = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 [[INDEX]], i64 [[TMP11]])
; PRED-NEXT:    [[TMP15:%.*]] = xor <vscale x 16 x i1> [[ACTIVE_LANE_MASK_NEXT]], shufflevector (<vscale x 16 x i1> insertelement (<vscale x 16 x i1> poison, i1 true, i64 0), <vscale x 16 x i1> poison, <vscale x 16 x i32> zeroinitializer)
; PRED-NEXT:    [[TMP16:%.*]] = extractelement <vscale x 16 x i1> [[TMP15]], i32 0
; PRED-NEXT:    br i1 [[TMP16]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; PRED:       middle.block:
; PRED-NEXT:    br i1 true, label [[EXIT:%.*]], label [[SCALAR_PH]]
; PRED:       scalar.ph:
; PRED-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; PRED-NEXT:    br label [[LOOP:%.*]]
; PRED:       loop:
; PRED-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; PRED-NEXT:    [[GEP:%.*]] = getelementptr i8, ptr [[DST]], i64 [[IV]]
; PRED-NEXT:    store i8 0, ptr [[GEP]], align 1
; PRED-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; PRED-NEXT:    [[EC:%.*]] = icmp eq i64 [[IV]], 100
; PRED-NEXT:    br i1 [[EC]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP3:![0-9]+]]
; PRED:       exit:
; PRED-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep = getelementptr i8, ptr %dst, i64 %iv
  store i8 0, ptr %gep, align 1
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv, 100
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @trunc_store(ptr %dst, ptr %src, i16 %x) #1 {
; DEFAULT-LABEL: define void @trunc_store(
; DEFAULT-SAME: ptr [[DST:%.*]], ptr [[SRC:%.*]], i16 [[X:%.*]]) #[[ATTR1:[0-9]+]] {
; DEFAULT-NEXT:  iter.check:
; DEFAULT-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; DEFAULT-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 2
; DEFAULT-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 0, [[TMP1]]
; DEFAULT-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[VEC_EPILOG_SCALAR_PH:%.*]], label [[VECTOR_MEMCHECK:%.*]]
; DEFAULT:       vector.memcheck:
; DEFAULT-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[SRC]], i64 8
; DEFAULT-NEXT:    [[BOUND0:%.*]] = icmp ult ptr [[DST]], [[SCEVGEP]]
; DEFAULT-NEXT:    [[BOUND1:%.*]] = icmp ult ptr [[SRC]], [[DST]]
; DEFAULT-NEXT:    [[FOUND_CONFLICT:%.*]] = and i1 [[BOUND0]], [[BOUND1]]
; DEFAULT-NEXT:    br i1 [[FOUND_CONFLICT]], label [[VEC_EPILOG_SCALAR_PH]], label [[VECTOR_MAIN_LOOP_ITER_CHECK:%.*]]
; DEFAULT:       vector.main.loop.iter.check:
; DEFAULT-NEXT:    br i1 true, label [[VEC_EPILOG_PH:%.*]], label [[VECTOR_PH:%.*]]
; DEFAULT:       vector.ph:
; DEFAULT-NEXT:    [[BROADCAST_SPLATINSERT3:%.*]] = insertelement <16 x i16> poison, i16 [[X]], i64 0
; DEFAULT-NEXT:    [[BROADCAST_SPLAT4:%.*]] = shufflevector <16 x i16> [[BROADCAST_SPLATINSERT3]], <16 x i16> poison, <16 x i32> zeroinitializer
; DEFAULT-NEXT:    [[TMP7:%.*]] = trunc <16 x i16> [[BROADCAST_SPLAT4]] to <16 x i8>
; DEFAULT-NEXT:    br label [[VECTOR_BODY:%.*]]
; DEFAULT:       vector.body:
; DEFAULT-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; DEFAULT-NEXT:    [[TMP2:%.*]] = add i64 [[INDEX]], 0
; DEFAULT-NEXT:    [[TMP4:%.*]] = load i64, ptr [[SRC]], align 8, !alias.scope [[META5:![0-9]+]]
; DEFAULT-NEXT:    [[BROADCAST_SPLATINSERT1:%.*]] = insertelement <16 x i64> poison, i64 [[TMP4]], i64 0
; DEFAULT-NEXT:    [[BROADCAST_SPLAT2:%.*]] = shufflevector <16 x i64> [[BROADCAST_SPLATINSERT1]], <16 x i64> poison, <16 x i32> zeroinitializer
; DEFAULT-NEXT:    [[TMP5:%.*]] = trunc <16 x i64> [[BROADCAST_SPLAT2]] to <16 x i8>
; DEFAULT-NEXT:    [[TMP8:%.*]] = and <16 x i8> [[TMP5]], [[TMP7]]
; DEFAULT-NEXT:    [[TMP9:%.*]] = and <16 x i8> [[TMP5]], [[TMP7]]
; DEFAULT-NEXT:    [[TMP10:%.*]] = getelementptr i8, ptr [[DST]], i64 [[TMP2]]
; DEFAULT-NEXT:    [[TMP12:%.*]] = getelementptr i8, ptr [[TMP10]], i32 0
; DEFAULT-NEXT:    [[TMP13:%.*]] = getelementptr i8, ptr [[TMP10]], i32 16
; DEFAULT-NEXT:    store <16 x i8> [[TMP8]], ptr [[TMP12]], align 1, !alias.scope [[META8:![0-9]+]], !noalias [[META5]]
; DEFAULT-NEXT:    store <16 x i8> [[TMP9]], ptr [[TMP13]], align 1, !alias.scope [[META8]], !noalias [[META5]]
; DEFAULT-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 32
; DEFAULT-NEXT:    [[TMP14:%.*]] = icmp eq i64 [[INDEX_NEXT]], 0
; DEFAULT-NEXT:    br i1 [[TMP14]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP10:![0-9]+]]
; DEFAULT:       middle.block:
; DEFAULT-NEXT:    br i1 true, label [[EXIT:%.*]], label [[VEC_EPILOG_ITER_CHECK:%.*]]
; DEFAULT:       vec.epilog.iter.check:
; DEFAULT-NEXT:    [[TMP15:%.*]] = call i64 @llvm.vscale.i64()
; DEFAULT-NEXT:    [[TMP16:%.*]] = mul i64 [[TMP15]], 2
; DEFAULT-NEXT:    [[MIN_EPILOG_ITERS_CHECK:%.*]] = icmp ult i64 0, [[TMP16]]
; DEFAULT-NEXT:    br i1 [[MIN_EPILOG_ITERS_CHECK]], label [[VEC_EPILOG_SCALAR_PH]], label [[VEC_EPILOG_PH]]
; DEFAULT:       vec.epilog.ph:
; DEFAULT-NEXT:    [[VEC_EPILOG_RESUME_VAL:%.*]] = phi i64 [ 0, [[VEC_EPILOG_ITER_CHECK]] ], [ 0, [[VECTOR_MAIN_LOOP_ITER_CHECK]] ]
; DEFAULT-NEXT:    [[TMP17:%.*]] = call i64 @llvm.vscale.i64()
; DEFAULT-NEXT:    [[TMP18:%.*]] = mul i64 [[TMP17]], 2
; DEFAULT-NEXT:    [[N_MOD_VF:%.*]] = urem i64 0, [[TMP18]]
; DEFAULT-NEXT:    [[N_VEC:%.*]] = sub i64 0, [[N_MOD_VF]]
; DEFAULT-NEXT:    [[TMP19:%.*]] = call i64 @llvm.vscale.i64()
; DEFAULT-NEXT:    [[TMP20:%.*]] = mul i64 [[TMP19]], 2
; DEFAULT-NEXT:    [[BROADCAST_SPLATINSERT6:%.*]] = insertelement <vscale x 2 x i16> poison, i16 [[X]], i64 0
; DEFAULT-NEXT:    [[BROADCAST_SPLAT7:%.*]] = shufflevector <vscale x 2 x i16> [[BROADCAST_SPLATINSERT6]], <vscale x 2 x i16> poison, <vscale x 2 x i32> zeroinitializer
; DEFAULT-NEXT:    [[TMP24:%.*]] = trunc <vscale x 2 x i16> [[BROADCAST_SPLAT7]] to <vscale x 2 x i8>
; DEFAULT-NEXT:    br label [[VEC_EPILOG_VECTOR_BODY:%.*]]
; DEFAULT:       vec.epilog.vector.body:
; DEFAULT-NEXT:    [[INDEX5:%.*]] = phi i64 [ [[VEC_EPILOG_RESUME_VAL]], [[VEC_EPILOG_PH]] ], [ [[INDEX_NEXT8:%.*]], [[VEC_EPILOG_VECTOR_BODY]] ]
; DEFAULT-NEXT:    [[TMP21:%.*]] = add i64 [[INDEX5]], 0
; DEFAULT-NEXT:    [[TMP22:%.*]] = load i64, ptr [[SRC]], align 8, !alias.scope [[META11:![0-9]+]]
; DEFAULT-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[TMP22]], i64 0
; DEFAULT-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <vscale x 2 x i64> [[BROADCAST_SPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
; DEFAULT-NEXT:    [[TMP23:%.*]] = trunc <vscale x 2 x i64> [[BROADCAST_SPLAT]] to <vscale x 2 x i8>
; DEFAULT-NEXT:    [[TMP25:%.*]] = and <vscale x 2 x i8> [[TMP23]], [[TMP24]]
; DEFAULT-NEXT:    [[TMP26:%.*]] = getelementptr i8, ptr [[DST]], i64 [[TMP21]]
; DEFAULT-NEXT:    [[TMP27:%.*]] = getelementptr i8, ptr [[TMP26]], i32 0
; DEFAULT-NEXT:    store <vscale x 2 x i8> [[TMP25]], ptr [[TMP27]], align 1, !alias.scope [[META14:![0-9]+]], !noalias [[META11]]
; DEFAULT-NEXT:    [[INDEX_NEXT8]] = add nuw i64 [[INDEX5]], [[TMP20]]
; DEFAULT-NEXT:    [[TMP28:%.*]] = icmp eq i64 [[INDEX_NEXT8]], [[N_VEC]]
; DEFAULT-NEXT:    br i1 [[TMP28]], label [[VEC_EPILOG_MIDDLE_BLOCK:%.*]], label [[VEC_EPILOG_VECTOR_BODY]], !llvm.loop [[LOOP16:![0-9]+]]
; DEFAULT:       vec.epilog.middle.block:
; DEFAULT-NEXT:    [[CMP_N:%.*]] = icmp eq i64 0, [[N_VEC]]
; DEFAULT-NEXT:    br i1 [[CMP_N]], label [[EXIT]], label [[VEC_EPILOG_SCALAR_PH]]
; DEFAULT:       vec.epilog.scalar.ph:
; DEFAULT-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[VEC_EPILOG_MIDDLE_BLOCK]] ], [ 0, [[VEC_EPILOG_ITER_CHECK]] ], [ 0, [[VECTOR_MEMCHECK]] ], [ 0, [[ITER_CHECK:%.*]] ]
; DEFAULT-NEXT:    br label [[LOOP:%.*]]
; DEFAULT:       loop:
; DEFAULT-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[VEC_EPILOG_SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; DEFAULT-NEXT:    [[X_EXT:%.*]] = zext i16 [[X]] to i64
; DEFAULT-NEXT:    [[L:%.*]] = load i64, ptr [[SRC]], align 8
; DEFAULT-NEXT:    [[AND:%.*]] = and i64 [[L]], [[X_EXT]]
; DEFAULT-NEXT:    [[TRUNC:%.*]] = trunc i64 [[AND]] to i8
; DEFAULT-NEXT:    [[GEP:%.*]] = getelementptr i8, ptr [[DST]], i64 [[IV]]
; DEFAULT-NEXT:    store i8 [[TRUNC]], ptr [[GEP]], align 1
; DEFAULT-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; DEFAULT-NEXT:    [[EC:%.*]] = icmp eq i64 [[IV_NEXT]], 0
; DEFAULT-NEXT:    br i1 [[EC]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP17:![0-9]+]]
; DEFAULT:       exit:
; DEFAULT-NEXT:    ret void
;
; PRED-LABEL: define void @trunc_store(
; PRED-SAME: ptr [[DST:%.*]], ptr [[SRC:%.*]], i16 [[X:%.*]]) #[[ATTR1:[0-9]+]] {
; PRED-NEXT:  entry:
; PRED-NEXT:    br i1 true, label [[SCALAR_PH:%.*]], label [[VECTOR_MEMCHECK:%.*]]
; PRED:       vector.memcheck:
; PRED-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[SRC]], i64 8
; PRED-NEXT:    [[BOUND0:%.*]] = icmp ult ptr [[DST]], [[SCEVGEP]]
; PRED-NEXT:    [[BOUND1:%.*]] = icmp ult ptr [[SRC]], [[DST]]
; PRED-NEXT:    [[FOUND_CONFLICT:%.*]] = and i1 [[BOUND0]], [[BOUND1]]
; PRED-NEXT:    br i1 [[FOUND_CONFLICT]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]
; PRED:       vector.ph:
; PRED-NEXT:    [[BROADCAST_SPLATINSERT1:%.*]] = insertelement <16 x i16> poison, i16 [[X]], i64 0
; PRED-NEXT:    [[BROADCAST_SPLAT2:%.*]] = shufflevector <16 x i16> [[BROADCAST_SPLATINSERT1]], <16 x i16> poison, <16 x i32> zeroinitializer
; PRED-NEXT:    [[TMP3:%.*]] = trunc <16 x i16> [[BROADCAST_SPLAT2]] to <16 x i8>
; PRED-NEXT:    br label [[VECTOR_BODY:%.*]]
; PRED:       vector.body:
; PRED-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; PRED-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; PRED-NEXT:    [[TMP1:%.*]] = load i64, ptr [[SRC]], align 8, !alias.scope [[META4:![0-9]+]]
; PRED-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <16 x i64> poison, i64 [[TMP1]], i64 0
; PRED-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <16 x i64> [[BROADCAST_SPLATINSERT]], <16 x i64> poison, <16 x i32> zeroinitializer
; PRED-NEXT:    [[TMP2:%.*]] = trunc <16 x i64> [[BROADCAST_SPLAT]] to <16 x i8>
; PRED-NEXT:    [[TMP4:%.*]] = and <16 x i8> [[TMP2]], [[TMP3]]
; PRED-NEXT:    [[TMP5:%.*]] = getelementptr i8, ptr [[DST]], i64 [[TMP0]]
; PRED-NEXT:    [[TMP6:%.*]] = getelementptr i8, ptr [[TMP5]], i32 0
; PRED-NEXT:    store <16 x i8> [[TMP4]], ptr [[TMP6]], align 1, !alias.scope [[META7:![0-9]+]], !noalias [[META4]]
; PRED-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; PRED-NEXT:    [[TMP7:%.*]] = icmp eq i64 [[INDEX_NEXT]], 0
; PRED-NEXT:    br i1 [[TMP7]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP9:![0-9]+]]
; PRED:       middle.block:
; PRED-NEXT:    br i1 true, label [[EXIT:%.*]], label [[SCALAR_PH]]
; PRED:       scalar.ph:
; PRED-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 0, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ], [ 0, [[VECTOR_MEMCHECK]] ]
; PRED-NEXT:    br label [[LOOP:%.*]]
; PRED:       loop:
; PRED-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; PRED-NEXT:    [[X_EXT:%.*]] = zext i16 [[X]] to i64
; PRED-NEXT:    [[L:%.*]] = load i64, ptr [[SRC]], align 8
; PRED-NEXT:    [[AND:%.*]] = and i64 [[L]], [[X_EXT]]
; PRED-NEXT:    [[TRUNC:%.*]] = trunc i64 [[AND]] to i8
; PRED-NEXT:    [[GEP:%.*]] = getelementptr i8, ptr [[DST]], i64 [[IV]]
; PRED-NEXT:    store i8 [[TRUNC]], ptr [[GEP]], align 1
; PRED-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; PRED-NEXT:    [[EC:%.*]] = icmp eq i64 [[IV_NEXT]], 0
; PRED-NEXT:    br i1 [[EC]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP10:![0-9]+]]
; PRED:       exit:
; PRED-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %x.ext = zext i16 %x to i64
  %l = load i64, ptr %src, align 8
  %and = and i64 %l, %x.ext
  %trunc = trunc i64 %and to i8
  %gep = getelementptr i8, ptr %dst, i64 %iv
  store i8 %trunc, ptr %gep, align 1
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv.next, 0
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

attributes #0 = { "target-features"="+sve" }
attributes #1 = { vscale_range(1,16) "target-features"="+sve" }


;.
; DEFAULT: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]], [[META2:![0-9]+]]}
; DEFAULT: [[META1]] = !{!"llvm.loop.isvectorized", i32 1}
; DEFAULT: [[META2]] = !{!"llvm.loop.unroll.runtime.disable"}
; DEFAULT: [[LOOP3]] = distinct !{[[LOOP3]], [[META1]], [[META2]]}
; DEFAULT: [[LOOP4]] = distinct !{[[LOOP4]], [[META2]], [[META1]]}
; DEFAULT: [[META5]] = !{[[META6:![0-9]+]]}
; DEFAULT: [[META6]] = distinct !{[[META6]], [[META7:![0-9]+]]}
; DEFAULT: [[META7]] = distinct !{[[META7]], !"LVerDomain"}
; DEFAULT: [[META8]] = !{[[META9:![0-9]+]]}
; DEFAULT: [[META9]] = distinct !{[[META9]], [[META7]]}
; DEFAULT: [[LOOP10]] = distinct !{[[LOOP10]], [[META1]], [[META2]]}
; DEFAULT: [[META11]] = !{[[META12:![0-9]+]]}
; DEFAULT: [[META12]] = distinct !{[[META12]], [[META13:![0-9]+]]}
; DEFAULT: [[META13]] = distinct !{[[META13]], !"LVerDomain"}
; DEFAULT: [[META14]] = !{[[META15:![0-9]+]]}
; DEFAULT: [[META15]] = distinct !{[[META15]], [[META13]]}
; DEFAULT: [[LOOP16]] = distinct !{[[LOOP16]], [[META1]], [[META2]]}
; DEFAULT: [[LOOP17]] = distinct !{[[LOOP17]], [[META1]]}
;.
; PRED: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]], [[META2:![0-9]+]]}
; PRED: [[META1]] = !{!"llvm.loop.isvectorized", i32 1}
; PRED: [[META2]] = !{!"llvm.loop.unroll.runtime.disable"}
; PRED: [[LOOP3]] = distinct !{[[LOOP3]], [[META2]], [[META1]]}
; PRED: [[META4]] = !{[[META5:![0-9]+]]}
; PRED: [[META5]] = distinct !{[[META5]], [[META6:![0-9]+]]}
; PRED: [[META6]] = distinct !{[[META6]], !"LVerDomain"}
; PRED: [[META7]] = !{[[META8:![0-9]+]]}
; PRED: [[META8]] = distinct !{[[META8]], [[META6]]}
; PRED: [[LOOP9]] = distinct !{[[LOOP9]], [[META1]], [[META2]]}
; PRED: [[LOOP10]] = distinct !{[[LOOP10]], [[META1]]}
;.