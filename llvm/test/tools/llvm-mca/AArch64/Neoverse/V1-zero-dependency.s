# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=aarch64 -mcpu=neoverse-v1 --timeline --timeline-max-iterations=4 < %s | FileCheck %s

mov x0, x1
cmp x0, #4

# CHECK:      Iterations:        100
# CHECK-NEXT: Instructions:      200
# CHECK-NEXT: Total Cycles:      54
# CHECK-NEXT: Total uOps:        200

# CHECK:      Dispatch Width:    15
# CHECK-NEXT: uOps Per Cycle:    3.70
# CHECK-NEXT: IPC:               3.70
# CHECK-NEXT: Block RThroughput: 0.3

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     0.25                        mov	x0, x1
# CHECK-NEXT:  1      1     0.33                        cmp	x0, #4

# CHECK:      Resources:
# CHECK-NEXT: [0.0] - V1UnitB
# CHECK-NEXT: [0.1] - V1UnitB
# CHECK-NEXT: [1.0] - V1UnitD
# CHECK-NEXT: [1.1] - V1UnitD
# CHECK-NEXT: [2]   - V1UnitL2
# CHECK-NEXT: [3.0] - V1UnitL01
# CHECK-NEXT: [3.1] - V1UnitL01
# CHECK-NEXT: [4]   - V1UnitM0
# CHECK-NEXT: [5]   - V1UnitM1
# CHECK-NEXT: [6.0] - V1UnitS
# CHECK-NEXT: [6.1] - V1UnitS
# CHECK-NEXT: [7]   - V1UnitV0
# CHECK-NEXT: [8]   - V1UnitV1
# CHECK-NEXT: [9]   - V1UnitV2
# CHECK-NEXT: [10]  - V1UnitV3

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0.0]  [0.1]  [1.0]  [1.1]  [2]    [3.0]  [3.1]  [4]    [5]    [6.0]  [6.1]  [7]    [8]    [9]    [10]
# CHECK-NEXT:  -      -      -      -      -      -      -     0.50   0.50   0.50   0.50    -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0.0]  [0.1]  [1.0]  [1.1]  [2]    [3.0]  [3.1]  [4]    [5]    [6.0]  [6.1]  [7]    [8]    [9]    [10]   Instructions:
# CHECK-NEXT:  -      -      -      -      -      -      -     0.48   0.50   0.01   0.01    -      -      -      -     mov	x0, x1
# CHECK-NEXT:  -      -      -      -      -      -      -     0.02    -     0.49   0.49    -      -      -      -     cmp	x0, #4

# CHECK:      Timeline view:
# CHECK-NEXT: Index     012345

# CHECK:      [0,0]     DeER .   mov	x0, x1
# CHECK-NEXT: [0,1]     D=eER.   cmp	x0, #4
# CHECK-NEXT: [1,0]     DeE-R.   mov	x0, x1
# CHECK-NEXT: [1,1]     D=eER.   cmp	x0, #4
# CHECK-NEXT: [2,0]     DeE-R.   mov	x0, x1
# CHECK-NEXT: [2,1]     D=eER.   cmp	x0, #4
# CHECK-NEXT: [3,0]     DeE-R.   mov	x0, x1
# CHECK-NEXT: [3,1]     D==eER   cmp	x0, #4

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     4     1.0    1.0    0.8       mov	x0, x1
# CHECK-NEXT: 1.     4     2.3    0.3    0.0       cmp	x0, #4
# CHECK-NEXT:        4     1.6    0.6    0.4       <total>