// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -emit-llvm -o - %s | FileCheck %s

// CHECK-LABEL: @_Z3foo10svboolx4_t(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[ARG:%.*]] = alloca { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> }, align 2
// CHECK-NEXT:    [[ARG_ADDR:%.*]] = alloca { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> }, align 2
// CHECK-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } poison, <vscale x 16 x i1> [[ARG_COERCE0:%.*]], 0
// CHECK-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[TMP0]], <vscale x 16 x i1> [[ARG_COERCE1:%.*]], 1
// CHECK-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[TMP1]], <vscale x 16 x i1> [[ARG_COERCE2:%.*]], 2
// CHECK-NEXT:    [[TMP3:%.*]] = insertvalue { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[TMP2]], <vscale x 16 x i1> [[ARG_COERCE3:%.*]], 3
// CHECK-NEXT:    store { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[TMP3]], ptr [[ARG]], align 2
// CHECK-NEXT:    [[ARG1:%.*]] = load { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> }, ptr [[ARG]], align 2
// CHECK-NEXT:    store { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[ARG1]], ptr [[ARG_ADDR]], align 2
// CHECK-NEXT:    [[TMP4:%.*]] = load { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> }, ptr [[ARG_ADDR]], align 2
// CHECK-NEXT:    ret { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[TMP4]]
//
__clang_svboolx4_t foo(__clang_svboolx4_t arg) { return arg; }

__clang_svboolx4_t bar();
// CHECK-LABEL: @_Z4foo2v(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[CALL:%.*]] = call { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } @_Z3barv()
// CHECK-NEXT:    ret { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[CALL]]
//
__clang_svboolx4_t foo2() { return bar(); }

__clang_svboolx4_t bar2(__clang_svboolx4_t);
// CHECK-LABEL: @_Z4foo310svboolx4_t(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[ARG:%.*]] = alloca { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> }, align 2
// CHECK-NEXT:    [[ARG_ADDR:%.*]] = alloca { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> }, align 2
// CHECK-NEXT:    [[COERCE:%.*]] = alloca { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> }, align 2
// CHECK-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } poison, <vscale x 16 x i1> [[ARG_COERCE0:%.*]], 0
// CHECK-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[TMP0]], <vscale x 16 x i1> [[ARG_COERCE1:%.*]], 1
// CHECK-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[TMP1]], <vscale x 16 x i1> [[ARG_COERCE2:%.*]], 2
// CHECK-NEXT:    [[TMP3:%.*]] = insertvalue { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[TMP2]], <vscale x 16 x i1> [[ARG_COERCE3:%.*]], 3
// CHECK-NEXT:    store { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[TMP3]], ptr [[ARG]], align 2
// CHECK-NEXT:    [[ARG1:%.*]] = load { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> }, ptr [[ARG]], align 2
// CHECK-NEXT:    store { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[ARG1]], ptr [[ARG_ADDR]], align 2
// CHECK-NEXT:    [[TMP4:%.*]] = load { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> }, ptr [[ARG_ADDR]], align 2
// CHECK-NEXT:    store { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[TMP4]], ptr [[COERCE]], align 2
// CHECK-NEXT:    [[COERCE_TUPLE:%.*]] = load { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> }, ptr [[COERCE]], align 2
// CHECK-NEXT:    [[COERCE_EXTRACT0:%.*]] = extractvalue { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[COERCE_TUPLE]], 0
// CHECK-NEXT:    [[COERCE_EXTRACT1:%.*]] = extractvalue { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[COERCE_TUPLE]], 1
// CHECK-NEXT:    [[COERCE_EXTRACT2:%.*]] = extractvalue { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[COERCE_TUPLE]], 2
// CHECK-NEXT:    [[COERCE_EXTRACT3:%.*]] = extractvalue { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[COERCE_TUPLE]], 3
// CHECK-NEXT:    [[CALL:%.*]] = call { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } @_Z4bar210svboolx4_t(<vscale x 16 x i1> [[COERCE_EXTRACT0]], <vscale x 16 x i1> [[COERCE_EXTRACT1]], <vscale x 16 x i1> [[COERCE_EXTRACT2]], <vscale x 16 x i1> [[COERCE_EXTRACT3]])
// CHECK-NEXT:    ret { <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1> } [[CALL]]
//
__clang_svboolx4_t foo3(__clang_svboolx4_t arg) { return bar2(arg); }
