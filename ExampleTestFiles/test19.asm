.data                         # BEGIN Data Segment
cruxdata.x: .space 60
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
# Reserve space (16b) for function local vars.
subu $sp, $sp, 16
				# Function body begins here.
				# Assignment beginns.
				# Handle destination.
				# Taking address of variable canary_begin.
				# Calculating address to var from framepointer to symbol canary_begin
addi $t0, $fp, -12
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Handle source.
				# LiteralInt == 0
li $t0, 0
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
				# Taking address of variable canary_end.
				# Calculating address to var from framepointer to symbol canary_end
addi $t0, $fp, -16
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Handle source.
				# LiteralInt == 0
li $t0, 0
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
				# Taking address of variable outer.
				# Calculating address to var from framepointer to symbol outer
addi $t0, $fp, -20
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Handle source.
				# LiteralInt == 4
li $t0, 4
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
				# Taking address of variable inner.
				# Calculating address to var from framepointer to symbol inner
addi $t0, $fp, -24
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
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
				# While loop beginns here.
				# condLabel = label.1
				# joinLabel = label.2
				# Evaluate while-condition.
label.1:
				# Comparsion beginns here.
				# Evaluate LHS.
				# Dereferencing address. Now getting address.
				# Taking address of variable outer.
				# Calculating address to var from framepointer to symbol outer
addi $t0, $fp, -20
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
				# LiteralInt == 0
li $t0, 0
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Popping off RHS value
				# Popping int to reg $t1
lw $t1, 0($sp)
addiu $sp, $sp, 4
				# Popping off LHS value
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
				# $t0 >= $t1
sge $t2, $t0, $t1
				# Pushing comparsion outcome.
				# Pushing int register ($t2) to stack.
subu $sp, $sp, 4
sw $t2, 0($sp)
				# done -> Comparsion beginns here.
				# done -> Evaluate while-condition.
				# Pop off condition.
				# Popping int to reg $t7
lw $t7, 0($sp)
addiu $sp, $sp, 4
beqz $t7, label.2
				# While body  beginns.
				# While loop beginns here.
				# condLabel = label.3
				# joinLabel = label.4
				# Evaluate while-condition.
label.3:
				# Comparsion beginns here.
				# Evaluate LHS.
				# Dereferencing address. Now getting address.
				# Taking address of variable inner.
				# Calculating address to var from framepointer to symbol inner
addi $t0, $fp, -24
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
				# LiteralInt == 0
li $t0, 0
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Popping off RHS value
				# Popping int to reg $t1
lw $t1, 0($sp)
addiu $sp, $sp, 4
				# Popping off LHS value
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
				# $t0 >= $t1
sge $t2, $t0, $t1
				# Pushing comparsion outcome.
				# Pushing int register ($t2) to stack.
subu $sp, $sp, 4
sw $t2, 0($sp)
				# done -> Comparsion beginns here.
				# done -> Evaluate while-condition.
				# Pop off condition.
				# Popping int to reg $t7
lw $t7, 0($sp)
addiu $sp, $sp, 4
beqz $t7, label.4
				# While body  beginns.
				# Assignment beginns.
				# Handle destination.
				# Taking index of expression.
				# Taking index of expression.
				# Taking address of variable x.
				# Consulting parent scope for address to symbolx
la $t0, cruxdata.x
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Dereferencing address. Now getting address.
				# Taking address of variable inner.
				# Calculating address to var from framepointer to symbol inner
addi $t0, $fp, -24
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
				# Popping amount. 
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
				# Popping base address.
				# Popping int to reg $t1
lw $t1, 0($sp)
addiu $sp, $sp, 4
				# Calculate base + offset
li $t2, 20
mul $t3, $t0, $t2
add $t4, $t1, $t3
				# Pushing int register ($t4) to stack.
subu $sp, $sp, 4
sw $t4, 0($sp)
				# Dereferencing address. Now getting address.
				# Taking address of variable outer.
				# Calculating address to var from framepointer to symbol outer
addi $t0, $fp, -20
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
				# Addition beginns.
				# Visit left hand side.
				# Addition beginns.
				# Visit left hand side.
				# Multiplication beginns.
				# Visit left hand side.
				# Dereferencing address. Now getting address.
				# Taking address of variable inner.
				# Calculating address to var from framepointer to symbol inner
addi $t0, $fp, -24
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
				# Visit right hand side.
				# LiteralInt == 1000
li $t0, 1000
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Popping int to reg $t1
lw $t1, 0($sp)
addiu $sp, $sp, 4
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
mul $t3, $t0, $t1
				# Store mul result.
				# Pushing int register ($t3) to stack.
subu $sp, $sp, 4
sw $t3, 0($sp)
				# done -> Multiplication beginns.
				# Visit right hand side.
				# Multiplication beginns.
				# Visit left hand side.
				# Dereferencing address. Now getting address.
				# Taking address of variable outer.
				# Calculating address to var from framepointer to symbol outer
addi $t0, $fp, -20
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
				# Visit right hand side.
				# LiteralInt == 100
li $t0, 100
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Popping int to reg $t1
lw $t1, 0($sp)
addiu $sp, $sp, 4
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
mul $t3, $t0, $t1
				# Store mul result.
				# Pushing int register ($t3) to stack.
subu $sp, $sp, 4
sw $t3, 0($sp)
				# done -> Multiplication beginns.
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
				# Visit right hand side.
				# LiteralInt == 99
li $t0, 99
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
				# Taking address of variable inner.
				# Calculating address to var from framepointer to symbol inner
addi $t0, $fp, -24
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Handle source.
				# Substract beginns.
				# Visit left hand side.
				# Dereferencing address. Now getting address.
				# Taking address of variable inner.
				# Calculating address to var from framepointer to symbol inner
addi $t0, $fp, -24
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
b label.3
				# done -> While body  beginns.
label.4:
				# done -> While loop beginns here.
				# Assignment beginns.
				# Handle destination.
				# Taking address of variable inner.
				# Calculating address to var from framepointer to symbol inner
addi $t0, $fp, -24
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
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
				# Taking address of variable outer.
				# Calculating address to var from framepointer to symbol outer
addi $t0, $fp, -20
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Handle source.
				# Substract beginns.
				# Visit left hand side.
				# Dereferencing address. Now getting address.
				# Taking address of variable outer.
				# Calculating address to var from framepointer to symbol outer
addi $t0, $fp, -20
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
b label.1
				# done -> While body  beginns.
label.2:
				# done -> While loop beginns here.
				# Assignment beginns.
				# Handle destination.
				# Taking address of variable inner.
				# Calculating address to var from framepointer to symbol inner
addi $t0, $fp, -24
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Handle source.
				# LiteralInt == 0
li $t0, 0
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
				# Taking address of variable outer.
				# Calculating address to var from framepointer to symbol outer
addi $t0, $fp, -20
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Handle source.
				# LiteralInt == 0
li $t0, 0
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
				# While loop beginns here.
				# condLabel = label.5
				# joinLabel = label.6
				# Evaluate while-condition.
label.5:
				# Comparsion beginns here.
				# Evaluate LHS.
				# Dereferencing address. Now getting address.
				# Taking address of variable outer.
				# Calculating address to var from framepointer to symbol outer
addi $t0, $fp, -20
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
				# LiteralInt == 5
li $t0, 5
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
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
				# done -> Evaluate while-condition.
				# Pop off condition.
				# Popping int to reg $t7
lw $t7, 0($sp)
addiu $sp, $sp, 4
beqz $t7, label.6
				# While body  beginns.
				# While loop beginns here.
				# condLabel = label.7
				# joinLabel = label.8
				# Evaluate while-condition.
label.7:
				# Comparsion beginns here.
				# Evaluate LHS.
				# Dereferencing address. Now getting address.
				# Taking address of variable inner.
				# Calculating address to var from framepointer to symbol inner
addi $t0, $fp, -24
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
				# LiteralInt == 3
li $t0, 3
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
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
				# done -> Evaluate while-condition.
				# Pop off condition.
				# Popping int to reg $t7
lw $t7, 0($sp)
addiu $sp, $sp, 4
beqz $t7, label.8
				# While body  beginns.
				# Caller Setup
				# Begin evaluate function arguments.
				# Dereferencing address. Now getting address.
				# Taking index of expression.
				# Taking index of expression.
				# Taking address of variable x.
				# Consulting parent scope for address to symbolx
la $t0, cruxdata.x
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Dereferencing address. Now getting address.
				# Taking address of variable inner.
				# Calculating address to var from framepointer to symbol inner
addi $t0, $fp, -24
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
				# Popping amount. 
				# Popping int to reg $t0
lw $t0, 0($sp)
addiu $sp, $sp, 4
				# Popping base address.
				# Popping int to reg $t1
lw $t1, 0($sp)
addiu $sp, $sp, 4
				# Calculate base + offset
li $t2, 20
mul $t3, $t0, $t2
add $t4, $t1, $t3
				# Pushing int register ($t4) to stack.
subu $sp, $sp, 4
sw $t4, 0($sp)
				# Dereferencing address. Now getting address.
				# Taking address of variable outer.
				# Calculating address to var from framepointer to symbol outer
addi $t0, $fp, -20
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
				# Assignment beginns.
				# Handle destination.
				# Taking address of variable inner.
				# Calculating address to var from framepointer to symbol inner
addi $t0, $fp, -24
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Handle source.
				# Addition beginns.
				# Visit left hand side.
				# Dereferencing address. Now getting address.
				# Taking address of variable inner.
				# Calculating address to var from framepointer to symbol inner
addi $t0, $fp, -24
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
add $t2, $t0, $t1
				# Store addition result.
				# Pushing int register ($t2) to stack.
subu $sp, $sp, 4
sw $t2, 0($sp)
				# done -> Addition beginns.
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
b label.7
				# done -> While body  beginns.
label.8:
				# done -> While loop beginns here.
				# Caller Setup
				# Begin evaluate function arguments.
				# done -> Begin evaluate function arguments.
jal func.println
				# Caller Teardown.
				# Assignment beginns.
				# Handle destination.
				# Taking address of variable inner.
				# Calculating address to var from framepointer to symbol inner
addi $t0, $fp, -24
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Handle source.
				# LiteralInt == 0
li $t0, 0
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
				# Taking address of variable outer.
				# Calculating address to var from framepointer to symbol outer
addi $t0, $fp, -20
				# Pushing int register ($t0) to stack.
subu $sp, $sp, 4
sw $t0, 0($sp)
				# Handle source.
				# Addition beginns.
				# Visit left hand side.
				# Dereferencing address. Now getting address.
				# Taking address of variable outer.
				# Calculating address to var from framepointer to symbol outer
addi $t0, $fp, -20
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
add $t2, $t0, $t1
				# Store addition result.
				# Pushing int register ($t2) to stack.
subu $sp, $sp, 4
sw $t2, 0($sp)
				# done -> Addition beginns.
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
b label.5
				# done -> While body  beginns.
label.6:
				# done -> While loop beginns here.
				# Caller Setup
				# Begin evaluate function arguments.
				# Dereferencing address. Now getting address.
				# Taking address of variable canary_begin.
				# Calculating address to var from framepointer to symbol canary_begin
addi $t0, $fp, -12
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
				# done -> Begin evaluate function arguments.
jal func.printInt
				# Caller Teardown.
				# Cleaning up used func args.
addi $sp, $sp, 4
				# Caller Setup
				# Begin evaluate function arguments.
				# Dereferencing address. Now getting address.
				# Taking address of variable canary_end.
				# Calculating address to var from framepointer to symbol canary_end
addi $t0, $fp, -16
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
				# done -> Begin evaluate function arguments.
jal func.printInt
				# Caller Teardown.
				# Cleaning up used func args.
addi $sp, $sp, 4
				# done -> Function body begins here.
label.0:
				# Function (Callee) Epilogue.
				# Erasing function local variables.
addu $sp, $sp, 16
li $v0, 10
syscall
                              # END Code Segment
