// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -cl-std=CL2.0 -O0 -triple amdgcn-unknown-unknown -target-cpu gfx940 -emit-llvm -o - %s | FileCheck %s
// REQUIRES: amdgpu-registered-target

typedef unsigned int u32;
typedef unsigned short u16;
typedef unsigned char u8;

// CHECK-LABEL: @test_global_load_lds_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[SRC_ADDR:%.*]] = alloca ptr addrspace(1), align 8, addrspace(5)
// CHECK-NEXT:    [[DST_ADDR:%.*]] = alloca ptr addrspace(3), align 4, addrspace(5)
// CHECK-NEXT:    [[SRC_ADDR_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[SRC_ADDR]] to ptr
// CHECK-NEXT:    [[DST_ADDR_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[DST_ADDR]] to ptr
// CHECK-NEXT:    store ptr addrspace(1) [[SRC:%.*]], ptr [[SRC_ADDR_ASCAST]], align 8
// CHECK-NEXT:    store ptr addrspace(3) [[DST:%.*]], ptr [[DST_ADDR_ASCAST]], align 4
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr addrspace(1), ptr [[SRC_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr addrspace(3), ptr [[DST_ADDR_ASCAST]], align 4
// CHECK-NEXT:    call void @llvm.amdgcn.global.load.lds(ptr addrspace(1) [[TMP0]], ptr addrspace(3) [[TMP1]], i32 4, i32 0, i32 0)
// CHECK-NEXT:    ret void
//
void test_global_load_lds_u32(global u32* src, local u32 *dst) {
  __builtin_amdgcn_global_load_lds(src, dst, /*size=*/4, /*offset=*/0, /*aux=*/0);
}

// CHECK-LABEL: @test_global_load_lds_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[SRC_ADDR:%.*]] = alloca ptr addrspace(1), align 8, addrspace(5)
// CHECK-NEXT:    [[DST_ADDR:%.*]] = alloca ptr addrspace(3), align 4, addrspace(5)
// CHECK-NEXT:    [[SRC_ADDR_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[SRC_ADDR]] to ptr
// CHECK-NEXT:    [[DST_ADDR_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[DST_ADDR]] to ptr
// CHECK-NEXT:    store ptr addrspace(1) [[SRC:%.*]], ptr [[SRC_ADDR_ASCAST]], align 8
// CHECK-NEXT:    store ptr addrspace(3) [[DST:%.*]], ptr [[DST_ADDR_ASCAST]], align 4
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr addrspace(1), ptr [[SRC_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr addrspace(3), ptr [[DST_ADDR_ASCAST]], align 4
// CHECK-NEXT:    call void @llvm.amdgcn.global.load.lds(ptr addrspace(1) [[TMP0]], ptr addrspace(3) [[TMP1]], i32 2, i32 0, i32 0)
// CHECK-NEXT:    ret void
//
void test_global_load_lds_u16(global u16* src, local u16 *dst) {
  __builtin_amdgcn_global_load_lds(src, dst, /*size=*/2, /*offset=*/0, /*aux=*/0);
}

// CHECK-LABEL: @test_global_load_lds_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[SRC_ADDR:%.*]] = alloca ptr addrspace(1), align 8, addrspace(5)
// CHECK-NEXT:    [[DST_ADDR:%.*]] = alloca ptr addrspace(3), align 4, addrspace(5)
// CHECK-NEXT:    [[SRC_ADDR_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[SRC_ADDR]] to ptr
// CHECK-NEXT:    [[DST_ADDR_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[DST_ADDR]] to ptr
// CHECK-NEXT:    store ptr addrspace(1) [[SRC:%.*]], ptr [[SRC_ADDR_ASCAST]], align 8
// CHECK-NEXT:    store ptr addrspace(3) [[DST:%.*]], ptr [[DST_ADDR_ASCAST]], align 4
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr addrspace(1), ptr [[SRC_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr addrspace(3), ptr [[DST_ADDR_ASCAST]], align 4
// CHECK-NEXT:    call void @llvm.amdgcn.global.load.lds(ptr addrspace(1) [[TMP0]], ptr addrspace(3) [[TMP1]], i32 1, i32 0, i32 0)
// CHECK-NEXT:    ret void
//
void test_global_load_lds_u8(global u8* src, local u8 *dst) {
  __builtin_amdgcn_global_load_lds(src, dst, /*size=*/1, /*offset=*/0, /*aux=*/0);
}