; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -O0 -mtriple=aarch64-linux-gnu -mattr=+sve -global-isel -stop-after=irtranslator -aarch64-enable-gisel-sve=1 %s -o - | FileCheck %s

define i32 @extract_v4i32_vector_insert_const(<4 x i32> %a, <2 x i32> %b, i32 %c) {
  ; CHECK-LABEL: name: extract_v4i32_vector_insert_const
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $d1, $q0, $w0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<4 x s32>) = COPY $q0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(<2 x s32>) = COPY $d1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 1
  ; CHECK-NEXT:   [[INSERT_SUBVECTOR:%[0-9]+]]:_(<4 x s32>) = G_INSERT_SUBVECTOR [[COPY]], [[COPY1]](<2 x s32>), 0
  ; CHECK-NEXT:   [[EVEC:%[0-9]+]]:_(s32) = G_EXTRACT_VECTOR_ELT [[INSERT_SUBVECTOR]](<4 x s32>), [[C]](s64)
  ; CHECK-NEXT:   $w0 = COPY [[EVEC]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $w0
entry:
  %vector = call <4 x i32> @llvm.vector.insert.v4i32.v2i32(<4 x i32> %a, <2 x i32> %b, i64 0)
  %d = extractelement <4 x i32> %vector, i32 1
  ret i32 %d
}

define double @extract_v4double_vector_insert_const(<4 x double> %a, <2 x double> %b, i32 %c) {
  ; CHECK-LABEL: name: extract_v4double_vector_insert_const
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $q0, $q1, $q2, $w0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<2 x s64>) = COPY $q0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(<2 x s64>) = COPY $q1
  ; CHECK-NEXT:   [[CONCAT_VECTORS:%[0-9]+]]:_(<4 x s64>) = G_CONCAT_VECTORS [[COPY]](<2 x s64>), [[COPY1]](<2 x s64>)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(<2 x s64>) = COPY $q2
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 1
  ; CHECK-NEXT:   [[INSERT_SUBVECTOR:%[0-9]+]]:_(<4 x s64>) = G_INSERT_SUBVECTOR [[CONCAT_VECTORS]], [[COPY2]](<2 x s64>), 0
  ; CHECK-NEXT:   [[EVEC:%[0-9]+]]:_(s64) = G_EXTRACT_VECTOR_ELT [[INSERT_SUBVECTOR]](<4 x s64>), [[C]](s64)
  ; CHECK-NEXT:   $d0 = COPY [[EVEC]](s64)
  ; CHECK-NEXT:   RET_ReallyLR implicit $d0
entry:
  %vector = call <4 x double> @llvm.vector.insert.v4f64.v2f64(<4 x double> %a, <2 x double> %b, i64 0)
  %d = extractelement <4 x double> %vector, i32 1
  ret double %d
}

define float @extract_v4float_vector_insert_const(<4 x float> %a, <2 x float> %b, i32 %c) {
  ; CHECK-LABEL: name: extract_v4float_vector_insert_const
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $d1, $q0, $w0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<2 x s64>) = COPY $q0
  ; CHECK-NEXT:   [[BITCAST:%[0-9]+]]:_(<4 x s32>) = G_BITCAST [[COPY]](<2 x s64>)
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(<2 x s32>) = COPY $d1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 1
  ; CHECK-NEXT:   [[INSERT_SUBVECTOR:%[0-9]+]]:_(<4 x s32>) = G_INSERT_SUBVECTOR [[BITCAST]], [[COPY1]](<2 x s32>), 0
  ; CHECK-NEXT:   [[EVEC:%[0-9]+]]:_(s32) = G_EXTRACT_VECTOR_ELT [[INSERT_SUBVECTOR]](<4 x s32>), [[C]](s64)
  ; CHECK-NEXT:   $s0 = COPY [[EVEC]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $s0
entry:
  %vector = call <4 x float> @llvm.vector.insert.v4f32.v2f32(<4 x float> %a, <2 x float> %b, i64 0)
  %d = extractelement <4 x float> %vector, i32 1
  ret float %d
}

define i32 @extract_v4i32_vector_insert(<4 x i32> %a, <2 x i32> %b, i32 %c) {
  ; CHECK-LABEL: name: extract_v4i32_vector_insert
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $d1, $q0, $w0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<4 x s32>) = COPY $q0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(<2 x s32>) = COPY $d1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK-NEXT:   [[INSERT_SUBVECTOR:%[0-9]+]]:_(<4 x s32>) = G_INSERT_SUBVECTOR [[COPY]], [[COPY1]](<2 x s32>), 0
  ; CHECK-NEXT:   [[ZEXT:%[0-9]+]]:_(s64) = G_ZEXT [[COPY2]](s32)
  ; CHECK-NEXT:   [[EVEC:%[0-9]+]]:_(s32) = G_EXTRACT_VECTOR_ELT [[INSERT_SUBVECTOR]](<4 x s32>), [[ZEXT]](s64)
  ; CHECK-NEXT:   $w0 = COPY [[EVEC]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $w0
entry:
  %vector = call <4 x i32> @llvm.vector.insert.v4i32.v2i32(<4 x i32> %a, <2 x i32> %b, i64 0)
  %d = extractelement <4 x i32> %vector, i32 %c
  ret i32 %d
}

define i32 @extract_v4i32_vector_extract(<4 x i32> %a, <2 x i32> %b, i32 %c) {
  ; CHECK-LABEL: name: extract_v4i32_vector_extract
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $d1, $q0, $w0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<4 x s32>) = COPY $q0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(<2 x s32>) = COPY $d1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK-NEXT:   [[EXTRACT_SUBVECTOR:%[0-9]+]]:_(<4 x s32>) = G_EXTRACT_SUBVECTOR [[COPY]](<4 x s32>), 0
  ; CHECK-NEXT:   [[ZEXT:%[0-9]+]]:_(s64) = G_ZEXT [[COPY2]](s32)
  ; CHECK-NEXT:   [[EVEC:%[0-9]+]]:_(s32) = G_EXTRACT_VECTOR_ELT [[EXTRACT_SUBVECTOR]](<4 x s32>), [[ZEXT]](s64)
  ; CHECK-NEXT:   $w0 = COPY [[EVEC]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $w0
entry:
  %vector = call <4 x i32> @llvm.vector.extract.v2i32.v4i32(<4 x i32> %a, i64 0)
  %d = extractelement <4 x i32> %vector, i32 %c
  ret i32 %d
}

define i32 @extract_v4i32_vector_extract_const(<vscale x 4 x i32> %a, i32 %c, ptr %p) {
  ; CHECK-LABEL: name: extract_v4i32_vector_extract_const
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $w0, $x1, $z0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s32>) = COPY $z0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(p0) = COPY $x1
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 1
  ; CHECK-NEXT:   [[EXTRACT_SUBVECTOR:%[0-9]+]]:_(<vscale x 4 x s32>) = G_EXTRACT_SUBVECTOR [[COPY]](<vscale x 4 x s32>), 0
  ; CHECK-NEXT:   G_STORE [[EXTRACT_SUBVECTOR]](<vscale x 4 x s32>), [[COPY2]](p0) :: (store (<vscale x 4 x s32>) into %ir.p)
  ; CHECK-NEXT:   $w0 = COPY [[C]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $w0
entry:
  %vector = call <vscale x 4 x i32> @llvm.vector.extract(<vscale x 4 x i32> %a, i64 0)
  store <vscale x 4 x i32> %vector, ptr %p, align 16
  ret i32 1
}

define i32 @extract_v2double_vector_extract_const(<vscale x 2 x double> %a, i32 %c, ptr %p) {
  ; CHECK-LABEL: name: extract_v2double_vector_extract_const
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $w0, $x1, $z0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s64>) = COPY $z0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(p0) = COPY $x1
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 1
  ; CHECK-NEXT:   [[EXTRACT_SUBVECTOR:%[0-9]+]]:_(<vscale x 2 x s64>) = G_EXTRACT_SUBVECTOR [[COPY]](<vscale x 2 x s64>), 0
  ; CHECK-NEXT:   G_STORE [[EXTRACT_SUBVECTOR]](<vscale x 2 x s64>), [[COPY2]](p0) :: (store (<vscale x 2 x s64>) into %ir.p)
  ; CHECK-NEXT:   $w0 = COPY [[C]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $w0
entry:
  %vector = call <vscale x 2 x double> @llvm.vector.extract(<vscale x 2 x double> %a, i64 0)
  store <vscale x 2 x double> %vector, ptr %p, align 16
  ret i32 1
}

define i32 @extract_v4i32_vector_insert_const_vscale(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b, i32 %c, ptr %p) {
  ; CHECK-LABEL: name: extract_v4i32_vector_insert_const_vscale
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $w0, $x1, $z0, $z1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s32>) = COPY $z0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(<vscale x 4 x s32>) = COPY $z1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(p0) = COPY $x1
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 1
  ; CHECK-NEXT:   [[INSERT_SUBVECTOR:%[0-9]+]]:_(<vscale x 4 x s32>) = G_INSERT_SUBVECTOR [[COPY]], [[COPY1]](<vscale x 4 x s32>), 0
  ; CHECK-NEXT:   G_STORE [[INSERT_SUBVECTOR]](<vscale x 4 x s32>), [[COPY3]](p0) :: (store (<vscale x 4 x s32>) into %ir.p)
  ; CHECK-NEXT:   $w0 = COPY [[C]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $w0
entry:
  %vector = call <vscale x 4 x i32> @llvm.vector.insert.nxv4i32.v4i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b, i64 0)
  store <vscale x 4 x i32> %vector, ptr %p, align 16
  ret i32 1
}

define i32 @extract_v4i32_vector_extract_const_illegal_fixed(<4 x i32> %a, ptr %p) {
  ; CHECK-LABEL: name: extract_v4i32_vector_extract_const_illegal_fixed
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $q0, $x0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<4 x s32>) = COPY $q0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; CHECK-NEXT:   [[C1:%[0-9]+]]:_(s32) = G_CONSTANT i32 1
  ; CHECK-NEXT:   [[EVEC:%[0-9]+]]:_(s32) = G_EXTRACT_VECTOR_ELT [[COPY]](<4 x s32>), [[C]](s64)
  ; CHECK-NEXT:   G_STORE [[EVEC]](s32), [[COPY1]](p0) :: (store (s32) into %ir.p, align 16)
  ; CHECK-NEXT:   $w0 = COPY [[C1]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $w0
entry:
  %vector = call <1 x i32> @llvm.vector.extract(<4 x i32> %a, i64 0)
  store <1 x i32> %vector, ptr %p, align 16
  ret i32 1
}

define i32 @extract_v4i32_vector_extract_const_illegal_scalable(<vscale x 4 x i32> %a, ptr %p) {
  ; CHECK-LABEL: name: extract_v4i32_vector_extract_const_illegal_scalable
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $x0, $z0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s32>) = COPY $z0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; CHECK-NEXT:   [[C1:%[0-9]+]]:_(s32) = G_CONSTANT i32 1
  ; CHECK-NEXT:   [[VSCALE:%[0-9]+]]:_(s64) = G_VSCALE i64 1
  ; CHECK-NEXT:   [[MUL:%[0-9]+]]:_(s64) = G_MUL [[VSCALE]], [[C]]
  ; CHECK-NEXT:   [[EVEC:%[0-9]+]]:_(s32) = G_EXTRACT_VECTOR_ELT [[COPY]](<vscale x 4 x s32>), [[MUL]](s64)
  ; CHECK-NEXT:   G_STORE [[EVEC]](s32), [[COPY1]](p0) :: (store (s32) into %ir.p, align 16)
  ; CHECK-NEXT:   $w0 = COPY [[C1]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $w0
entry:
  %vector = call <1 x i32> @llvm.vector.extract(<vscale x 4 x i32> %a, i64 0)
  store <1 x i32> %vector, ptr %p, align 16
  ret i32 1
}

define i32 @extract_v4i32_vector_insert_const_illegal_scalable(<vscale x 4 x i32> %a, <1 x i32> %b, i32 %c, ptr %p) {
  ; CHECK-LABEL: name: extract_v4i32_vector_insert_const_illegal_scalable
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $d1, $w0, $x1, $z0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s32>) = COPY $z0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(<2 x s32>) = COPY $d1
  ; CHECK-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[COPY1]](<2 x s32>)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(p0) = COPY $x1
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; CHECK-NEXT:   [[C1:%[0-9]+]]:_(s32) = G_CONSTANT i32 1
  ; CHECK-NEXT:   [[VSCALE:%[0-9]+]]:_(s64) = G_VSCALE i64 1
  ; CHECK-NEXT:   [[MUL:%[0-9]+]]:_(s64) = G_MUL [[VSCALE]], [[C]]
  ; CHECK-NEXT:   [[IVEC:%[0-9]+]]:_(<vscale x 4 x s32>) = G_INSERT_VECTOR_ELT [[COPY]], [[UV]](s32), [[MUL]](s64)
  ; CHECK-NEXT:   G_STORE [[IVEC]](<vscale x 4 x s32>), [[COPY3]](p0) :: (store (<vscale x 4 x s32>) into %ir.p)
  ; CHECK-NEXT:   $w0 = COPY [[C1]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $w0
entry:
  %vector = call <vscale x 4  x i32> @llvm.vector.insert.nxv4i32.v4i32(<vscale x 4 x i32> %a, <1 x i32> %b, i64 0)
  store <vscale x 4 x i32> %vector, ptr %p, align 16
  ret i32 1
}

define i32 @extract_v4i32_vector_insert_const_fixed(<4 x i32> %a, <1 x i32> %b, i32 %c, ptr %p) {
  ; CHECK-LABEL: name: extract_v4i32_vector_insert_const_fixed
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $d1, $q0, $w0, $x1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<4 x s32>) = COPY $q0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(<2 x s32>) = COPY $d1
  ; CHECK-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[COPY1]](<2 x s32>)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(p0) = COPY $x1
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; CHECK-NEXT:   [[C1:%[0-9]+]]:_(s32) = G_CONSTANT i32 1
  ; CHECK-NEXT:   [[IVEC:%[0-9]+]]:_(<4 x s32>) = G_INSERT_VECTOR_ELT [[COPY]], [[UV]](s32), [[C]](s64)
  ; CHECK-NEXT:   G_STORE [[IVEC]](<4 x s32>), [[COPY3]](p0) :: (store (<4 x s32>) into %ir.p)
  ; CHECK-NEXT:   $w0 = COPY [[C1]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $w0
entry:
  %vector = call <4  x i32> @llvm.vector.insert.v4i32.v4i32(<4 x i32> %a, <1 x i32> %b, i64 0)
  store <4 x i32> %vector, ptr %p, align 16
  ret i32 1
}

define i32 @extract_v4i32_vector_insert_const_fixed_illegal(<1 x i32> %a, <1 x i32> %b, i32 %c, ptr %p) {
  ; CHECK-LABEL: name: extract_v4i32_vector_insert_const_fixed_illegal
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $d0, $d1, $w0, $x1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<2 x s32>) = COPY $d0
  ; CHECK-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[COPY]](<2 x s32>)
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(<2 x s32>) = COPY $d1
  ; CHECK-NEXT:   [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[COPY1]](<2 x s32>)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(p0) = COPY $x1
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 1
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s32) = COPY [[UV]](s32)
  ; CHECK-NEXT:   G_STORE [[COPY4]](s32), [[COPY3]](p0) :: (store (s32) into %ir.p, align 16)
  ; CHECK-NEXT:   $w0 = COPY [[C]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $w0
entry:
  %vector = call <1  x i32> @llvm.vector.insert.v1i32.v4i32(<1 x i32> %a, <1 x i32> %b, i64 0)
  store <1 x i32> %vector, ptr %p, align 16
  ret i32 1
}

define i32 @extract_v4ptr_vector_insert_const_fixed_illegal(<1 x ptr> %a, <1 x ptr> %b, i32 %c, ptr %p) {
  ; CHECK-LABEL: name: extract_v4ptr_vector_insert_const_fixed_illegal
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $d0, $d1, $w0, $x1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $d0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(p0) = COPY $d1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(p0) = COPY $x1
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 1
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(p0) = COPY [[COPY]](p0)
  ; CHECK-NEXT:   G_STORE [[COPY4]](p0), [[COPY3]](p0) :: (store (p0) into %ir.p, align 16)
  ; CHECK-NEXT:   $w0 = COPY [[C]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $w0
entry:
  %vector = call <1  x ptr> @llvm.vector.insert.v1ptr.v4ptr(<1 x ptr> %a, <1 x ptr> %b, i64 0)
  store <1 x ptr> %vector, ptr %p, align 16
  ret i32 1
}

define i32 @extract_v4ifloat_vector_insert_const_fixed_illegal(<1 x float> %a, <1 x float> %b, float %c, ptr %p) {
  ; CHECK-LABEL: name: extract_v4ifloat_vector_insert_const_fixed_illegal
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $d0, $d1, $s2, $x0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<2 x s32>) = COPY $d0
  ; CHECK-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[COPY]](<2 x s32>)
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(<2 x s32>) = COPY $d1
  ; CHECK-NEXT:   [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[COPY1]](<2 x s32>)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $s2
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 1
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s32) = COPY [[UV]](s32)
  ; CHECK-NEXT:   G_STORE [[COPY4]](s32), [[COPY3]](p0) :: (store (s32) into %ir.p, align 16)
  ; CHECK-NEXT:   $w0 = COPY [[C]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $w0
entry:
  %vector = call <1  x float> @llvm.vector.insert.v1f32.v4f32(<1 x float> %a, <1 x float> %b, i64 0)
  store <1 x float> %vector, ptr %p, align 16
  ret i32 1
}

define i32 @extract_v4iptr_vector_insert_const_fixed_illegal(<1 x ptr> %a, <1 x ptr> %b, ptr %c, ptr %p) {
  ; CHECK-LABEL: name: extract_v4iptr_vector_insert_const_fixed_illegal
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $d0, $d1, $x0, $x1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $d0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(p0) = COPY $d1
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(p0) = COPY $x1
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 1
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(p0) = COPY [[COPY]](p0)
  ; CHECK-NEXT:   G_STORE [[COPY4]](p0), [[COPY3]](p0) :: (store (p0) into %ir.p, align 16)
  ; CHECK-NEXT:   $w0 = COPY [[C]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $w0
entry:
  %vector = call <1  x ptr> @llvm.vector.insert.v1ptr.v4ptr(<1 x ptr> %a, <1 x ptr> %b, i64 0)
  store <1 x ptr> %vector, ptr %p, align 16
  ret i32 1
}

define i32 @extract_v4iptr_vector_insert_const_fixed_legal(<4 x ptr> %a, <4 x ptr> %b, ptr %c, ptr %p) {
  ; CHECK-LABEL: name: extract_v4iptr_vector_insert_const_fixed_legal
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $q0, $q1, $q2, $q3, $x0, $x1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<2 x s64>) = COPY $q0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(<2 x s64>) = COPY $q1
  ; CHECK-NEXT:   [[CONCAT_VECTORS:%[0-9]+]]:_(<4 x p0>) = G_CONCAT_VECTORS [[COPY]](<2 x s64>), [[COPY1]](<2 x s64>)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(<2 x s64>) = COPY $q2
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(<2 x s64>) = COPY $q3
  ; CHECK-NEXT:   [[CONCAT_VECTORS1:%[0-9]+]]:_(<4 x p0>) = G_CONCAT_VECTORS [[COPY2]](<2 x s64>), [[COPY3]](<2 x s64>)
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(p0) = COPY $x1
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 1
  ; CHECK-NEXT:   [[INSERT_SUBVECTOR:%[0-9]+]]:_(<4 x p0>) = G_INSERT_SUBVECTOR [[CONCAT_VECTORS]], [[CONCAT_VECTORS1]](<4 x p0>), 0
  ; CHECK-NEXT:   G_STORE [[INSERT_SUBVECTOR]](<4 x p0>), [[COPY5]](p0) :: (store (<4 x p0>) into %ir.p, align 16)
  ; CHECK-NEXT:   $w0 = COPY [[C]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $w0
entry:
  %vector = call <4  x ptr> @llvm.vector.insert.v4ptr.v4ptr(<4 x ptr> %a, <4 x ptr> %b, i64 0)
  store <4 x ptr> %vector, ptr %p, align 16
  ret i32 1
}