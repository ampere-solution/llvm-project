// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: rm -rf %t
// RUN: split-file %s %t
//
// RUN: %clang_cc1 -std=c++20 -triple %itanium_abi_triple -xc++-user-header -emit-header-unit %t/header.h -o %t/header.pcm
// RUN: %clang_cc1 -std=c++20 -triple %itanium_abi_triple -fmodule-file=%t/header.pcm %t/M.cppm -emit-llvm -o - | FileCheck %t/M.cppm
// RUN: %clang_cc1 -std=c++20 -triple %itanium_abi_triple -fmodule-file=%t/header.pcm %t/Use.cpp -emit-llvm -o - | FileCheck %t/Use.cpp
//
//--- header.h
int foo();
static int i = foo();

//--- M.cppm
module;
import "header.h";
export module M;

// CHECK: @_ZL1i = {{.*}}global i32 0
// CHECK: void @__cxx_global_var_init()
// CHECK-NEXT: entry:
// CHECK-NEXT:  %call = call noundef{{.*}} i32 @_Z3foov()
// CHECK-NEXT:  store i32 %call, ptr @_ZL1i

//--- Use.cpp
import "header.h";

// CHECK: @_ZL1i = {{.*}}global i32 0
// CHECK: void @__cxx_global_var_init()
// CHECK-NEXT: entry:
// CHECK-NEXT:  %call = call noundef{{.*}} i32 @_Z3foov()
// CHECK-NEXT:  store i32 %call, ptr @_ZL1i