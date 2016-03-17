.data                         # BEGIN Data Segment
cruxdata.a: .space 12
cruxdata.b: .space 40
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
				# Assignment beginns.
				# Handle destination.
				# Taking index of expression.
				# Taking address of variable b.
				# Consulting parent scope for address to symbolb
la $t0, cruxdata.b
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# LiteralInt == 5
li $t0, 5
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Popping amount. 
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
				# Popping base address.
				# Popping int to reg $t1
lw $t1, 0($sp)
addiu $sp, $sp, 4
				# Calculate base + offset
li $t2, 4
mul $t3, $t0, $t2
add $t4, $t1, $t3
				# Pushing int register ($t4) to stack.
subu $sp, $sp, 4
sw $t4, 0($sp)
				# Handle source.
				# LiteralInt == 2
li $t0, 2
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Popping off value in asignmnet.
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
				# Popping off destination address in assigmnet.
				# Popping int to reg $t1
lw $t1, 0($sp)
addiu $sp, $sp, 4
				# Final assignment.
sw $t0, 0($t1)
				# done -> Assignment beginns.
				# Assignment beginns.
				# Handle destination.
				# Taking index of expression.
				# Taking address of variable a.
				# Consulting parent scope for address to symbola
la $t0, cruxdata.a
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Dereferencing address. Now getting address.
				# Taking index of expression.
				# Taking address of variable b.
				# Consulting parent scope for address to symbolb
la $t0, cruxdata.b
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# LiteralInt == 5
li $t0, 5
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Popping amount. 
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
				# Popping base address.
				# Popping int to reg $t1
lw $t1, 0($sp)
addiu $sp, $sp, 4
				# Calculate base + offset
li $t2, 4
mul $t3, $t0, $t2
add $t4, $t1, $t3
				# Pushing int register ($t4) to stack.
subu $sp, $sp, 4
sw $t4, 0($sp)
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
				# Load value at the found address.
lw $t1, 0($t0)
				# Pushing int register ($t1) to stack.
subu $sp, $sp, 4
sw $t1, 0($sp)
				# Popping amount. 
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
				# Popping base address.
				# Popping int to reg $t1
lw $t1, 0($sp)
addiu $sp, $sp, 4
				# Calculate base + offset
li $t2, 4
mul $t3, $t0, $t2
add $t4, $t1, $t3
				# Pushing int register ($t4) to stack.
subu $sp, $sp, 4
sw $t4, 0($sp)
				# Handle source.
				# LiteralInt == 100
li $t0, 100
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Popping off value in asignmnet.
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
				# Popping off destination address in assigmnet.
				# Popping int to reg $t1
lw $t1, 0($sp)
addiu $sp, $sp, 4
				# Final assignment.
sw $t0, 0($t1)
				# done -> Assignment beginns.
				# Caller Setup
				# Begin evaluate function arguments.
				# Dereferencing address. Now getting address.
				# Taking index of expression.
				# Taking address of variable a.
				# Consulting parent scope for address to symbola
la $t0, cruxdata.a
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# LiteralInt == 2
li $t0, 2
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Popping amount. 
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
				# Popping base address.
				# Popping int to reg $t1
lw $t1, 0($sp)
addiu $sp, $sp, 4
				# Calculate base + offset
li $t2, 4
mul $t3, $t0, $t2
add $t4, $t1, $t3
				# Pushing int register ($t4) to stack.
subu $sp, $sp, 4
sw $t4, 0($sp)
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
				# Load value at the found address.
lw $t1, 0($t0)
				# Pushing int register ($t1) to stack.
subu $sp, $sp, 4
sw $t1, 0($sp)
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
