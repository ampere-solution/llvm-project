// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -disable-O0-optnone \
// RUN:   -emit-llvm %s -o - | opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local target("riscv.vector.tuple", <vscale x 1 x i8>, 5) @test_vlseg5e8_v_i8mf8x5_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call target("riscv.vector.tuple", <vscale x 1 x i8>, 5) @llvm.riscv.vlseg5.mask.triscv.vector.tuple_nxv1i8_5t.nxv1i1.i64(target("riscv.vector.tuple", <vscale x 1 x i8>, 5) poison, ptr [[BASE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]], i64 3, i64 3)
// CHECK-RV64-NEXT:    ret target("riscv.vector.tuple", <vscale x 1 x i8>, 5) [[TMP0]]
//
vint8mf8x5_t test_vlseg5e8_v_i8mf8x5_m(vbool64_t mask, const int8_t *base, size_t vl) {
  return __riscv_vlseg5e8(mask, base, vl);
}

// CHECK-RV64-LABEL: define dso_local target("riscv.vector.tuple", <vscale x 2 x i8>, 5) @test_vlseg5e8_v_i8mf4x5_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call target("riscv.vector.tuple", <vscale x 2 x i8>, 5) @llvm.riscv.vlseg5.mask.triscv.vector.tuple_nxv2i8_5t.nxv2i1.i64(target("riscv.vector.tuple", <vscale x 2 x i8>, 5) poison, ptr [[BASE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]], i64 3, i64 3)
// CHECK-RV64-NEXT:    ret target("riscv.vector.tuple", <vscale x 2 x i8>, 5) [[TMP0]]
//
vint8mf4x5_t test_vlseg5e8_v_i8mf4x5_m(vbool32_t mask, const int8_t *base, size_t vl) {
  return __riscv_vlseg5e8(mask, base, vl);
}

// CHECK-RV64-LABEL: define dso_local target("riscv.vector.tuple", <vscale x 4 x i8>, 5) @test_vlseg5e8_v_i8mf2x5_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call target("riscv.vector.tuple", <vscale x 4 x i8>, 5) @llvm.riscv.vlseg5.mask.triscv.vector.tuple_nxv4i8_5t.nxv4i1.i64(target("riscv.vector.tuple", <vscale x 4 x i8>, 5) poison, ptr [[BASE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]], i64 3, i64 3)
// CHECK-RV64-NEXT:    ret target("riscv.vector.tuple", <vscale x 4 x i8>, 5) [[TMP0]]
//
vint8mf2x5_t test_vlseg5e8_v_i8mf2x5_m(vbool16_t mask, const int8_t *base, size_t vl) {
  return __riscv_vlseg5e8(mask, base, vl);
}

// CHECK-RV64-LABEL: define dso_local target("riscv.vector.tuple", <vscale x 8 x i8>, 5) @test_vlseg5e8_v_i8m1x5_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call target("riscv.vector.tuple", <vscale x 8 x i8>, 5) @llvm.riscv.vlseg5.mask.triscv.vector.tuple_nxv8i8_5t.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) poison, ptr [[BASE]], <vscale x 8 x i1> [[MASK]], i64 [[VL]], i64 3, i64 3)
// CHECK-RV64-NEXT:    ret target("riscv.vector.tuple", <vscale x 8 x i8>, 5) [[TMP0]]
//
vint8m1x5_t test_vlseg5e8_v_i8m1x5_m(vbool8_t mask, const int8_t *base, size_t vl) {
  return __riscv_vlseg5e8(mask, base, vl);
}

// CHECK-RV64-LABEL: define dso_local target("riscv.vector.tuple", <vscale x 1 x i8>, 5) @test_vlseg5e8_v_u8mf8x5_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call target("riscv.vector.tuple", <vscale x 1 x i8>, 5) @llvm.riscv.vlseg5.mask.triscv.vector.tuple_nxv1i8_5t.nxv1i1.i64(target("riscv.vector.tuple", <vscale x 1 x i8>, 5) poison, ptr [[BASE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]], i64 3, i64 3)
// CHECK-RV64-NEXT:    ret target("riscv.vector.tuple", <vscale x 1 x i8>, 5) [[TMP0]]
//
vuint8mf8x5_t test_vlseg5e8_v_u8mf8x5_m(vbool64_t mask, const uint8_t *base, size_t vl) {
  return __riscv_vlseg5e8(mask, base, vl);
}

// CHECK-RV64-LABEL: define dso_local target("riscv.vector.tuple", <vscale x 2 x i8>, 5) @test_vlseg5e8_v_u8mf4x5_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call target("riscv.vector.tuple", <vscale x 2 x i8>, 5) @llvm.riscv.vlseg5.mask.triscv.vector.tuple_nxv2i8_5t.nxv2i1.i64(target("riscv.vector.tuple", <vscale x 2 x i8>, 5) poison, ptr [[BASE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]], i64 3, i64 3)
// CHECK-RV64-NEXT:    ret target("riscv.vector.tuple", <vscale x 2 x i8>, 5) [[TMP0]]
//
vuint8mf4x5_t test_vlseg5e8_v_u8mf4x5_m(vbool32_t mask, const uint8_t *base, size_t vl) {
  return __riscv_vlseg5e8(mask, base, vl);
}

// CHECK-RV64-LABEL: define dso_local target("riscv.vector.tuple", <vscale x 4 x i8>, 5) @test_vlseg5e8_v_u8mf2x5_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call target("riscv.vector.tuple", <vscale x 4 x i8>, 5) @llvm.riscv.vlseg5.mask.triscv.vector.tuple_nxv4i8_5t.nxv4i1.i64(target("riscv.vector.tuple", <vscale x 4 x i8>, 5) poison, ptr [[BASE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]], i64 3, i64 3)
// CHECK-RV64-NEXT:    ret target("riscv.vector.tuple", <vscale x 4 x i8>, 5) [[TMP0]]
//
vuint8mf2x5_t test_vlseg5e8_v_u8mf2x5_m(vbool16_t mask, const uint8_t *base, size_t vl) {
  return __riscv_vlseg5e8(mask, base, vl);
}

// CHECK-RV64-LABEL: define dso_local target("riscv.vector.tuple", <vscale x 8 x i8>, 5) @test_vlseg5e8_v_u8m1x5_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call target("riscv.vector.tuple", <vscale x 8 x i8>, 5) @llvm.riscv.vlseg5.mask.triscv.vector.tuple_nxv8i8_5t.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) poison, ptr [[BASE]], <vscale x 8 x i1> [[MASK]], i64 [[VL]], i64 3, i64 3)
// CHECK-RV64-NEXT:    ret target("riscv.vector.tuple", <vscale x 8 x i8>, 5) [[TMP0]]
//
vuint8m1x5_t test_vlseg5e8_v_u8m1x5_m(vbool8_t mask, const uint8_t *base, size_t vl) {
  return __riscv_vlseg5e8(mask, base, vl);
}
