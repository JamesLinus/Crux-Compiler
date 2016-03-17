.data                         # BEGIN Data Segment
data.newline:      .asciiz       "\n"
data.floatquery:   .asciiz       "float?"
data.intquery:     .asciiz       "int?"
data.trueString:   .asciiz       "true"
data.falseString:  .asciiz       "false"
                              # END Data Segment
.text                         # BEGIN Code Segment
j main
func.printBool:
lw $a0, 0($sp)
beqz $a0, label.printBool.loadFalse
la $a0, data.trueString
j label.printBool.join
label.printBool.loadFalse:
la $a0, data.falseString
label.printBool.join:
li   $v0, 4
syscall
jr $ra
func.printFloat:
l.s  $f12, 0($sp)
li   $v0,  2
syscall
jr $ra
func.printInt:
lw   $a0, 0($sp)
li   $v0, 1
syscall
jr $ra
func.println:
la   $a0, data.newline
li   $v0, 4
syscall
jr $ra
func.readFloat:
la   $a0, data.floatquery
li   $v0, 4
syscall
li   $v0, 6
syscall
mfc1 $v0, $f0
jr $ra
func.readInt:
la   $a0, data.intquery
li   $v0, 4
syscall
li   $v0, 5
syscall
jr $ra
.text                         # BEGIN Crux Program
				# Function definition  starts here.
				# Join label for function is label.0
				# Register argument symbols.
				# done -> Register argument symbols.
cruxfunc.blt:
				# Function (Callee) Prologue.
				# Bookkeeping.
subu $sp, $sp, 8
sw $fp, 0($sp)
sw $ra, 4($sp)
addi $fp, $sp, 8
				# Function body begins here.
				# Begin return func value.
				# Comparsion beginns here.
				# Evaluate LHS.
				# Dereferencing address. Now getting address.
				# Taking address of variable a.
				# Calculating address to funcargumnet from framepointer to symbol a
addi $t0, $fp, 4
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
				# Load value at the found address.
lw $t1, 0($t0)
				# Pushing int register ($t1) to stack.
subu $sp, $sp, 4
sw $t1, 0($sp)
				# Evaluate RHS.
				# Dereferencing address. Now getting address.
				# Taking address of variable b.
				# Calculating address to funcargumnet from framepointer to symbol b
addi $t0, $fp, 0
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
				# Load value at the found address.
lw $t1, 0($t0)
				# Pushing int register ($t1) to stack.
subu $sp, $sp, 4
sw $t1, 0($sp)
				# Popping off RHS value
				# Popping int to reg $t1
lw $t1, 0($sp)
addiu $sp, $sp, 4
				# Popping off LHS value
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
				# $t0 < $t1
slt $t2, $t0, $t1
				# Pushing comparsion outcome.
				# Pushing int register ($t2) to stack.
subu $sp, $sp, 4
sw $t2, 0($sp)
				# done -> Comparsion beginns here.
				# done -> Begin return func value.
				# Jumping to end of function.
b label.0
				# done -> Function body begins here.
label.0:
				# Storing return value.
				# Popping int to reg $v0
lw $v0, 0($sp)
addiu $sp, $sp, 4
				# Function (Callee) Epilogue.
				# Restore caller's state.
lw $ra, 4($sp)
lw $fp, 0($sp)
addu $sp, $sp, 8
jr $ra
				# Function definition  starts here.
				# Join label for function is label.1
				# Register argument symbols.
				# done -> Register argument symbols.
main:
				# Function (Callee) Prologue.
				# Bookkeeping.
subu $sp, $sp, 8
sw $fp, 0($sp)
sw $ra, 4($sp)
addi $fp, $sp, 8
				# Function body begins here.
				# Caller Setup
				# Begin evaluate function arguments.
				# Caller Setup
				# Begin evaluate function arguments.
				# LiteralInt == 1
li $t0, 1
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# LiteralInt == 2
li $t0, 2
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# done -> Begin evaluate function arguments.
jal cruxfunc.blt
				# Caller Teardown.
				# Cleaning up used func args.
addi $sp, $sp, 8
				# Saving function return value at $v0 on the stack.
subu $sp, $sp, 4
sw $v0, 0($sp)
				# done -> Begin evaluate function arguments.
jal func.printBool
				# Caller Teardown.
				# Cleaning up used func args.
addi $sp, $sp, 4
				# Caller Setup
				# Begin evaluate function arguments.
				# done -> Begin evaluate function arguments.
jal func.println
				# Caller Teardown.
				# Caller Setup
				# Begin evaluate function arguments.
				# Caller Setup
				# Begin evaluate function arguments.
				# LiteralInt == 2
li $t0, 2
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# LiteralInt == 1
li $t0, 1
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# done -> Begin evaluate function arguments.
jal cruxfunc.blt
				# Caller Teardown.
				# Cleaning up used func args.
addi $sp, $sp, 8
				# Saving function return value at $v0 on the stack.
subu $sp, $sp, 4
sw $v0, 0($sp)
				# done -> Begin evaluate function arguments.
jal func.printBool
				# Caller Teardown.
				# Cleaning up used func args.
addi $sp, $sp, 4
				# Caller Setup
				# Begin evaluate function arguments.
				# done -> Begin evaluate function arguments.
jal func.println
				# Caller Teardown.
				# Caller Setup
				# Begin evaluate function arguments.
				# Caller Setup
				# Begin evaluate function arguments.
				# LiteralInt == 1
li $t0, 1
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# LiteralInt == 1
li $t0, 1
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# done -> Begin evaluate function arguments.
jal cruxfunc.blt
				# Caller Teardown.
				# Cleaning up used func args.
addi $sp, $sp, 8
				# Saving function return value at $v0 on the stack.
subu $sp, $sp, 4
sw $v0, 0($sp)
				# done -> Begin evaluate function arguments.
jal func.printBool
				# Caller Teardown.
				# Cleaning up used func args.
addi $sp, $sp, 4
				# done -> Function body begins here.
label.1:
				# Function (Callee) Epilogue.
li $v0, 10
syscall
                              # END Code Segment
