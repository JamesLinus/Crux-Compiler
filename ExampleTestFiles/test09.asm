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
				# Caller Setup
				# Begin evaluate function arguments.
				# Addition beginns.
				# Visit left hand side.
				# LiteralInt == 1
li $t0, 1
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Visit right hand side.
				# LiteralInt == 2
li $t0, 2
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Popping int to reg $t1
lw $t1, 0($sp)
addiu $sp, $sp, 4
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
add $t2, $t0, $t1
				# Store addition result.
				# Pushing int register ($t2) to stack.
subu $sp, $sp, 4
sw $t2, 0($sp)
				# done -> Addition beginns.
				# done -> Begin evaluate function arguments.
jal func.printInt
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
				# Substract beginns.
				# Visit left hand side.
				# LiteralFloat == 0.5
li.s $f0, 0.5
				# Pushing float register ($f0) to stack.
subu $sp, $sp, 4
swc1 $f0, 0($sp)
				# Visit right hand side.
				# LiteralFloat == 0.125
li.s $f0, 0.125
				# Pushing float register ($f0) to stack.
subu $sp, $sp, 4
swc1 $f0, 0($sp)
				# Popping float to reg $f2
lwc1 $f2, 0($sp)
addiu $sp, $sp, 4
				# Popping float to reg $f0
lwc1 $f0, 0($sp)
addiu $sp, $sp, 4
sub.s $f4, $f0, $f2
				# Store substraction result.
				# Pushing float register ($f4) to stack.
subu $sp, $sp, 4
swc1 $f4, 0($sp)
				# done -> Substract beginns.
				# done -> Begin evaluate function arguments.
jal func.printFloat
				# Caller Teardown.
				# Cleaning up used func args.
addi $sp, $sp, 4
				# done -> Function body begins here.
label.0:
				# Function (Callee) Epilogue.
li $v0, 10
syscall
                              # END Code Segment
