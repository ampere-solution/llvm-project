// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --check-globals --global-value-regex ".*"
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -emit-llvm -o - %s | FileCheck %s

//.
// CHECK: @__aarch64_cpu_features = external dso_local global { i64 }
//.
// CHECK-LABEL: @main(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[RETVAL:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store i32 0, ptr [[RETVAL]], align 4
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @__aarch64_cpu_features, align 8
// CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[TMP0]], 70368744177664
// CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i64 [[TMP1]], 70368744177664
// CHECK-NEXT:    [[TMP3:%.*]] = and i1 true, [[TMP2]]
// CHECK-NEXT:    br i1 [[TMP3]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
// CHECK:       if.then:
// CHECK-NEXT:    store i32 1, ptr [[RETVAL]], align 4
// CHECK-NEXT:    br label [[RETURN:%.*]]
// CHECK:       if.end:
// CHECK-NEXT:    [[TMP4:%.*]] = load i64, ptr @__aarch64_cpu_features, align 8
// CHECK-NEXT:    [[TMP5:%.*]] = and i64 [[TMP4]], 17867063951360
// CHECK-NEXT:    [[TMP6:%.*]] = icmp eq i64 [[TMP5]], 17867063951360
// CHECK-NEXT:    [[TMP7:%.*]] = and i1 true, [[TMP6]]
// CHECK-NEXT:    br i1 [[TMP7]], label [[IF_THEN1:%.*]], label [[IF_END2:%.*]]
// CHECK:       if.then1:
// CHECK-NEXT:    store i32 2, ptr [[RETVAL]], align 4
// CHECK-NEXT:    br label [[RETURN]]
// CHECK:       if.end2:
// CHECK-NEXT:    [[TMP8:%.*]] = load i64, ptr @__aarch64_cpu_features, align 8
// CHECK-NEXT:    [[TMP9:%.*]] = and i64 [[TMP8]], 171136785840078848
// CHECK-NEXT:    [[TMP10:%.*]] = icmp eq i64 [[TMP9]], 171136785840078848
// CHECK-NEXT:    [[TMP11:%.*]] = and i1 true, [[TMP10]]
// CHECK-NEXT:    br i1 [[TMP11]], label [[IF_THEN3:%.*]], label [[IF_END4:%.*]]
// CHECK:       if.then3:
// CHECK-NEXT:    store i32 3, ptr [[RETVAL]], align 4
// CHECK-NEXT:    br label [[RETURN]]
// CHECK:       if.end4:
// CHECK-NEXT:    br i1 false, label [[IF_THEN5:%.*]], label [[IF_END6:%.*]]
// CHECK:       if.then5:
// CHECK-NEXT:    store i32 4, ptr [[RETVAL]], align 4
// CHECK-NEXT:    br label [[RETURN]]
// CHECK:       if.end6:
// CHECK-NEXT:    store i32 0, ptr [[RETVAL]], align 4
// CHECK-NEXT:    br label [[RETURN]]
// CHECK:       return:
// CHECK-NEXT:    [[TMP12:%.*]] = load i32, ptr [[RETVAL]], align 4
// CHECK-NEXT:    ret i32 [[TMP12]]
//
int main(void) {
  if (__builtin_cpu_supports("sb"))
    return 1;

  if (__builtin_cpu_supports("sve2-pmull128+memtag"))
    return 2;

  if (__builtin_cpu_supports("sme2+ls64+wfxt"))
    return 3;

  if (__builtin_cpu_supports("avx2"))
    return 4;

  return 0;
}
//.
// CHECK: [[META0:![0-9]+]] = !{i32 1, !"wchar_size", i32 4}
// CHECK: [[META1:![0-9]+]] = !{!"{{.*}}clang version {{.*}}"}
//.