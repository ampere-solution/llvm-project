; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt %s -passes=instcombine -S -mtriple=i386-pc-windows-msvc | FileCheck %s --check-prefixes=MSVC19

define double @fdim_double() {
; MSVC19-LABEL: define double @fdim_double() {
; MSVC19-NEXT:    ret double 2.500000e+00
;
  %dim = call double @fdim(double 10.5, double 8.0)
  ret double %dim
}

;fdimf is not supported by windows
define float @fdim_float() {
; MSVC19-LABEL: define float @fdim_float() {
; MSVC19-NEXT:    [[DIM:%.*]] = call float @fdimf(float 1.500000e+00, float 8.000000e+00)
; MSVC19-NEXT:    ret float [[DIM]]
;
  %dim = call float @fdimf(float 1.500000e+00, float 8.0)
  ret float %dim
}

;fdiml is not supported by windows
define fp128 @fdim_long() {
; MSVC19-LABEL: define fp128 @fdim_long() {
; MSVC19-NEXT:    [[DIM:%.*]] = call fp128 @fdiml(fp128 0xL00000000000000000000000000000000, fp128 0xL00000000000000000000000000000000)
; MSVC19-NEXT:    ret fp128 [[DIM]]
;
  %dim = call fp128 @fdiml(fp128  0xL00000000000000000000000000000000 , fp128 0xL00000000000000000000000000000000)
  ret fp128 %dim
}

declare double @fdim(double, double) #0
declare float @fdimf(float, float) #0
declare fp128 @fdiml(fp128, fp128) #0

attributes #0 = { memory(none) }