//===-- RISCVInstrGISel.td - RISC-V GISel target pseudos ----*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
/// \file
// RISC-V GlobalISel target pseudo instruction definitions. This is kept
// separately from the other tablegen files for organizational purposes, but
// share the same infrastructure.
//
//===----------------------------------------------------------------------===//

class RISCVGenericInstruction : GenericInstruction {
  let Namespace = "RISCV";
}

// Pseudo equivalent to a RISCVISD::FCLASS.
def G_FCLASS : RISCVGenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$src);
  let hasSideEffects = false;
}
def : GINodeEquiv<G_FCLASS, riscv_fclass>;

// Pseudo equivalent to a RISCVISD::READ_VLENB.
def G_READ_VLENB : RISCVGenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins);
  let hasSideEffects = false;
}
def : GINodeEquiv<G_READ_VLENB, riscv_read_vlenb>;

// Pseudo equivalent to a RISCVISD::VMCLR_VL
def G_VMCLR_VL : RISCVGenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$vl);
  let hasSideEffects = false;
}
def : GINodeEquiv<G_VMCLR_VL, riscv_vmclr_vl>;

// Pseudo equivalent to a RISCVISD::VMSET_VL
def G_VMSET_VL : RISCVGenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type1:$vl);
  let hasSideEffects = false;
}
def : GINodeEquiv<G_VMSET_VL, riscv_vmset_vl>;

// Pseudo equivalent to a RISCVISD::SPLAT_VECTOR_SPLIT_I64_VL. There is no
// record to mark as equivalent to using GINodeEquiv because it gets lowered
// before instruction selection.
def G_SPLAT_VECTOR_SPLIT_I64_VL : RISCVGenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$passthru, type1:$hi, type1:$lo, type2:$vl);
  let hasSideEffects = false;
}

// Pseudo equivalent to a RISCVISD::VSLIDEDOWN_VL
def G_VSLIDEDOWN_VL : RISCVGenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$merge, type0:$vec, type1:$idx, type2:$mask,
                       type1:$vl, type1:$policy);
  let hasSideEffects = false;
}
def : GINodeEquiv<G_VSLIDEDOWN_VL, riscv_slidedown_vl>;

// Pseudo equivalent to a RISCVISD::VMV_V_V_VL
def G_VMV_V_V_VL : RISCVGenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$passthru, type0:$vec, type1:$vl);
  let hasSideEffects = false;
}
def : GINodeEquiv<G_VMV_V_V_VL, riscv_vmv_v_v_vl>;

// Pseudo equivalent to a RISCVISD::VSLIDEUP_VL
def G_VSLIDEUP_VL : RISCVGenericInstruction {
  let OutOperandList = (outs type0:$dst);
  let InOperandList = (ins type0:$merge, type0:$vec, type1:$idx, type2:$mask,
                       type3:$vl, type4:$policy);
  let hasSideEffects = false;
}
def : GINodeEquiv<G_VSLIDEUP_VL, riscv_slideup_vl>;

