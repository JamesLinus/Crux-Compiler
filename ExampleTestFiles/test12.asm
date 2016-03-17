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
main:
				# Function (Callee) Prologue.
				# Bookkeeping.
subu $sp, $sp, 8
sw $fp, 0($sp)
sw $ra, 4($sp)
addi $fp, $sp, 8
				# Function body begins here.
				# IfElseBranch beginns here
				# elseLabel = label.1
				# joinLabel = label.2
				# Evaluate if-condition.
				# Literalbool == 0
li $t0, 0
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# done -> Evaluate if expression.
				# Pop off condition.
				# Popping int to reg $t7
lw $t7, 0($sp)
addiu $sp, $sp, 4
beqz $t7, label.1
				# Then branch beginns.
				# Caller Setup
				# Begin evaluate function arguments.
				# LiteralInt == 1
li $t0, 1
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# done -> Begin evaluate function arguments.
jal func.printInt
				# Caller Teardown.
				# Cleaning up used func args.
addi $sp, $sp, 4
b label.2
				# done -> Then branch beginns.
				# Else branch beginns.
label.1:
				# Caller Setup
				# Begin evaluate function arguments.
				# LiteralInt == 0
li $t0, 0
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# done -> Begin evaluate function arguments.
jal func.printInt
				# Caller Teardown.
				# Cleaning up used func args.
addi $sp, $sp, 4
				# done -> Else branch beginns.
label.2:
				# done -> IfElseBranch beginns here
				# Caller Setup
				# Begin evaluate function arguments.
				# Substract beginns.
				# Visit left hand side.
				# LiteralInt == 0
li $t0, 0
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Visit right hand side.
				# LiteralInt == 1
li $t0, 1
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Popping int to reg $t1
lw $t1, 0($sp)
addiu $sp, $sp, 4
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
sub $t3, $t0, $t1
				# Store substraction result.
				# Pushing int register ($t3) to stack.
subu $sp, $sp, 4
sw $t3, 0($sp)
				# done -> Substract beginns.
				# done -> Begin evaluate function arguments.
jal func.printInt
				# Caller Teardown.
				# Cleaning up used func args.
addi $sp, $sp, 4
				# done -> Function body begins here.
label.0:
				# Function (Callee) Epilogue.
li $v0, 10
syscall
                              # END Code Segment
