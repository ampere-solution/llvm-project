; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=wasm32-unknown-unknown < %s | FileCheck -check-prefix=WASM32 %s
; RUN: llc -mtriple=wasm64-unknown-unknown < %s | FileCheck -check-prefix=WASM64 %s

define i8 @atomicrmw_usub_cond_i8(ptr %ptr, i8 %val) {
; WASM32-LABEL: atomicrmw_usub_cond_i8:
; WASM32:         .functype atomicrmw_usub_cond_i8 (i32, i32) -> (i32)
; WASM32-NEXT:    .local i32
; WASM32-NEXT:  # %bb.0:
; WASM32-NEXT:    local.get 0
; WASM32-NEXT:    local.get 0
; WASM32-NEXT:    i32.load8_u 0
; WASM32-NEXT:    local.tee 2
; WASM32-NEXT:    local.get 1
; WASM32-NEXT:    i32.sub
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    local.get 1
; WASM32-NEXT:    i32.const 255
; WASM32-NEXT:    i32.and
; WASM32-NEXT:    i32.ge_u
; WASM32-NEXT:    i32.select
; WASM32-NEXT:    i32.store8 0
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    # fallthrough-return
;
; WASM64-LABEL: atomicrmw_usub_cond_i8:
; WASM64:         .functype atomicrmw_usub_cond_i8 (i64, i32) -> (i32)
; WASM64-NEXT:    .local i32
; WASM64-NEXT:  # %bb.0:
; WASM64-NEXT:    local.get 0
; WASM64-NEXT:    local.get 0
; WASM64-NEXT:    i32.load8_u 0
; WASM64-NEXT:    local.tee 2
; WASM64-NEXT:    local.get 1
; WASM64-NEXT:    i32.sub
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    local.get 1
; WASM64-NEXT:    i32.const 255
; WASM64-NEXT:    i32.and
; WASM64-NEXT:    i32.ge_u
; WASM64-NEXT:    i32.select
; WASM64-NEXT:    i32.store8 0
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    # fallthrough-return
  %result = atomicrmw usub_cond ptr %ptr, i8 %val seq_cst
  ret i8 %result
}

define i16 @atomicrmw_usub_cond_i16(ptr %ptr, i16 %val) {
; WASM32-LABEL: atomicrmw_usub_cond_i16:
; WASM32:         .functype atomicrmw_usub_cond_i16 (i32, i32) -> (i32)
; WASM32-NEXT:    .local i32
; WASM32-NEXT:  # %bb.0:
; WASM32-NEXT:    local.get 0
; WASM32-NEXT:    local.get 0
; WASM32-NEXT:    i32.load16_u 0
; WASM32-NEXT:    local.tee 2
; WASM32-NEXT:    local.get 1
; WASM32-NEXT:    i32.sub
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    local.get 1
; WASM32-NEXT:    i32.const 65535
; WASM32-NEXT:    i32.and
; WASM32-NEXT:    i32.ge_u
; WASM32-NEXT:    i32.select
; WASM32-NEXT:    i32.store16 0
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    # fallthrough-return
;
; WASM64-LABEL: atomicrmw_usub_cond_i16:
; WASM64:         .functype atomicrmw_usub_cond_i16 (i64, i32) -> (i32)
; WASM64-NEXT:    .local i32
; WASM64-NEXT:  # %bb.0:
; WASM64-NEXT:    local.get 0
; WASM64-NEXT:    local.get 0
; WASM64-NEXT:    i32.load16_u 0
; WASM64-NEXT:    local.tee 2
; WASM64-NEXT:    local.get 1
; WASM64-NEXT:    i32.sub
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    local.get 1
; WASM64-NEXT:    i32.const 65535
; WASM64-NEXT:    i32.and
; WASM64-NEXT:    i32.ge_u
; WASM64-NEXT:    i32.select
; WASM64-NEXT:    i32.store16 0
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    # fallthrough-return
  %result = atomicrmw usub_cond ptr %ptr, i16 %val seq_cst
  ret i16 %result
}

define i32 @atomicrmw_usub_cond_i32(ptr %ptr, i32 %val) {
; WASM32-LABEL: atomicrmw_usub_cond_i32:
; WASM32:         .functype atomicrmw_usub_cond_i32 (i32, i32) -> (i32)
; WASM32-NEXT:    .local i32
; WASM32-NEXT:  # %bb.0:
; WASM32-NEXT:    local.get 0
; WASM32-NEXT:    local.get 0
; WASM32-NEXT:    i32.load 0
; WASM32-NEXT:    local.tee 2
; WASM32-NEXT:    local.get 1
; WASM32-NEXT:    i32.sub
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    local.get 1
; WASM32-NEXT:    i32.ge_u
; WASM32-NEXT:    i32.select
; WASM32-NEXT:    i32.store 0
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    # fallthrough-return
;
; WASM64-LABEL: atomicrmw_usub_cond_i32:
; WASM64:         .functype atomicrmw_usub_cond_i32 (i64, i32) -> (i32)
; WASM64-NEXT:    .local i32
; WASM64-NEXT:  # %bb.0:
; WASM64-NEXT:    local.get 0
; WASM64-NEXT:    local.get 0
; WASM64-NEXT:    i32.load 0
; WASM64-NEXT:    local.tee 2
; WASM64-NEXT:    local.get 1
; WASM64-NEXT:    i32.sub
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    local.get 1
; WASM64-NEXT:    i32.ge_u
; WASM64-NEXT:    i32.select
; WASM64-NEXT:    i32.store 0
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    # fallthrough-return
  %result = atomicrmw usub_cond ptr %ptr, i32 %val seq_cst
  ret i32 %result
}

define i64 @atomicrmw_usub_cond_i64(ptr %ptr, i64 %val) {
; WASM32-LABEL: atomicrmw_usub_cond_i64:
; WASM32:         .functype atomicrmw_usub_cond_i64 (i32, i64) -> (i64)
; WASM32-NEXT:    .local i64
; WASM32-NEXT:  # %bb.0:
; WASM32-NEXT:    local.get 0
; WASM32-NEXT:    local.get 0
; WASM32-NEXT:    i64.load 0
; WASM32-NEXT:    local.tee 2
; WASM32-NEXT:    local.get 1
; WASM32-NEXT:    i64.sub
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    local.get 1
; WASM32-NEXT:    i64.ge_u
; WASM32-NEXT:    i64.select
; WASM32-NEXT:    i64.store 0
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    # fallthrough-return
;
; WASM64-LABEL: atomicrmw_usub_cond_i64:
; WASM64:         .functype atomicrmw_usub_cond_i64 (i64, i64) -> (i64)
; WASM64-NEXT:    .local i64
; WASM64-NEXT:  # %bb.0:
; WASM64-NEXT:    local.get 0
; WASM64-NEXT:    local.get 0
; WASM64-NEXT:    i64.load 0
; WASM64-NEXT:    local.tee 2
; WASM64-NEXT:    local.get 1
; WASM64-NEXT:    i64.sub
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    local.get 1
; WASM64-NEXT:    i64.ge_u
; WASM64-NEXT:    i64.select
; WASM64-NEXT:    i64.store 0
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    # fallthrough-return
  %result = atomicrmw usub_cond ptr %ptr, i64 %val seq_cst
  ret i64 %result
}

define i8 @atomicrmw_usub_sat_i8(ptr %ptr, i8 %val) {
; WASM32-LABEL: atomicrmw_usub_sat_i8:
; WASM32:         .functype atomicrmw_usub_sat_i8 (i32, i32) -> (i32)
; WASM32-NEXT:    .local i32
; WASM32-NEXT:  # %bb.0:
; WASM32-NEXT:    local.get 0
; WASM32-NEXT:    i32.const 0
; WASM32-NEXT:    local.get 0
; WASM32-NEXT:    i32.load8_u 0
; WASM32-NEXT:    local.tee 2
; WASM32-NEXT:    local.get 1
; WASM32-NEXT:    i32.const 255
; WASM32-NEXT:    i32.and
; WASM32-NEXT:    i32.sub
; WASM32-NEXT:    local.tee 1
; WASM32-NEXT:    local.get 1
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    i32.gt_u
; WASM32-NEXT:    i32.select
; WASM32-NEXT:    i32.store8 0
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    # fallthrough-return
;
; WASM64-LABEL: atomicrmw_usub_sat_i8:
; WASM64:         .functype atomicrmw_usub_sat_i8 (i64, i32) -> (i32)
; WASM64-NEXT:    .local i32
; WASM64-NEXT:  # %bb.0:
; WASM64-NEXT:    local.get 0
; WASM64-NEXT:    i32.const 0
; WASM64-NEXT:    local.get 0
; WASM64-NEXT:    i32.load8_u 0
; WASM64-NEXT:    local.tee 2
; WASM64-NEXT:    local.get 1
; WASM64-NEXT:    i32.const 255
; WASM64-NEXT:    i32.and
; WASM64-NEXT:    i32.sub
; WASM64-NEXT:    local.tee 1
; WASM64-NEXT:    local.get 1
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    i32.gt_u
; WASM64-NEXT:    i32.select
; WASM64-NEXT:    i32.store8 0
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    # fallthrough-return
  %result = atomicrmw usub_sat ptr %ptr, i8 %val seq_cst
  ret i8 %result
}

define i16 @atomicrmw_usub_sat_i16(ptr %ptr, i16 %val) {
; WASM32-LABEL: atomicrmw_usub_sat_i16:
; WASM32:         .functype atomicrmw_usub_sat_i16 (i32, i32) -> (i32)
; WASM32-NEXT:    .local i32
; WASM32-NEXT:  # %bb.0:
; WASM32-NEXT:    local.get 0
; WASM32-NEXT:    i32.const 0
; WASM32-NEXT:    local.get 0
; WASM32-NEXT:    i32.load16_u 0
; WASM32-NEXT:    local.tee 2
; WASM32-NEXT:    local.get 1
; WASM32-NEXT:    i32.const 65535
; WASM32-NEXT:    i32.and
; WASM32-NEXT:    i32.sub
; WASM32-NEXT:    local.tee 1
; WASM32-NEXT:    local.get 1
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    i32.gt_u
; WASM32-NEXT:    i32.select
; WASM32-NEXT:    i32.store16 0
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    # fallthrough-return
;
; WASM64-LABEL: atomicrmw_usub_sat_i16:
; WASM64:         .functype atomicrmw_usub_sat_i16 (i64, i32) -> (i32)
; WASM64-NEXT:    .local i32
; WASM64-NEXT:  # %bb.0:
; WASM64-NEXT:    local.get 0
; WASM64-NEXT:    i32.const 0
; WASM64-NEXT:    local.get 0
; WASM64-NEXT:    i32.load16_u 0
; WASM64-NEXT:    local.tee 2
; WASM64-NEXT:    local.get 1
; WASM64-NEXT:    i32.const 65535
; WASM64-NEXT:    i32.and
; WASM64-NEXT:    i32.sub
; WASM64-NEXT:    local.tee 1
; WASM64-NEXT:    local.get 1
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    i32.gt_u
; WASM64-NEXT:    i32.select
; WASM64-NEXT:    i32.store16 0
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    # fallthrough-return
  %result = atomicrmw usub_sat ptr %ptr, i16 %val seq_cst
  ret i16 %result
}

define i32 @atomicrmw_usub_sat_i32(ptr %ptr, i32 %val) {
; WASM32-LABEL: atomicrmw_usub_sat_i32:
; WASM32:         .functype atomicrmw_usub_sat_i32 (i32, i32) -> (i32)
; WASM32-NEXT:    .local i32
; WASM32-NEXT:  # %bb.0:
; WASM32-NEXT:    local.get 0
; WASM32-NEXT:    i32.const 0
; WASM32-NEXT:    local.get 0
; WASM32-NEXT:    i32.load 0
; WASM32-NEXT:    local.tee 2
; WASM32-NEXT:    local.get 1
; WASM32-NEXT:    i32.sub
; WASM32-NEXT:    local.tee 1
; WASM32-NEXT:    local.get 1
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    i32.gt_u
; WASM32-NEXT:    i32.select
; WASM32-NEXT:    i32.store 0
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    # fallthrough-return
;
; WASM64-LABEL: atomicrmw_usub_sat_i32:
; WASM64:         .functype atomicrmw_usub_sat_i32 (i64, i32) -> (i32)
; WASM64-NEXT:    .local i32
; WASM64-NEXT:  # %bb.0:
; WASM64-NEXT:    local.get 0
; WASM64-NEXT:    i32.const 0
; WASM64-NEXT:    local.get 0
; WASM64-NEXT:    i32.load 0
; WASM64-NEXT:    local.tee 2
; WASM64-NEXT:    local.get 1
; WASM64-NEXT:    i32.sub
; WASM64-NEXT:    local.tee 1
; WASM64-NEXT:    local.get 1
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    i32.gt_u
; WASM64-NEXT:    i32.select
; WASM64-NEXT:    i32.store 0
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    # fallthrough-return
  %result = atomicrmw usub_sat ptr %ptr, i32 %val seq_cst
  ret i32 %result
}

define i64 @atomicrmw_usub_sat_i64(ptr %ptr, i64 %val) {
; WASM32-LABEL: atomicrmw_usub_sat_i64:
; WASM32:         .functype atomicrmw_usub_sat_i64 (i32, i64) -> (i64)
; WASM32-NEXT:    .local i64
; WASM32-NEXT:  # %bb.0:
; WASM32-NEXT:    local.get 0
; WASM32-NEXT:    i64.const 0
; WASM32-NEXT:    local.get 0
; WASM32-NEXT:    i64.load 0
; WASM32-NEXT:    local.tee 2
; WASM32-NEXT:    local.get 1
; WASM32-NEXT:    i64.sub
; WASM32-NEXT:    local.tee 1
; WASM32-NEXT:    local.get 1
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    i64.gt_u
; WASM32-NEXT:    i64.select
; WASM32-NEXT:    i64.store 0
; WASM32-NEXT:    local.get 2
; WASM32-NEXT:    # fallthrough-return
;
; WASM64-LABEL: atomicrmw_usub_sat_i64:
; WASM64:         .functype atomicrmw_usub_sat_i64 (i64, i64) -> (i64)
; WASM64-NEXT:    .local i64
; WASM64-NEXT:  # %bb.0:
; WASM64-NEXT:    local.get 0
; WASM64-NEXT:    i64.const 0
; WASM64-NEXT:    local.get 0
; WASM64-NEXT:    i64.load 0
; WASM64-NEXT:    local.tee 2
; WASM64-NEXT:    local.get 1
; WASM64-NEXT:    i64.sub
; WASM64-NEXT:    local.tee 1
; WASM64-NEXT:    local.get 1
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    i64.gt_u
; WASM64-NEXT:    i64.select
; WASM64-NEXT:    i64.store 0
; WASM64-NEXT:    local.get 2
; WASM64-NEXT:    # fallthrough-return
  %result = atomicrmw usub_sat ptr %ptr, i64 %val seq_cst
  ret i64 %result
}