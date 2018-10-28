# IF-THEN-ELSE

## Introduction

IF-THEN-ELSE statements are very helpful conditional statements that allow branching of the code as required. For example, when a conditional statement is evaluated, if the answer is true a set of instructions can be evaluated else another set of instructions can be evaluated.
```ITE <cond>
A
B
```
means that if `cond` is true `A` is executed, else `B` is executed. One can also observe that if `A` and `B` instructions themselves come with conditional execution then there will be no need of `ITE <cond>`. As follows
```A <cond>
B <cond>
```
Similarly, in the case of normal 32 bit (or 64 bit) ARM code, the ITxyz instruction is a pseudo instruction and does not generate any code. The following statements A, B, C etc. themselves contain the condition, if satisfied will execute that instruction. It is also necessary that the conditions in the two 'Then' and 'Else' blocks must be mutually exclusive and exhaustive. e.g. not equal and equal. This is the exact implementation of a IF-THEN-ELSE, without IT instruction. Hence the presence and absence of ITxyz does not impact this kind of ARM code.
ITxyz instructions are helpful only in Thumb instructions (16-bit) where there are not enough opcodes to represent every possible combination of instruction with conditions, hence an ITxyz instruction is used to store the condition in a register which will be used to decide which instructions are going to be executed.

## Solution
The code given in the assignment produces errors because every instruction must be accompanied by a condition in the ITxyz block. This is because the ARM code will not use the IT instruction but the individual conditions in the instruction to decide whether to execute it or not. The error goes away when they are put back.