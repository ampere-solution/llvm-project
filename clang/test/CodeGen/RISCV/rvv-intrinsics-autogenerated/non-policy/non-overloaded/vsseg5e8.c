// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -target-feature +zfh \
// RUN:   -target-feature +zvfh -disable-O0-optnone  \
// RUN:   -emit-llvm %s -o - | opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local void @test_vsseg5e8_v_i8mf8x5
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], target("riscv.vector.tuple", <vscale x 1 x i8>, 5) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg5.triscv.vector.tuple_nxv1i8_5t.i64(target("riscv.vector.tuple", <vscale x 1 x i8>, 5) [[V_TUPLE]], ptr [[BASE]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg5e8_v_i8mf8x5(int8_t *base, vint8mf8x5_t v_tuple, size_t vl) {
  return __riscv_vsseg5e8_v_i8mf8x5(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg5e8_v_i8mf4x5
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], target("riscv.vector.tuple", <vscale x 2 x i8>, 5) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg5.triscv.vector.tuple_nxv2i8_5t.i64(target("riscv.vector.tuple", <vscale x 2 x i8>, 5) [[V_TUPLE]], ptr [[BASE]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg5e8_v_i8mf4x5(int8_t *base, vint8mf4x5_t v_tuple, size_t vl) {
  return __riscv_vsseg5e8_v_i8mf4x5(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg5e8_v_i8mf2x5
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], target("riscv.vector.tuple", <vscale x 4 x i8>, 5) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg5.triscv.vector.tuple_nxv4i8_5t.i64(target("riscv.vector.tuple", <vscale x 4 x i8>, 5) [[V_TUPLE]], ptr [[BASE]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg5e8_v_i8mf2x5(int8_t *base, vint8mf2x5_t v_tuple, size_t vl) {
  return __riscv_vsseg5e8_v_i8mf2x5(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg5e8_v_i8m1x5
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], target("riscv.vector.tuple", <vscale x 8 x i8>, 5) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg5.triscv.vector.tuple_nxv8i8_5t.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) [[V_TUPLE]], ptr [[BASE]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg5e8_v_i8m1x5(int8_t *base, vint8m1x5_t v_tuple, size_t vl) {
  return __riscv_vsseg5e8_v_i8m1x5(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg5e8_v_u8mf8x5
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], target("riscv.vector.tuple", <vscale x 1 x i8>, 5) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg5.triscv.vector.tuple_nxv1i8_5t.i64(target("riscv.vector.tuple", <vscale x 1 x i8>, 5) [[V_TUPLE]], ptr [[BASE]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg5e8_v_u8mf8x5(uint8_t *base, vuint8mf8x5_t v_tuple, size_t vl) {
  return __riscv_vsseg5e8_v_u8mf8x5(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg5e8_v_u8mf4x5
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], target("riscv.vector.tuple", <vscale x 2 x i8>, 5) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg5.triscv.vector.tuple_nxv2i8_5t.i64(target("riscv.vector.tuple", <vscale x 2 x i8>, 5) [[V_TUPLE]], ptr [[BASE]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg5e8_v_u8mf4x5(uint8_t *base, vuint8mf4x5_t v_tuple, size_t vl) {
  return __riscv_vsseg5e8_v_u8mf4x5(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg5e8_v_u8mf2x5
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], target("riscv.vector.tuple", <vscale x 4 x i8>, 5) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg5.triscv.vector.tuple_nxv4i8_5t.i64(target("riscv.vector.tuple", <vscale x 4 x i8>, 5) [[V_TUPLE]], ptr [[BASE]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg5e8_v_u8mf2x5(uint8_t *base, vuint8mf2x5_t v_tuple, size_t vl) {
  return __riscv_vsseg5e8_v_u8mf2x5(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg5e8_v_u8m1x5
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], target("riscv.vector.tuple", <vscale x 8 x i8>, 5) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg5.triscv.vector.tuple_nxv8i8_5t.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) [[V_TUPLE]], ptr [[BASE]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg5e8_v_u8m1x5(uint8_t *base, vuint8m1x5_t v_tuple, size_t vl) {
  return __riscv_vsseg5e8_v_u8m1x5(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg5e8_v_i8mf8x5_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], target("riscv.vector.tuple", <vscale x 1 x i8>, 5) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg5.mask.triscv.vector.tuple_nxv1i8_5t.nxv1i1.i64(target("riscv.vector.tuple", <vscale x 1 x i8>, 5) [[V_TUPLE]], ptr [[BASE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg5e8_v_i8mf8x5_m(vbool64_t mask, int8_t *base, vint8mf8x5_t v_tuple, size_t vl) {
  return __riscv_vsseg5e8_v_i8mf8x5_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg5e8_v_i8mf4x5_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], target("riscv.vector.tuple", <vscale x 2 x i8>, 5) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg5.mask.triscv.vector.tuple_nxv2i8_5t.nxv2i1.i64(target("riscv.vector.tuple", <vscale x 2 x i8>, 5) [[V_TUPLE]], ptr [[BASE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg5e8_v_i8mf4x5_m(vbool32_t mask, int8_t *base, vint8mf4x5_t v_tuple, size_t vl) {
  return __riscv_vsseg5e8_v_i8mf4x5_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg5e8_v_i8mf2x5_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], target("riscv.vector.tuple", <vscale x 4 x i8>, 5) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg5.mask.triscv.vector.tuple_nxv4i8_5t.nxv4i1.i64(target("riscv.vector.tuple", <vscale x 4 x i8>, 5) [[V_TUPLE]], ptr [[BASE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg5e8_v_i8mf2x5_m(vbool16_t mask, int8_t *base, vint8mf2x5_t v_tuple, size_t vl) {
  return __riscv_vsseg5e8_v_i8mf2x5_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg5e8_v_i8m1x5_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], target("riscv.vector.tuple", <vscale x 8 x i8>, 5) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg5.mask.triscv.vector.tuple_nxv8i8_5t.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) [[V_TUPLE]], ptr [[BASE]], <vscale x 8 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg5e8_v_i8m1x5_m(vbool8_t mask, int8_t *base, vint8m1x5_t v_tuple, size_t vl) {
  return __riscv_vsseg5e8_v_i8m1x5_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg5e8_v_u8mf8x5_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], target("riscv.vector.tuple", <vscale x 1 x i8>, 5) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg5.mask.triscv.vector.tuple_nxv1i8_5t.nxv1i1.i64(target("riscv.vector.tuple", <vscale x 1 x i8>, 5) [[V_TUPLE]], ptr [[BASE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg5e8_v_u8mf8x5_m(vbool64_t mask, uint8_t *base, vuint8mf8x5_t v_tuple, size_t vl) {
  return __riscv_vsseg5e8_v_u8mf8x5_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg5e8_v_u8mf4x5_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], target("riscv.vector.tuple", <vscale x 2 x i8>, 5) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg5.mask.triscv.vector.tuple_nxv2i8_5t.nxv2i1.i64(target("riscv.vector.tuple", <vscale x 2 x i8>, 5) [[V_TUPLE]], ptr [[BASE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg5e8_v_u8mf4x5_m(vbool32_t mask, uint8_t *base, vuint8mf4x5_t v_tuple, size_t vl) {
  return __riscv_vsseg5e8_v_u8mf4x5_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg5e8_v_u8mf2x5_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], target("riscv.vector.tuple", <vscale x 4 x i8>, 5) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg5.mask.triscv.vector.tuple_nxv4i8_5t.nxv4i1.i64(target("riscv.vector.tuple", <vscale x 4 x i8>, 5) [[V_TUPLE]], ptr [[BASE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg5e8_v_u8mf2x5_m(vbool16_t mask, uint8_t *base, vuint8mf2x5_t v_tuple, size_t vl) {
  return __riscv_vsseg5e8_v_u8mf2x5_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg5e8_v_u8m1x5_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], target("riscv.vector.tuple", <vscale x 8 x i8>, 5) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg5.mask.triscv.vector.tuple_nxv8i8_5t.nxv8i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) [[V_TUPLE]], ptr [[BASE]], <vscale x 8 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg5e8_v_u8m1x5_m(vbool8_t mask, uint8_t *base, vuint8m1x5_t v_tuple, size_t vl) {
  return __riscv_vsseg5e8_v_u8m1x5_m(mask, base, v_tuple, vl);
}
