; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt < %s -passes=amdgpu-sw-lower-lds -S -mtriple=amdgcn-amd-amdhsa | FileCheck %s

; Test to check when multiple  kernels access the same non-kernel, LDS accesses are lowere correctly.
@lds_1 = internal addrspace(3) global [1 x i8] poison, align 1
@lds_2 = internal addrspace(3) global [1 x i32] poison, align 2
@lds_3 = external addrspace(3) global [0 x i8], align 4
@lds_4 = external addrspace(3) global [0 x i8], align 8

define void @use_variables_1() sanitize_address {
; CHECK-LABEL: define void @use_variables_1(
; CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.amdgcn.lds.kernel.id()
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [2 x ptr addrspace(3)], ptr addrspace(1) @llvm.amdgcn.sw.lds.base.table, i32 0, i32 [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = load ptr addrspace(3), ptr addrspace(1) [[TMP2]], align 4
; CHECK-NEXT:    [[TMP7:%.*]] = load ptr addrspace(1), ptr addrspace(3) [[TMP4]], align 8
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [2 x [4 x ptr addrspace(1)]], ptr addrspace(1) @llvm.amdgcn.sw.lds.offset.table, i32 0, i32 [[TMP1]], i32 2
; CHECK-NEXT:    [[TMP5:%.*]] = load ptr addrspace(1), ptr addrspace(1) [[TMP6]], align 8
; CHECK-NEXT:    [[TMP8:%.*]] = load i32, ptr addrspace(1) [[TMP5]], align 4
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i8, ptr addrspace(3) [[TMP4]], i32 [[TMP8]]
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds [2 x [4 x ptr addrspace(1)]], ptr addrspace(1) @llvm.amdgcn.sw.lds.offset.table, i32 0, i32 [[TMP1]], i32 3
; CHECK-NEXT:    [[TMP12:%.*]] = load ptr addrspace(1), ptr addrspace(1) [[TMP11]], align 8
; CHECK-NEXT:    [[TMP10:%.*]] = load i32, ptr addrspace(1) [[TMP12]], align 4
; CHECK-NEXT:    [[TMP15:%.*]] = getelementptr inbounds i8, ptr addrspace(3) [[TMP4]], i32 [[TMP10]]
; CHECK-NEXT:    [[TMP13:%.*]] = ptrtoint ptr addrspace(3) [[TMP9]] to i32
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP7]], i32 [[TMP13]]
; CHECK-NEXT:    [[TMP47:%.*]] = ptrtoint ptr addrspace(1) [[TMP14]] to i64
; CHECK-NEXT:    [[TMP16:%.*]] = lshr i64 [[TMP47]], 3
; CHECK-NEXT:    [[TMP17:%.*]] = add i64 [[TMP16]], 2147450880
; CHECK-NEXT:    [[TMP18:%.*]] = inttoptr i64 [[TMP17]] to ptr
; CHECK-NEXT:    [[TMP19:%.*]] = load i8, ptr [[TMP18]], align 1
; CHECK-NEXT:    [[TMP20:%.*]] = icmp ne i8 [[TMP19]], 0
; CHECK-NEXT:    [[TMP21:%.*]] = and i64 [[TMP47]], 7
; CHECK-NEXT:    [[TMP22:%.*]] = trunc i64 [[TMP21]] to i8
; CHECK-NEXT:    [[TMP23:%.*]] = icmp sge i8 [[TMP22]], [[TMP19]]
; CHECK-NEXT:    [[TMP24:%.*]] = and i1 [[TMP20]], [[TMP23]]
; CHECK-NEXT:    [[TMP25:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP24]])
; CHECK-NEXT:    [[TMP26:%.*]] = icmp ne i64 [[TMP25]], 0
; CHECK-NEXT:    br i1 [[TMP26]], label [[ASAN_REPORT:%.*]], label [[TMP29:%.*]], !prof [[PROF3:![0-9]+]]
; CHECK:       asan.report:
; CHECK-NEXT:    br i1 [[TMP24]], label [[TMP27:%.*]], label [[TMP28:%.*]]
; CHECK:       27:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP47]]) #[[ATTR7:[0-9]+]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[TMP28]]
; CHECK:       28:
; CHECK-NEXT:    br label [[TMP29]]
; CHECK:       29:
; CHECK-NEXT:    store i8 3, ptr addrspace(1) [[TMP14]], align 4
; CHECK-NEXT:    [[TMP30:%.*]] = ptrtoint ptr addrspace(3) [[TMP15]] to i32
; CHECK-NEXT:    [[TMP31:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP7]], i32 [[TMP30]]
; CHECK-NEXT:    [[TMP32:%.*]] = ptrtoint ptr addrspace(1) [[TMP31]] to i64
; CHECK-NEXT:    [[TMP33:%.*]] = lshr i64 [[TMP32]], 3
; CHECK-NEXT:    [[TMP34:%.*]] = add i64 [[TMP33]], 2147450880
; CHECK-NEXT:    [[TMP35:%.*]] = inttoptr i64 [[TMP34]] to ptr
; CHECK-NEXT:    [[TMP36:%.*]] = load i8, ptr [[TMP35]], align 1
; CHECK-NEXT:    [[TMP37:%.*]] = icmp ne i8 [[TMP36]], 0
; CHECK-NEXT:    [[TMP38:%.*]] = and i64 [[TMP32]], 7
; CHECK-NEXT:    [[TMP39:%.*]] = trunc i64 [[TMP38]] to i8
; CHECK-NEXT:    [[TMP40:%.*]] = icmp sge i8 [[TMP39]], [[TMP36]]
; CHECK-NEXT:    [[TMP41:%.*]] = and i1 [[TMP37]], [[TMP40]]
; CHECK-NEXT:    [[TMP42:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP41]])
; CHECK-NEXT:    [[TMP43:%.*]] = icmp ne i64 [[TMP42]], 0
; CHECK-NEXT:    br i1 [[TMP43]], label [[ASAN_REPORT1:%.*]], label [[TMP46:%.*]], !prof [[PROF3]]
; CHECK:       asan.report1:
; CHECK-NEXT:    br i1 [[TMP41]], label [[TMP44:%.*]], label [[TMP45:%.*]]
; CHECK:       44:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP32]]) #[[ATTR7]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[TMP45]]
; CHECK:       45:
; CHECK-NEXT:    br label [[TMP46]]
; CHECK:       46:
; CHECK-NEXT:    store i8 3, ptr addrspace(1) [[TMP31]], align 8
; CHECK-NEXT:    ret void
;
  store i8 3, ptr addrspace(3) @lds_3, align 4
  store i8 3, ptr addrspace(3) @lds_4, align 8
  ret void
}

define void @use_variables_2() sanitize_address {
; CHECK-LABEL: define void @use_variables_2(
; CHECK-SAME: ) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.amdgcn.lds.kernel.id()
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [2 x ptr addrspace(3)], ptr addrspace(1) @llvm.amdgcn.sw.lds.base.table, i32 0, i32 [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = load ptr addrspace(3), ptr addrspace(1) [[TMP2]], align 4
; CHECK-NEXT:    [[TMP7:%.*]] = load ptr addrspace(1), ptr addrspace(3) [[TMP4]], align 8
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [2 x [4 x ptr addrspace(1)]], ptr addrspace(1) @llvm.amdgcn.sw.lds.offset.table, i32 0, i32 [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = load ptr addrspace(1), ptr addrspace(1) [[TMP6]], align 8
; CHECK-NEXT:    [[TMP8:%.*]] = load i32, ptr addrspace(1) [[TMP5]], align 4
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i8, ptr addrspace(3) [[TMP4]], i32 [[TMP8]]
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds [2 x [4 x ptr addrspace(1)]], ptr addrspace(1) @llvm.amdgcn.sw.lds.offset.table, i32 0, i32 [[TMP1]], i32 1
; CHECK-NEXT:    [[TMP12:%.*]] = load ptr addrspace(1), ptr addrspace(1) [[TMP11]], align 8
; CHECK-NEXT:    [[TMP10:%.*]] = load i32, ptr addrspace(1) [[TMP12]], align 4
; CHECK-NEXT:    [[TMP15:%.*]] = getelementptr inbounds i8, ptr addrspace(3) [[TMP4]], i32 [[TMP10]]
; CHECK-NEXT:    [[TMP13:%.*]] = ptrtoint ptr addrspace(3) [[TMP9]] to i32
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP7]], i32 [[TMP13]]
; CHECK-NEXT:    [[TMP48:%.*]] = ptrtoint ptr addrspace(1) [[TMP14]] to i64
; CHECK-NEXT:    [[TMP16:%.*]] = lshr i64 [[TMP48]], 3
; CHECK-NEXT:    [[TMP17:%.*]] = add i64 [[TMP16]], 2147450880
; CHECK-NEXT:    [[TMP18:%.*]] = inttoptr i64 [[TMP17]] to ptr
; CHECK-NEXT:    [[TMP19:%.*]] = load i8, ptr [[TMP18]], align 1
; CHECK-NEXT:    [[TMP20:%.*]] = icmp ne i8 [[TMP19]], 0
; CHECK-NEXT:    [[TMP21:%.*]] = and i64 [[TMP48]], 7
; CHECK-NEXT:    [[TMP22:%.*]] = trunc i64 [[TMP21]] to i8
; CHECK-NEXT:    [[TMP23:%.*]] = icmp sge i8 [[TMP22]], [[TMP19]]
; CHECK-NEXT:    [[TMP24:%.*]] = and i1 [[TMP20]], [[TMP23]]
; CHECK-NEXT:    [[TMP25:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP24]])
; CHECK-NEXT:    [[TMP26:%.*]] = icmp ne i64 [[TMP25]], 0
; CHECK-NEXT:    br i1 [[TMP26]], label [[ASAN_REPORT:%.*]], label [[TMP29:%.*]], !prof [[PROF3]]
; CHECK:       asan.report:
; CHECK-NEXT:    br i1 [[TMP24]], label [[TMP27:%.*]], label [[TMP28:%.*]]
; CHECK:       27:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP48]]) #[[ATTR7]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[TMP28]]
; CHECK:       28:
; CHECK-NEXT:    br label [[TMP29]]
; CHECK:       29:
; CHECK-NEXT:    store i8 7, ptr addrspace(1) [[TMP14]], align 1
; CHECK-NEXT:    [[TMP30:%.*]] = ptrtoint ptr addrspace(3) [[TMP15]] to i32
; CHECK-NEXT:    [[TMP31:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP7]], i32 [[TMP30]]
; CHECK-NEXT:    [[TMP32:%.*]] = ptrtoint ptr addrspace(1) [[TMP31]] to i64
; CHECK-NEXT:    [[TMP38:%.*]] = add i64 [[TMP32]], 3
; CHECK-NEXT:    [[TMP49:%.*]] = inttoptr i64 [[TMP38]] to ptr addrspace(1)
; CHECK-NEXT:    [[TMP65:%.*]] = ptrtoint ptr addrspace(1) [[TMP31]] to i64
; CHECK-NEXT:    [[TMP33:%.*]] = lshr i64 [[TMP65]], 3
; CHECK-NEXT:    [[TMP34:%.*]] = add i64 [[TMP33]], 2147450880
; CHECK-NEXT:    [[TMP35:%.*]] = inttoptr i64 [[TMP34]] to ptr
; CHECK-NEXT:    [[TMP36:%.*]] = load i8, ptr [[TMP35]], align 1
; CHECK-NEXT:    [[TMP37:%.*]] = icmp ne i8 [[TMP36]], 0
; CHECK-NEXT:    [[TMP39:%.*]] = and i64 [[TMP65]], 7
; CHECK-NEXT:    [[TMP40:%.*]] = trunc i64 [[TMP39]] to i8
; CHECK-NEXT:    [[TMP41:%.*]] = icmp sge i8 [[TMP40]], [[TMP36]]
; CHECK-NEXT:    [[TMP42:%.*]] = and i1 [[TMP37]], [[TMP41]]
; CHECK-NEXT:    [[TMP43:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP42]])
; CHECK-NEXT:    [[TMP44:%.*]] = icmp ne i64 [[TMP43]], 0
; CHECK-NEXT:    br i1 [[TMP44]], label [[ASAN_REPORT1:%.*]], label [[TMP47:%.*]], !prof [[PROF3]]
; CHECK:       asan.report1:
; CHECK-NEXT:    br i1 [[TMP42]], label [[TMP45:%.*]], label [[TMP46:%.*]]
; CHECK:       47:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP65]]) #[[ATTR7]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[TMP46]]
; CHECK:       48:
; CHECK-NEXT:    br label [[TMP47]]
; CHECK:       49:
; CHECK-NEXT:    [[TMP50:%.*]] = ptrtoint ptr addrspace(1) [[TMP49]] to i64
; CHECK-NEXT:    [[TMP51:%.*]] = lshr i64 [[TMP50]], 3
; CHECK-NEXT:    [[TMP52:%.*]] = add i64 [[TMP51]], 2147450880
; CHECK-NEXT:    [[TMP53:%.*]] = inttoptr i64 [[TMP52]] to ptr
; CHECK-NEXT:    [[TMP54:%.*]] = load i8, ptr [[TMP53]], align 1
; CHECK-NEXT:    [[TMP55:%.*]] = icmp ne i8 [[TMP54]], 0
; CHECK-NEXT:    [[TMP56:%.*]] = and i64 [[TMP50]], 7
; CHECK-NEXT:    [[TMP57:%.*]] = trunc i64 [[TMP56]] to i8
; CHECK-NEXT:    [[TMP58:%.*]] = icmp sge i8 [[TMP57]], [[TMP54]]
; CHECK-NEXT:    [[TMP59:%.*]] = and i1 [[TMP55]], [[TMP58]]
; CHECK-NEXT:    [[TMP60:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP59]])
; CHECK-NEXT:    [[TMP61:%.*]] = icmp ne i64 [[TMP60]], 0
; CHECK-NEXT:    br i1 [[TMP61]], label [[ASAN_REPORT2:%.*]], label [[TMP64:%.*]], !prof [[PROF3]]
; CHECK:       asan.report2:
; CHECK-NEXT:    br i1 [[TMP59]], label [[TMP62:%.*]], label [[TMP63:%.*]]
; CHECK:       62:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP50]]) #[[ATTR7]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[TMP63]]
; CHECK:       63:
; CHECK-NEXT:    br label [[TMP64]]
; CHECK:       64:
; CHECK-NEXT:    store i32 8, ptr addrspace(1) [[TMP31]], align 2
; CHECK-NEXT:    ret void
;
  store i8 7, ptr addrspace(3) @lds_1, align 1
  store i32 8, ptr addrspace(3) @lds_2, align 2
  ret void
}

define amdgpu_kernel void @k0() sanitize_address {
; CHECK-LABEL: define amdgpu_kernel void @k0(
; CHECK-SAME: ) #[[ATTR1:[0-9]+]] !llvm.amdgcn.lds.kernel.id [[META4:![0-9]+]] {
; CHECK-NEXT:  WId:
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.amdgcn.workitem.id.x()
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.amdgcn.workitem.id.y()
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.amdgcn.workitem.id.z()
; CHECK-NEXT:    [[TMP3:%.*]] = or i32 [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = or i32 [[TMP3]], [[TMP2]]
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[TMP4]], 0
; CHECK-NEXT:    br i1 [[TMP5]], label [[MALLOC:%.*]], label [[TMP21:%.*]]
; CHECK:       Malloc:
; CHECK-NEXT:    [[TMP9:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE:%.*]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 1, i32 0), align 4
; CHECK-NEXT:    [[TMP7:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 1, i32 2), align 4
; CHECK-NEXT:    [[TMP8:%.*]] = add i32 [[TMP9]], [[TMP7]]
; CHECK-NEXT:    [[TMP6:%.*]] = call ptr addrspace(4) @llvm.amdgcn.implicitarg.ptr()
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds ptr addrspace(4), ptr addrspace(4) [[TMP6]], i64 15
; CHECK-NEXT:    store i32 [[TMP8]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 2, i32 0), align 4
; CHECK-NEXT:    [[TMP11:%.*]] = load i32, ptr addrspace(4) [[TMP10]], align 4
; CHECK-NEXT:    store i32 [[TMP11]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 2, i32 1), align 4
; CHECK-NEXT:    [[TMP12:%.*]] = add i32 [[TMP11]], 7
; CHECK-NEXT:    [[TMP13:%.*]] = udiv i32 [[TMP12]], 8
; CHECK-NEXT:    [[TMP14:%.*]] = mul i32 [[TMP13]], 8
; CHECK-NEXT:    store i32 [[TMP14]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 2, i32 2), align 4
; CHECK-NEXT:    [[TMP15:%.*]] = add i32 [[TMP8]], [[TMP14]]
; CHECK-NEXT:    store i32 [[TMP15]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 3, i32 0), align 4
; CHECK-NEXT:    [[TMP25:%.*]] = load i32, ptr addrspace(4) [[TMP10]], align 4
; CHECK-NEXT:    store i32 [[TMP25]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 3, i32 1), align 4
; CHECK-NEXT:    [[TMP17:%.*]] = add i32 [[TMP25]], 7
; CHECK-NEXT:    [[TMP18:%.*]] = udiv i32 [[TMP17]], 8
; CHECK-NEXT:    [[TMP19:%.*]] = mul i32 [[TMP18]], 8
; CHECK-NEXT:    store i32 [[TMP19]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 3, i32 2), align 4
; CHECK-NEXT:    [[TMP26:%.*]] = add i32 [[TMP15]], [[TMP19]]
; CHECK-NEXT:    [[TMP27:%.*]] = zext i32 [[TMP26]] to i64
; CHECK-NEXT:    [[TMP28:%.*]] = call ptr @llvm.returnaddress(i32 0)
; CHECK-NEXT:    [[TMP33:%.*]] = ptrtoint ptr [[TMP28]] to i64
; CHECK-NEXT:    [[TMP24:%.*]] = call i64 @__asan_malloc_impl(i64 [[TMP27]], i64 [[TMP33]])
; CHECK-NEXT:    [[TMP20:%.*]] = inttoptr i64 [[TMP24]] to ptr addrspace(1)
; CHECK-NEXT:    store ptr addrspace(1) [[TMP20]], ptr addrspace(3) @llvm.amdgcn.sw.lds.k0, align 8
; CHECK-NEXT:    [[TMP49:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP20]], i64 8
; CHECK-NEXT:    [[TMP51:%.*]] = ptrtoint ptr addrspace(1) [[TMP49]] to i64
; CHECK-NEXT:    call void @__asan_poison_region(i64 [[TMP51]], i64 24)
; CHECK-NEXT:    [[TMP52:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP20]], i64 33
; CHECK-NEXT:    [[TMP53:%.*]] = ptrtoint ptr addrspace(1) [[TMP52]] to i64
; CHECK-NEXT:    call void @__asan_poison_region(i64 [[TMP53]], i64 31)
; CHECK-NEXT:    br label [[TMP21]]
; CHECK:       30:
; CHECK-NEXT:    [[XYZCOND:%.*]] = phi i1 [ false, [[WID:%.*]] ], [ true, [[MALLOC]] ]
; CHECK-NEXT:    call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    [[TMP29:%.*]] = load ptr addrspace(1), ptr addrspace(3) @llvm.amdgcn.sw.lds.k0, align 8
; CHECK-NEXT:    [[TMP22:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 1, i32 0), align 4
; CHECK-NEXT:    [[TMP23:%.*]] = getelementptr inbounds i8, ptr addrspace(3) @llvm.amdgcn.sw.lds.k0, i32 [[TMP22]]
; CHECK-NEXT:    call void @llvm.donothing() [ "ExplicitUse"(ptr addrspace(3) @llvm.amdgcn.k0.dynlds) ]
; CHECK-NEXT:    call void @use_variables_1()
; CHECK-NEXT:    [[TMP34:%.*]] = ptrtoint ptr addrspace(3) [[TMP23]] to i32
; CHECK-NEXT:    [[TMP35:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP29]], i32 [[TMP34]]
; CHECK-NEXT:    [[TMP36:%.*]] = ptrtoint ptr addrspace(1) [[TMP35]] to i64
; CHECK-NEXT:    [[TMP37:%.*]] = lshr i64 [[TMP36]], 3
; CHECK-NEXT:    [[TMP38:%.*]] = add i64 [[TMP37]], 2147450880
; CHECK-NEXT:    [[TMP39:%.*]] = inttoptr i64 [[TMP38]] to ptr
; CHECK-NEXT:    [[TMP40:%.*]] = load i8, ptr [[TMP39]], align 1
; CHECK-NEXT:    [[TMP41:%.*]] = icmp ne i8 [[TMP40]], 0
; CHECK-NEXT:    [[TMP42:%.*]] = and i64 [[TMP36]], 7
; CHECK-NEXT:    [[TMP43:%.*]] = trunc i64 [[TMP42]] to i8
; CHECK-NEXT:    [[TMP44:%.*]] = icmp sge i8 [[TMP43]], [[TMP40]]
; CHECK-NEXT:    [[TMP45:%.*]] = and i1 [[TMP41]], [[TMP44]]
; CHECK-NEXT:    [[TMP46:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP45]])
; CHECK-NEXT:    [[TMP47:%.*]] = icmp ne i64 [[TMP46]], 0
; CHECK-NEXT:    br i1 [[TMP47]], label [[ASAN_REPORT:%.*]], label [[TMP50:%.*]], !prof [[PROF3]]
; CHECK:       asan.report:
; CHECK-NEXT:    br i1 [[TMP45]], label [[TMP48:%.*]], label [[CONDFREE:%.*]]
; CHECK:       48:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP36]]) #[[ATTR7]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[CONDFREE]]
; CHECK:       49:
; CHECK-NEXT:    br label [[TMP50]]
; CHECK:       50:
; CHECK-NEXT:    store i8 7, ptr addrspace(1) [[TMP35]], align 1
; CHECK-NEXT:    br label [[CONDFREE1:%.*]]
; CHECK:       CondFree:
; CHECK-NEXT:    call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    br i1 [[XYZCOND]], label [[FREE:%.*]], label [[END:%.*]]
; CHECK:       Free:
; CHECK-NEXT:    [[TMP30:%.*]] = call ptr @llvm.returnaddress(i32 0)
; CHECK-NEXT:    [[TMP31:%.*]] = ptrtoint ptr [[TMP30]] to i64
; CHECK-NEXT:    [[TMP32:%.*]] = ptrtoint ptr addrspace(1) [[TMP29]] to i64
; CHECK-NEXT:    call void @__asan_free_impl(i64 [[TMP32]], i64 [[TMP31]])
; CHECK-NEXT:    br label [[END]]
; CHECK:       End:
; CHECK-NEXT:    ret void
;
  call void @use_variables_1()
  store i8 7, ptr addrspace(3) @lds_1, align 1
  ret void
}

define amdgpu_kernel void @k1() sanitize_address {
; CHECK-LABEL: define amdgpu_kernel void @k1(
; CHECK-SAME: ) #[[ATTR1]] !llvm.amdgcn.lds.kernel.id [[META5:![0-9]+]] {
; CHECK-NEXT:  WId:
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.amdgcn.workitem.id.x()
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.amdgcn.workitem.id.y()
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.amdgcn.workitem.id.z()
; CHECK-NEXT:    [[TMP3:%.*]] = or i32 [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = or i32 [[TMP3]], [[TMP2]]
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[TMP4]], 0
; CHECK-NEXT:    br i1 [[TMP5]], label [[MALLOC:%.*]], label [[TMP14:%.*]]
; CHECK:       Malloc:
; CHECK-NEXT:    [[TMP9:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K1_MD_TYPE:%.*]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k1.md, i32 0, i32 2, i32 0), align 4
; CHECK-NEXT:    [[TMP7:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K1_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k1.md, i32 0, i32 2, i32 2), align 4
; CHECK-NEXT:    [[TMP8:%.*]] = add i32 [[TMP9]], [[TMP7]]
; CHECK-NEXT:    [[TMP6:%.*]] = call ptr addrspace(4) @llvm.amdgcn.implicitarg.ptr()
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds ptr addrspace(4), ptr addrspace(4) [[TMP6]], i64 15
; CHECK-NEXT:    store i32 [[TMP8]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K1_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k1.md, i32 0, i32 3, i32 0), align 4
; CHECK-NEXT:    [[TMP30:%.*]] = load i32, ptr addrspace(4) [[TMP10]], align 4
; CHECK-NEXT:    store i32 [[TMP30]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K1_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k1.md, i32 0, i32 3, i32 1), align 4
; CHECK-NEXT:    [[TMP33:%.*]] = add i32 [[TMP30]], 7
; CHECK-NEXT:    [[TMP18:%.*]] = udiv i32 [[TMP33]], 8
; CHECK-NEXT:    [[TMP19:%.*]] = mul i32 [[TMP18]], 8
; CHECK-NEXT:    store i32 [[TMP19]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K1_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k1.md, i32 0, i32 3, i32 2), align 4
; CHECK-NEXT:    [[TMP20:%.*]] = add i32 [[TMP8]], [[TMP19]]
; CHECK-NEXT:    store i32 [[TMP20]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K1_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k1.md, i32 0, i32 4, i32 0), align 4
; CHECK-NEXT:    [[TMP21:%.*]] = load i32, ptr addrspace(4) [[TMP10]], align 4
; CHECK-NEXT:    store i32 [[TMP21]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K1_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k1.md, i32 0, i32 4, i32 1), align 4
; CHECK-NEXT:    [[TMP22:%.*]] = add i32 [[TMP21]], 7
; CHECK-NEXT:    [[TMP23:%.*]] = udiv i32 [[TMP22]], 8
; CHECK-NEXT:    [[TMP24:%.*]] = mul i32 [[TMP23]], 8
; CHECK-NEXT:    store i32 [[TMP24]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K1_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k1.md, i32 0, i32 4, i32 2), align 4
; CHECK-NEXT:    [[TMP25:%.*]] = add i32 [[TMP20]], [[TMP24]]
; CHECK-NEXT:    [[TMP26:%.*]] = zext i32 [[TMP25]] to i64
; CHECK-NEXT:    [[TMP27:%.*]] = call ptr @llvm.returnaddress(i32 0)
; CHECK-NEXT:    [[TMP28:%.*]] = ptrtoint ptr [[TMP27]] to i64
; CHECK-NEXT:    [[TMP34:%.*]] = call i64 @__asan_malloc_impl(i64 [[TMP26]], i64 [[TMP28]])
; CHECK-NEXT:    [[TMP13:%.*]] = inttoptr i64 [[TMP34]] to ptr addrspace(1)
; CHECK-NEXT:    store ptr addrspace(1) [[TMP13]], ptr addrspace(3) @llvm.amdgcn.sw.lds.k1, align 8
; CHECK-NEXT:    [[TMP51:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP13]], i64 8
; CHECK-NEXT:    [[TMP53:%.*]] = ptrtoint ptr addrspace(1) [[TMP51]] to i64
; CHECK-NEXT:    call void @__asan_poison_region(i64 [[TMP53]], i64 24)
; CHECK-NEXT:    [[TMP54:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP13]], i64 33
; CHECK-NEXT:    [[TMP55:%.*]] = ptrtoint ptr addrspace(1) [[TMP54]] to i64
; CHECK-NEXT:    call void @__asan_poison_region(i64 [[TMP55]], i64 31)
; CHECK-NEXT:    [[TMP56:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP13]], i64 68
; CHECK-NEXT:    [[TMP57:%.*]] = ptrtoint ptr addrspace(1) [[TMP56]] to i64
; CHECK-NEXT:    call void @__asan_poison_region(i64 [[TMP57]], i64 28)
; CHECK-NEXT:    br label [[TMP14]]
; CHECK:       32:
; CHECK-NEXT:    [[XYZCOND:%.*]] = phi i1 [ false, [[WID:%.*]] ], [ true, [[MALLOC]] ]
; CHECK-NEXT:    call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    [[TMP29:%.*]] = load ptr addrspace(1), ptr addrspace(3) @llvm.amdgcn.sw.lds.k1, align 8
; CHECK-NEXT:    [[TMP31:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K1_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k1.md, i32 0, i32 3, i32 0), align 4
; CHECK-NEXT:    [[TMP32:%.*]] = getelementptr inbounds i8, ptr addrspace(3) @llvm.amdgcn.sw.lds.k1, i32 [[TMP31]]
; CHECK-NEXT:    call void @llvm.donothing() [ "ExplicitUse"(ptr addrspace(3) @llvm.amdgcn.k1.dynlds) ]
; CHECK-NEXT:    call void @use_variables_1()
; CHECK-NEXT:    call void @use_variables_2()
; CHECK-NEXT:    [[TMP58:%.*]] = ptrtoint ptr addrspace(3) [[TMP32]] to i32
; CHECK-NEXT:    [[TMP59:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP29]], i32 [[TMP58]]
; CHECK-NEXT:    [[TMP38:%.*]] = ptrtoint ptr addrspace(1) [[TMP59]] to i64
; CHECK-NEXT:    [[TMP39:%.*]] = lshr i64 [[TMP38]], 3
; CHECK-NEXT:    [[TMP40:%.*]] = add i64 [[TMP39]], 2147450880
; CHECK-NEXT:    [[TMP41:%.*]] = inttoptr i64 [[TMP40]] to ptr
; CHECK-NEXT:    [[TMP42:%.*]] = load i8, ptr [[TMP41]], align 1
; CHECK-NEXT:    [[TMP43:%.*]] = icmp ne i8 [[TMP42]], 0
; CHECK-NEXT:    [[TMP44:%.*]] = and i64 [[TMP38]], 7
; CHECK-NEXT:    [[TMP45:%.*]] = trunc i64 [[TMP44]] to i8
; CHECK-NEXT:    [[TMP46:%.*]] = icmp sge i8 [[TMP45]], [[TMP42]]
; CHECK-NEXT:    [[TMP47:%.*]] = and i1 [[TMP43]], [[TMP46]]
; CHECK-NEXT:    [[TMP48:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP47]])
; CHECK-NEXT:    [[TMP49:%.*]] = icmp ne i64 [[TMP48]], 0
; CHECK-NEXT:    br i1 [[TMP49]], label [[ASAN_REPORT:%.*]], label [[TMP52:%.*]], !prof [[PROF3]]
; CHECK:       asan.report:
; CHECK-NEXT:    br i1 [[TMP47]], label [[TMP50:%.*]], label [[CONDFREE:%.*]]
; CHECK:       50:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP38]]) #[[ATTR7]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[CONDFREE]]
; CHECK:       51:
; CHECK-NEXT:    br label [[TMP52]]
; CHECK:       52:
; CHECK-NEXT:    store i8 3, ptr addrspace(1) [[TMP59]], align 4
; CHECK-NEXT:    br label [[CONDFREE1:%.*]]
; CHECK:       CondFree:
; CHECK-NEXT:    call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    br i1 [[XYZCOND]], label [[FREE:%.*]], label [[END:%.*]]
; CHECK:       Free:
; CHECK-NEXT:    [[TMP35:%.*]] = call ptr @llvm.returnaddress(i32 0)
; CHECK-NEXT:    [[TMP36:%.*]] = ptrtoint ptr [[TMP35]] to i64
; CHECK-NEXT:    [[TMP37:%.*]] = ptrtoint ptr addrspace(1) [[TMP29]] to i64
; CHECK-NEXT:    call void @__asan_free_impl(i64 [[TMP37]], i64 [[TMP36]])
; CHECK-NEXT:    br label [[END]]
; CHECK:       End:
; CHECK-NEXT:    ret void
;
  call void @use_variables_1()
  call void @use_variables_2()
  store i8 3, ptr addrspace(3) @lds_3, align 4
  ret void
}

!llvm.module.flags = !{!0}
!0 = !{i32 4, !"nosanitize_address", i32 1}

;.
; CHECK: [[PROF3]] = !{!"branch_weights", i32 1, i32 1048575}
; CHECK: [[META4]] = !{i32 0}
; CHECK: [[META5]] = !{i32 1}
;.