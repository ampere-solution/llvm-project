; This test aims to check ability to support "Arithmetic with Overflow" intrinsics
; in the special case when those intrinsics are being generated by the CodeGenPrepare;
; pass during translations with optimization (note -O3 in llc arguments).

; RUN: llc -O3 -mtriple=spirv32-unknown-unknown %s -o - | FileCheck %s
; RUN: %if spirv-tools %{ llc -O3 -mtriple=spirv32-unknown-unknown %s -o - -filetype=obj | spirv-val %}

; RUN: llc -O3 -mtriple=spirv64-unknown-unknown %s -o - | FileCheck %s
; RUN: %if spirv-tools %{ llc -O3 -mtriple=spirv64-unknown-unknown %s -o - -filetype=obj | spirv-val %}

; CHECK-DAG: OpName %[[Val:.*]] "math"
; CHECK-DAG: OpName %[[IsOver:.*]] "ov"
; CHECK-DAG: %[[Int:.*]] = OpTypeInt 32 0
; CHECK-DAG: %[[Char:.*]] = OpTypeInt 8 0
; CHECK-DAG: %[[PtrChar:.*]] = OpTypePointer Generic %[[Char]]
; CHECK-DAG: %[[Bool:.*]] = OpTypeBool
; CHECK-DAG: %[[Struct:.*]] = OpTypeStruct %[[Int]] %[[Int]]
; CHECK-DAG: %[[Const1:.*]] = OpConstant %[[Int]] 1
; CHECK-DAG: %[[Const42:.*]] = OpConstant %[[Char]] 42
; CHECK-DAG: %[[Zero:.*]] = OpConstantNull %[[Int]]

; CHECK: OpFunction
; CHECK: %[[A:.*]] = OpFunctionParameter %[[Int]]
; CHECK: %[[Ptr:.*]] = OpFunctionParameter %[[PtrChar]]
; CHECK: %[[#]] = OpLabel
; CHECK: OpBranch %[[#]]
; CHECK: %[[#]] = OpLabel
; CHECK: %[[PhiRes:.*]] = OpPhi %[[Int]] %[[A]] %[[#]] %[[Val]] %[[#]]
; CHECK: %[[AggRes:.*]] = OpIAddCarry %[[Struct]] %[[PhiRes]] %[[Const1]]
; CHECK: %[[Val]] = OpCompositeExtract %[[Int]] %[[AggRes]] 0
; CHECK: %[[Over:.*]] = OpCompositeExtract %[[Int]] %[[AggRes]] 1
; CHECK: %[[IsOver]] = OpINotEqual %[[Bool:.*]] %[[Over]] %[[Zero]]
; CHECK: OpBranchConditional %[[IsOver]] %[[#]] %[[#]]
; CHECK: OpStore %[[Ptr]] %[[Const42]] Aligned 1
; CHECK: OpBranch %[[#]]
; CHECK: %[[#]] = OpLabel
; CHECK: OpReturnValue %[[Val]]
; CHECK: OpFunctionEnd

define spir_func i32 @foo(i32 %a, ptr addrspace(4) %p) {
entry:
  br label %l1

body:
  store i8 42, ptr addrspace(4) %p
  br label %l1

l1:
  %e = phi i32 [ %a, %entry ], [ %i, %body ]
  %i = add nsw i32 %e, 1
  %fl = icmp eq i32 %i, 0
  br i1 %fl, label %exit, label %body

exit:
  ret i32 %i
}