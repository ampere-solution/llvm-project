@ Check a single .fpu directive.

@ RUN: llvm-mc -triple arm-eabi -filetype obj %s \
@ RUN:   | llvm-readobj --arch-specific - \
@ RUN:   | FileCheck %s -check-prefix CHECK-ATTR

  .fpu vfp3

@ CHECK-ATTR: FileAttributes {
@ CHECK-ATTR:   Attribute {
@ CHECK-ATTR:     TagName: FP_arch
@ CHECK-ATTR:     Description: VFPv3
@ CHECK-ATTR:   }
@ CHECK-ATTR: }
