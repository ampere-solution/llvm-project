// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 4
// RUN: %clang_cc1                               -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +bf16 -target-feature +sme -target-feature +sme-b16b16 -target-feature +sme2p1 -target-feature +sme-f16f16 -O2 -Werror -emit-llvm -o - %s | FileCheck %s -check-prefixes=CHECK
// RUN: %clang_cc1                        -x c++ -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +bf16 -target-feature +sme -target-feature +sme-b16b16 -target-feature +sme2p1 -target-feature +sme-f16f16 -O2 -Werror -emit-llvm -o - %s | FileCheck %s -check-prefixes=CHECK-CXX
// RUN: %clang_cc1 -DSME_OVERLOADED_FORMS        -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +bf16 -target-feature +sme -target-feature +sme-b16b16 -target-feature +sme2p1 -target-feature +sme-f16f16 -O2 -Werror -emit-llvm -o - %s | FileCheck %s -check-prefixes=CHECK
// RUN: %clang_cc1 -DSME_OVERLOADED_FORMS -x c++ -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +bf16 -target-feature +sme -target-feature +sme-b16b16 -target-feature +sme2p1 -target-feature +sme-f16f16 -O2 -Werror -emit-llvm -o - %s | FileCheck %s -check-prefixes=CHECK-CXX

// RUN: %clang_cc1 -DSME_OVERLOADED_FORMS -x c++ -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +bf16 -target-feature +sme -target-feature +sme-b16b16 -target-feature +sme2p1 -target-feature +sme-f16f16 -S -O2 -Werror -o /dev/null %s

// REQUIRES: aarch64-registered-target

#include <arm_sme.h>

#ifdef SME_OVERLOADED_FORMS
#define SME_ACLE_FUNC(A1,A2_UNUSED,A3) A1##A3
#else
#define SME_ACLE_FUNC(A1,A2,A3) A1##A2##A3
#endif

// CHECK-LABEL: define dso_local void @test_svmopa_za16_bf16(
// CHECK-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x bfloat> [[ZN:%.*]], <vscale x 8 x bfloat> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.mopa.nxv8bf16(i32 0, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x bfloat> [[ZN]], <vscale x 8 x bfloat> [[ZM]])
// CHECK-NEXT:    ret void
//
// CHECK-CXX-LABEL: define dso_local void @_Z21test_svmopa_za16_bf16u10__SVBool_tS_u14__SVBfloat16_tS0_(
// CHECK-CXX-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x bfloat> [[ZN:%.*]], <vscale x 8 x bfloat> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-CXX-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-CXX-NEXT:    tail call void @llvm.aarch64.sme.mopa.nxv8bf16(i32 0, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x bfloat> [[ZN]], <vscale x 8 x bfloat> [[ZM]])
// CHECK-CXX-NEXT:    ret void
//
void test_svmopa_za16_bf16(svbool_t pn, svbool_t pm, svbfloat16_t zn, svbfloat16_t zm) __arm_streaming __arm_inout("za") {
  SME_ACLE_FUNC(svmopa_za16, _bf16, _m)(0, pn, pm, zn, zm);
}

// CHECK-LABEL: define dso_local void @test_svmops_za16_bf16(
// CHECK-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x bfloat> [[ZN:%.*]], <vscale x 8 x bfloat> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.mops.nxv8bf16(i32 0, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x bfloat> [[ZN]], <vscale x 8 x bfloat> [[ZM]])
// CHECK-NEXT:    ret void
//
// CHECK-CXX-LABEL: define dso_local void @_Z21test_svmops_za16_bf16u10__SVBool_tS_u14__SVBfloat16_tS0_(
// CHECK-CXX-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x bfloat> [[ZN:%.*]], <vscale x 8 x bfloat> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-CXX-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-CXX-NEXT:    tail call void @llvm.aarch64.sme.mops.nxv8bf16(i32 0, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x bfloat> [[ZN]], <vscale x 8 x bfloat> [[ZM]])
// CHECK-CXX-NEXT:    ret void
//
void test_svmops_za16_bf16(svbool_t pn, svbool_t pm, svbfloat16_t zn, svbfloat16_t zm) __arm_streaming __arm_inout("za") {
  SME_ACLE_FUNC(svmops_za16, _bf16, _m)(0, pn, pm, zn, zm);
}

// CHECK-LABEL: define dso_local void @test_svmopa_za16_f16(
// CHECK-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x half> [[ZN:%.*]], <vscale x 8 x half> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.mopa.nxv8f16(i32 0, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[ZN]], <vscale x 8 x half> [[ZM]])
// CHECK-NEXT:    ret void
//
// CHECK-CXX-LABEL: define dso_local void @_Z20test_svmopa_za16_f16u10__SVBool_tS_u13__SVFloat16_tS0_(
// CHECK-CXX-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x half> [[ZN:%.*]], <vscale x 8 x half> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-CXX-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-CXX-NEXT:    tail call void @llvm.aarch64.sme.mopa.nxv8f16(i32 0, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[ZN]], <vscale x 8 x half> [[ZM]])
// CHECK-CXX-NEXT:    ret void
//
void test_svmopa_za16_f16(svbool_t pn, svbool_t pm, svfloat16_t zn, svfloat16_t zm) __arm_streaming __arm_inout("za") {
  SME_ACLE_FUNC(svmopa_za16, _f16, _m)(0, pn, pm, zn, zm);
}

// CHECK-LABEL: define dso_local void @test_svmops_za16_f16(
// CHECK-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x half> [[ZN:%.*]], <vscale x 8 x half> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.mops.nxv8f16(i32 0, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[ZN]], <vscale x 8 x half> [[ZM]])
// CHECK-NEXT:    ret void
//
// CHECK-CXX-LABEL: define dso_local void @_Z20test_svmops_za16_f16u10__SVBool_tS_u13__SVFloat16_tS0_(
// CHECK-CXX-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x half> [[ZN:%.*]], <vscale x 8 x half> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-CXX-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-CXX-NEXT:    tail call void @llvm.aarch64.sme.mops.nxv8f16(i32 0, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[ZN]], <vscale x 8 x half> [[ZM]])
// CHECK-CXX-NEXT:    ret void
//
void test_svmops_za16_f16(svbool_t pn, svbool_t pm, svfloat16_t zn, svfloat16_t zm) __arm_streaming __arm_inout("za") {
  SME_ACLE_FUNC(svmops_za16, _f16, _m)(0, pn, pm, zn, zm);
}