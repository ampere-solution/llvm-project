// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -target-feature +zfh \
// RUN:   -target-feature +zvfh -disable-O0-optnone  \
// RUN:   -emit-llvm %s -o - | opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local void @test_vssseg7e32_v_f32mf2x7
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], target("riscv.vector.tuple", <vscale x 4 x i8>, 7) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg7.triscv.vector.tuple_nxv4i8_7t.i64(target("riscv.vector.tuple", <vscale x 4 x i8>, 7) [[V_TUPLE]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]], i64 5)
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg7e32_v_f32mf2x7(float *base, ptrdiff_t bstride, vfloat32mf2x7_t v_tuple, size_t vl) {
  return __riscv_vssseg7e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg7e32_v_f32m1x7
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], target("riscv.vector.tuple", <vscale x 8 x i8>, 7) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg7.triscv.vector.tuple_nxv8i8_7t.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) [[V_TUPLE]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]], i64 5)
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg7e32_v_f32m1x7(float *base, ptrdiff_t bstride, vfloat32m1x7_t v_tuple, size_t vl) {
  return __riscv_vssseg7e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg7e32_v_i32mf2x7
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], target("riscv.vector.tuple", <vscale x 4 x i8>, 7) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg7.triscv.vector.tuple_nxv4i8_7t.i64(target("riscv.vector.tuple", <vscale x 4 x i8>, 7) [[V_TUPLE]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]], i64 5)
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg7e32_v_i32mf2x7(int32_t *base, ptrdiff_t bstride, vint32mf2x7_t v_tuple, size_t vl) {
  return __riscv_vssseg7e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg7e32_v_i32m1x7
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], target("riscv.vector.tuple", <vscale x 8 x i8>, 7) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg7.triscv.vector.tuple_nxv8i8_7t.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) [[V_TUPLE]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]], i64 5)
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg7e32_v_i32m1x7(int32_t *base, ptrdiff_t bstride, vint32m1x7_t v_tuple, size_t vl) {
  return __riscv_vssseg7e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg7e32_v_u32mf2x7
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], target("riscv.vector.tuple", <vscale x 4 x i8>, 7) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg7.triscv.vector.tuple_nxv4i8_7t.i64(target("riscv.vector.tuple", <vscale x 4 x i8>, 7) [[V_TUPLE]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]], i64 5)
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg7e32_v_u32mf2x7(uint32_t *base, ptrdiff_t bstride, vuint32mf2x7_t v_tuple, size_t vl) {
  return __riscv_vssseg7e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg7e32_v_u32m1x7
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], target("riscv.vector.tuple", <vscale x 8 x i8>, 7) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg7.triscv.vector.tuple_nxv8i8_7t.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) [[V_TUPLE]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]], i64 5)
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg7e32_v_u32m1x7(uint32_t *base, ptrdiff_t bstride, vuint32m1x7_t v_tuple, size_t vl) {
  return __riscv_vssseg7e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg7e32_v_f32mf2x7_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], target("riscv.vector.tuple", <vscale x 4 x i8>, 7) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg7.mask.triscv.vector.tuple_nxv4i8_7t.i64.nxv1i1(target("riscv.vector.tuple", <vscale x 4 x i8>, 7) [[V_TUPLE]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]], i64 5)
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg7e32_v_f32mf2x7_m(vbool64_t mask, float *base, ptrdiff_t bstride, vfloat32mf2x7_t v_tuple, size_t vl) {
  return __riscv_vssseg7e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg7e32_v_f32m1x7_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], target("riscv.vector.tuple", <vscale x 8 x i8>, 7) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg7.mask.triscv.vector.tuple_nxv8i8_7t.i64.nxv2i1(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) [[V_TUPLE]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]], i64 5)
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg7e32_v_f32m1x7_m(vbool32_t mask, float *base, ptrdiff_t bstride, vfloat32m1x7_t v_tuple, size_t vl) {
  return __riscv_vssseg7e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg7e32_v_i32mf2x7_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], target("riscv.vector.tuple", <vscale x 4 x i8>, 7) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg7.mask.triscv.vector.tuple_nxv4i8_7t.i64.nxv1i1(target("riscv.vector.tuple", <vscale x 4 x i8>, 7) [[V_TUPLE]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]], i64 5)
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg7e32_v_i32mf2x7_m(vbool64_t mask, int32_t *base, ptrdiff_t bstride, vint32mf2x7_t v_tuple, size_t vl) {
  return __riscv_vssseg7e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg7e32_v_i32m1x7_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], target("riscv.vector.tuple", <vscale x 8 x i8>, 7) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg7.mask.triscv.vector.tuple_nxv8i8_7t.i64.nxv2i1(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) [[V_TUPLE]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]], i64 5)
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg7e32_v_i32m1x7_m(vbool32_t mask, int32_t *base, ptrdiff_t bstride, vint32m1x7_t v_tuple, size_t vl) {
  return __riscv_vssseg7e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg7e32_v_u32mf2x7_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], target("riscv.vector.tuple", <vscale x 4 x i8>, 7) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg7.mask.triscv.vector.tuple_nxv4i8_7t.i64.nxv1i1(target("riscv.vector.tuple", <vscale x 4 x i8>, 7) [[V_TUPLE]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]], i64 5)
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg7e32_v_u32mf2x7_m(vbool64_t mask, uint32_t *base, ptrdiff_t bstride, vuint32mf2x7_t v_tuple, size_t vl) {
  return __riscv_vssseg7e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg7e32_v_u32m1x7_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], target("riscv.vector.tuple", <vscale x 8 x i8>, 7) [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg7.mask.triscv.vector.tuple_nxv8i8_7t.i64.nxv2i1(target("riscv.vector.tuple", <vscale x 8 x i8>, 7) [[V_TUPLE]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]], i64 5)
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg7e32_v_u32m1x7_m(vbool32_t mask, uint32_t *base, ptrdiff_t bstride, vuint32m1x7_t v_tuple, size_t vl) {
  return __riscv_vssseg7e32(mask, base, bstride, v_tuple, vl);
}
