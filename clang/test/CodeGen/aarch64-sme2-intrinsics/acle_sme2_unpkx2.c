// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py

// REQUIRES: aarch64-registered-target

// RUN: %clang_cc1 -triple aarch64 -target-feature +bf16 -target-feature +sme -target-feature +sme2 -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -triple aarch64 -target-feature +bf16 -target-feature +sme -target-feature +sme2 -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64 -target-feature +bf16 -target-feature +sme -target-feature +sme2 -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64 -target-feature +bf16 -target-feature +sme -target-feature +sme2 -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64 -target-feature +bf16 -target-feature +sme -target-feature +sme2 -target-feature -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
// RUN: %clang_cc1 -triple aarch64 -target-feature +bf16 -target-feature +sme -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
#include <arm_sme.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED) A1
#else
#define SVE_ACLE_FUNC(A1,A2) A1##A2
#endif

// CHECK-LABEL: @test_svunpk_s16_x2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.sunpk.x2.nxv8i16(<vscale x 16 x i8> [[ZN:%.*]])
// CHECK-NEXT:    ret { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z18test_svunpk_s16_x2u10__SVInt8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.sunpk.x2.nxv8i16(<vscale x 16 x i8> [[ZN:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]]
//
svint16x2_t test_svunpk_s16_x2(svint8_t zn) __arm_streaming {
  return SVE_ACLE_FUNC(svunpk_s16,_s8_x2)(zn);
}

// CHECK-LABEL: @test_svunpk_u16_x2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.uunpk.x2.nxv8i16(<vscale x 16 x i8> [[ZN:%.*]])
// CHECK-NEXT:    ret { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z18test_svunpk_u16_x2u11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.uunpk.x2.nxv8i16(<vscale x 16 x i8> [[ZN:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]]
//
svuint16x2_t test_svunpk_u16_x2(svuint8_t zn) __arm_streaming {
  return SVE_ACLE_FUNC(svunpk_u16,_u8_x2)(zn);
}

// CHECK-LABEL: @test_svunpk_s32_x2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.sunpk.x2.nxv4i32(<vscale x 8 x i16> [[ZN:%.*]])
// CHECK-NEXT:    ret { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z18test_svunpk_s32_x2u11__SVInt16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.sunpk.x2.nxv4i32(<vscale x 8 x i16> [[ZN:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]]
//
svint32x2_t test_svunpk_s32_x2(svint16_t zn) __arm_streaming {
  return SVE_ACLE_FUNC(svunpk_s32,_s16_x2)(zn);
}

// CHECK-LABEL: @test_svunpk_u32_x2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.uunpk.x2.nxv4i32(<vscale x 8 x i16> [[ZN:%.*]])
// CHECK-NEXT:    ret { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z18test_svunpk_u32_x2u12__SVUint16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.uunpk.x2.nxv4i32(<vscale x 8 x i16> [[ZN:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]]
//
svuint32x2_t test_svunpk_u32_x2(svuint16_t zn) __arm_streaming {
  return SVE_ACLE_FUNC(svunpk_u32,_u16_x2)(zn);
}

// CHECK-LABEL: @test_svunpk_s64_x2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.sunpk.x2.nxv2i64(<vscale x 4 x i32> [[ZN:%.*]])
// CHECK-NEXT:    ret { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z18test_svunpk_s64_x2u11__SVInt32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.sunpk.x2.nxv2i64(<vscale x 4 x i32> [[ZN:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]]
//
svint64x2_t test_svunpk_s64_x2(svint32_t zn) __arm_streaming {
  return SVE_ACLE_FUNC(svunpk_s64,_s32_x2)(zn);
}

// CHECK-LABEL: @test_svunpk_u64_x2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.uunpk.x2.nxv2i64(<vscale x 4 x i32> [[ZN:%.*]])
// CHECK-NEXT:    ret { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z18test_svunpk_u64_x2u12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.uunpk.x2.nxv2i64(<vscale x 4 x i32> [[ZN:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]]
//
svuint64x2_t test_svunpk_u64_x2(svuint32_t zn) __arm_streaming {
  return SVE_ACLE_FUNC(svunpk_u64,_u32_x2)(zn);
}