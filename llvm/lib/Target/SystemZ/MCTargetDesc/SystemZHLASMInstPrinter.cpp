//=- SystemZHLASMInstPrinter.cpp - Convert SystemZ MCInst to HLASM assembly -=//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "SystemZHLASMInstPrinter.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCRegister.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

#define DEBUG_TYPE "asm-printer"

#include "SystemZGenHLASMAsmWriter.inc"

void SystemZHLASMInstPrinter::printFormattedRegName(const MCAsmInfo *MAI,
                                                    MCRegister Reg,
                                                    raw_ostream &O) const {
  const char *RegName = getRegisterName(Reg);
  // Skip register prefix so that only register number is left
  assert(isalpha(RegName[0]) && isdigit(RegName[1]));
  markup(O, Markup::Register) << (RegName + 1);
}

void SystemZHLASMInstPrinter::printInst(const MCInst *MI, uint64_t Address,
                                        StringRef Annot,
                                        const MCSubtargetInfo &STI,
                                        raw_ostream &O) {
  printInstruction(MI, Address, O);
  printAnnotation(O, Annot);
}