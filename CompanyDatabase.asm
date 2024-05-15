.extern DataAddress 5000
.data
	Name: .space 24
	NullChar: .byte '\0'
	printNextline: .asciiz "\n"
	printWelcome: .asciiz "\t\t.....Welcome to Our Software Company.....\n"
	printComExplain: .asciiz "\tA - Adding a new employee\n \tP - printing the data of employees in preorder \n \tI - printing the data of employees in inorder \n \tO - printing the data of employees in postorder \n \tE - the company has employees or not \n \tC - closing the company and fired all employees t\n \tD - fired a person from the company  \n \tZ - Get number of employees in company\n \tS - Search about an employee \n \tQ - Exit and quit the program\n\n"
	printCommand: .asciiz "Please enter a command (A,I,P,O,E,C,D,Z,S,Q): "
	printACommand: .asciiz " - Adding a new employee...\n"
	printCCommand: .asciiz " - Close the company ...\n"
	printPCommand: .asciiz " - printing the data of employees in preorder...\n"
	printICommand: .asciiz " - printing the data of employees in inorder...\n"
	printOCommand :  .asciiz " - printing the data of employees in postorder...\n"
	printZCommand:  .asciiz " - Get number of employees in company ...\n"
	printECommand:  .asciiz " - Check if there is employees or not ...\n"
	printSCommand: .asciiz " - Search about an employee  ...\n"
	prinDCommand :.asciiz " -fired a person from the company...\n"
	prinQCommand :.asciiz " -program end...\n"
	message: .asciiz "enter the ID of the person you want to search\n"
	DeleteMessage : .asciiz "enter the ID of the person you want to delete\n"
	notDeleteMessage : .asciiz "this employee is not exist in our company\n"
	EmptyMessage : .asciiz "This company has no employees\n"
	NotEmptyMessage : .asciiz "This company has employees\n"
	printnotFound:.asciiz "this employee is not exist in our company\n"
	printFound:.asciiz " HE/SHE is an employee in the  company ...."
####################################################################################################
	inOrder_message: .asciiz "inOrder traversal : "
	preOrder_message: .asciiz "preOrder traversal : "
	postOrder_message: .asciiz "postOrder traversal : "
	format: .asciiz " "
	line: .asciiz "\n"
	RepeatMsg: .asciiz "this employees is already work with us..... \n"
	WrongInput: .asciiz "Wrong Input"
	ID_str: .asciiz "ID : "
	Age_str: .asciiz "Age : "
	Salary_str: .asciiz "Salary : "
	Name_str: .asciiz "Name : "
	EnterID : .asciiz "Enter ID : "
	EnterAge : .asciiz "Enter Age : "
	EnterSalary : .asciiz "Enter Salary : "
	EnterName : .asciiz "Enter Name : "
	Heap_Start: .word 268697600
	Age: .word 0
	Salary: .float 0.0
	Zero_Frac: .float 0.0
	Name_Negative: .byte '\0'
.text

###############################################################
# Main code 
# Loop to get the commands from user and perform commands
###############################################################

# main
# Prints welcome line and Command Explain line
main:
	move $s7 , $zero
	li $v0, 4			# Print welcome line
	la $a0, printWelcome
	syscall
	
	li $v0, 4			# Print Command Explain line
	la $a0, printComExplain
	syscall

# End of main

# main_loop
# The main looping for getting commands from user
main_loop:
	li $v0, 4			# Prompt for the command character
	la $a0, printCommand
	syscall
	
	li $v0, 12			# Enter the command character
	syscall
	move $s0, $v0			# Store in $s0
	li $v0, 4			# Print nextline
	la $a0, printNextline
	syscall
	

	beq $s0, 'A', A_addingemployees		# If command character = A (call isA)		# If command character = F (call isF)
	beq $s0, 'a', A_addingemployees
	beq $s0, 'P', P_performPerorder		# If command character = P (call isP)
	beq $s0, 'p', P_performPerorder		# If command character = P (call isP)
	beq $s0, 'I', I_performInorder		# If command character = I (call isI)
	beq $s0, 'i', I_performInorder		# If command character = I (call isI
	beq $s0, 'O', O_performPostorder
	beq $s0, 'o', O_performPostorder
	beq $s0, 'Z', Z_numberofemployees
	beq $s0, 'z', Z_numberofemployees
	
	beq $s0, 'S', S_searching
	beq $s0, 's', S_searching
	beq $s0, 'E',E_performempty
	beq $s0, 'e',E_performempty
	beq $s0, 'c',C_performclear
	beq $s0, 'C',C_performclear
	
	beq $s0, 'D', D_deleting
	beq $s0, 'd', D_deleting
	beq $s0, 'Q', Q_Exit	
	beq $s0, 'q', Q_Exit
	li $v0 , 4
	la $a0 , WrongInput
	syscall
	jal after
	
# End of main_loop	

A_addingemployees:
	li $v0, 4			# Prompt for the command character
	la $a0, EnterID
	syscall
	li $v0 , 5    #enter an integer 
	syscall 
	move $a2 , $v0 
	move $a3 , $s7	
	jal insert			# Call addFunct
	move $a0 , $a2
	jal SetData
	jal after
	
									# Call after	
 P_performPerorder:

	li $v0, 11			# Print the command character
	move $a0, $s0			# $a0 = $s0
	syscall
	
	li $v0, 4			# Print P Command
	la $a0, printPCommand
	syscall
	
	#lw $s7, root
	move $a3 , $s7			# curr = root
	jal preOrder			# Call preOrder
	jal after			# Call after
C_performclear:
	li $v0, 11			# Print the command character
	move $a0, $s0
	syscall
	li $v0, 4			
	la $a0, printCCommand
	syscall

	#lw $s0, root
	lw $s7 , Heap_Start
	move $a3 , $s7			# curr = root
	beq $a3 , 0 , after
	jal clear			# Call inOrder
	jal after	
E_performempty:
	li $v0, 11			# Print the command character
	move $a0, $s0
	syscall
	li $v0, 4			
	la $a0, printECommand
	syscall

	#lw $s0, root
	move $a3 , $s7			# curr = root
	jal empty			# Call inOrder			
	beqz $v0 , notemptymessage
	li $v0, 4			
	la $a0, EmptyMessage
	syscall
	jal after
notemptymessage:
	li $v0, 4			
	la $a0, NotEmptyMessage
	syscall
	jal after	

I_performInorder:
	li $v0, 11			# Print the command character
	move $a0, $s0
	syscall
	li $v0, 4			
	la $a0, printICommand
	syscall

	#lw $s0, root
	move $a3 , $s7			# curr = root
	jal InOrder			# Call inOrder
	jal after			

O_performPostorder:
	li $v0, 11			# Print the command character
	move $a0, $s0
	syscall
	li $v0, 4			
	la $a0, printOCommand
	syscall

	#lw $s0, root
	move $a3 , $s7			# curr = root
	jal postOrder		# Call inOrder
	jal after		
Z_numberofemployees:	
							
	li $v0, 11			# Print the command character
	move $a0, $s0
	syscall
	li $v0, 4			
	la $a0, printZCommand
	syscall

	#lw $s0, root
	move $a3 , $s7
	li $s5,0			# curr = root
	jal size
	move $a0, $v0
	li $v0, 1
	syscall
	jal after								
																					
S_searching:
	
    move $v1,$zero
    li $v0, 11			# Print the command character
	move $a0, $s0
	syscall
	li $v0, 4			
	la $a0, printSCommand
	syscall

	#lw $s0, root
	move $a2 , $s7
	li $v0,4
	la $a0,message
	syscall
	
	li $v0,5
	syscall
	move $a3,$v0
	
    addi $a0 , $0 , 0	# curr = root
	jal Search
	move $a0, $v1
	beq $v1 , 0 , NotFound
	move $a0 , $a3
	jal Load_From_Extern_Section
	jal Print_Data_Variables
	li $v0 , 4
	la $a0 , printFound
    syscall
    jal after	

	
	#############################################################
D_deleting:
    move $v1,$zero
    move $v0,$zero
    li $v0, 11			# Print the command character
	move $a0, $s0
	syscall
	li $v0, 4			
	la $a0, prinDCommand
	syscall
	
	move $a2 , $s7
	li $v0,4
	la $a0, DeleteMessage
	syscall
	
	li $v0,5
	syscall
	move $a3,$v0
    move $t9 , $zero
	jal Delete	
	beq $v0 , 4 , after
	jal SetData_Delete
	jal after
	
			
after:
	li $v0, 4			# Print Newline
	la $a0, printNextline
	syscall	
	
	jal main_loop
	
Q_Exit:	
 			
	li $v0, 4			# Print nextline
	la $a0, printNextline
	syscall	
									
	li $v0, 10			# Exit
	syscall						# Call main_loop

# exit
# Return to OS

# End of exit

# End of main code
									
# Insert Function Implementation
insert:        
	# Save the stack pointer
    subu $sp, $sp, 28
    sw $a3, 0($sp)
    sw $s2, 4($sp)
    sw $s3, 8($sp)
    sw $a2, 12($sp)
    sw $t2, 16($sp)
    sw $t3, 20($sp) 
    sw $s6, 24($sp) 
    # allocate memory for a new node 
    li $v0, 9
    li $a0, 12
    syscall
    move $s2, $v0       # $s2 points to the new node
        
    # Work if tree empty , Make the Root Node
    beq $a3, 0 , insertRoot
    
    # start $s3 points to the Root Node
    move $s3, $a3
    
    # Moving in Tree to insert the new value
    insertLoop:
        # $t2 holds the value of Data of the current node
        lw $t2, 0($s3)
    	beq $a2 , $t2 , Repeat
        # if the value of the Input Data is less than the current node , Traverse Left
        blt $a2, $t2, CheckLeft
        # else Traverse Right
        j CheckRight
    
    CheckLeft:
        # if the left child is null, insert the new node as the left child
        lw $t2, 4($s3)
        beq $t2, $zero, insertLeft
        # If Node is not NULL , move to the left child
        move $s3, $t2
        # Jump to behave this Left Child as the Root of sub tree now
        j insertLoop
       
     CheckRight:
        # if the right child is null, insert the new node as the right child
        lw $t2, 8($s3)
        beq $t2, $zero, insertRight
        # If Node is not NULL , move to the left child
        move $s3, $t2
        # Jump to behave this Right Child as the Root of sub tree now
        j insertLoop
    
    insertLeft:
        sw $s2, 4($s3)     # Make $s2 now point to Left Address
        sw $a2, 0($s2) 		# Store the Input Data to the Data Place in the New Node
        lw $a0 , 0($s2)
        move $a1 , $s2
        # Restore Values
        lw $a3, 0($sp)
    	lw $s2, 4($sp)
    	lw $s3, 8($sp)
    	lw $a2, 12($sp)
    	lw $t2, 16($sp)
        lw $t3, 20($sp) 
        lw $s6, 24($sp) 
        addu $sp, $sp, 28
        jr $ra
        
    insertRight:
        sw $s2, 8($s3)     # Make $s2 now point to Right Address
        sw $a2, 0($s2) 		# Store the Input Data to the Data Place in the New Node
        lw $a0 , 0($s2)
        move $a1 , $s2
        # Restore Values
        lw $a3, 0($sp)
    	lw $s2, 4($sp)
    	lw $s3, 8($sp)
    	lw $a2, 12($sp)
    	lw $t2, 16($sp)
    	lw $t3, 20($sp) 
        lw $s6, 24($sp) 
        addu $sp, $sp, 28
        jr $ra

	# Make Root if Tree is Empty , work in first only and for one time
	insertRoot:
		# $s2 now holds the first address of heap or the address come from Create Tree Function 
    	move $a3, $s2         # $a3 point to this address
    	sw $zero , 4($a3)     # Left with NULL
    	sw $zero , 8($a3)     # Right with NULL
    	sw $a2   , 0($a3)     # Data with value
    	move $s7 , $a3
    	jr $ra
    	
    Repeat:
    li $v0 , 4
    la $a0 , RepeatMsg
    syscall
    j main_loop

#######################################################	

#######################################################																	

																		
																																			
#InOrder   
InOrder:
	move $a0, $a3			# $a0 = $s0
	
	# if(bPtr == NULL)
	bne $a0, $0, InOrderRecurse
	jr $ra				# Return to caller
	
InOrderRecurse:
	addi, $sp, $sp, -8		# Allocate 2 registers to stack
	sw $ra, 0($sp)			# $ra is the first register
	sw $a0, 4($sp)			# $a0 is the second register
        
        
	
	lw $a3,4($a3)		        # curr = curr->left
	jal InOrder			# Call InOrder
	
	lw $a0, 4($sp)			# Retrieve original value of $a0
	move $a3, $a0	                # $s7 = $a0
	jal printSmall		        # Call printSmall
	lw $a3, 8($a3)		        # curr = curr->right
	jal InOrder			# Call InOrder
		
			                
	lw $ra, 0($sp)			# Retrieve original return address
	addi $sp, $sp, 8		# Free the 2 register stack spaces
	jr $ra				# Return to caller

# End of InOrder traversal

######################################################
#preOrder   	
preOrder:	
	move $a0, $a3			# $a0 = $s0
	
	# if(bPtr == NULL)
	bne $a0, $0, preOrderRecurse
	jr $ra				# Return to caller
	
preOrderRecurse:
	addi, $sp, $sp, -8		# Allocate 2 registers to stack
	sw $ra, 0($sp)			# $ra is the first register
	sw $a0, 4($sp)			# $a0 is the second register
        
                    jal printSmall                                             # Call printSmall
	
	lw $a3,4($a3)		        # curr = curr->left
	jal preOrder			# Call preOrder
	
	lw $a0, 4($sp)			# Retrieve original value of $a0
	move $a3, $a0	                # $s7 = $a0
	lw $a3, 8($a3)		        # curr = curr->right
	jal preOrder			# Call preOrder
		
			                
	lw $ra, 0($sp)			# Retrieve original return address
	addi $sp, $sp, 8		# Free the 2 register stack spaces
	jr $ra				# Return to caller

# End of preOrder traversal
######################################################
# postOrder
postOrder:   
    move $a0, $a3           # a0 = $s0

    # if (bPtr == NULL)
    bne $a0, $0, postOrderRecurse
    jr $ra                  # Return to caller

postOrderRecurse:
    addi $sp, $sp, -8       # Allocate 2 registers to stack
    sw $ra, 0($sp)          # $ra is the 1st
    sw $a0, 4($sp)          # $a0 is the 2nd

    lw $a3, 4($a3)        # curr = curr->left
    jal postOrder           # Call postOrder

    lw $a0, 4($sp)          # Retrieve original $a0
    move $a3, $a0           # $s0 = $a0

    lw $a3, 8($a3)        # curr = curr->right
    jal postOrder           # Call postOrder

    lw $a0, 4($sp)          # Retrieve original $a0
    move $a3, $a0           # $s0 = $a0
    jal printSmall          # Call printSmall

    lw $ra, 0($sp)          # Retrieve original $ra
    addi $sp, $sp, 8        # Free the 2 register stack spaces
    jr $ra
    
 #End of postOrder traversal
######################################################

# printSmall
printSmall:
	addi $sp , $sp , -12
	sw $ra , 0($sp)
	sw $a3 , 4($sp)
	sw $t1 , 8($sp)
	lw $a0, 0($a3)
	move $a3 , $a0 
	jal Load_From_Extern_Section
	jal Print_Data_Variables
	
	addi $t1 , $zero , 0
	la $a0 , Name
	Copy_Str_Delete2:
		beq $t1 , 7 , End_Copy_Str_Delete2
		sw $zero , 0($a0)
		addi $t1 , $t1 , 1
		addi $a0 , $a0 , 4
		j Copy_Str_Delete2
	End_Copy_Str_Delete2:
	
	#li $v0, 4
	#la $a0,format
	#syscall
	 
	lw $ra , 0($sp)
	lw $a3 , 4($sp)
	lw $t1 , 8($sp)
	addi $sp , $sp , 12
	 
	jr $ra

# End of printSmall

size:
    move $v0,$zero
    move $a0, $a3           # $a0 = $a3
    # if(bPtr == NULL)
    beq $a3 , $zero , JAL
    lw $v0 , 0($a3)
    beq $v0 , $zero , JAL
    bne $a0, $0, sizeRecurse
    jr $ra 
    JAL:
    move $v0,$zero
    jr $ra               # Return to caller
    
sizeRecurse:
    addi $sp, $sp, -8       # Allocate 2 registers to stack
    sw $ra, 0($sp)          # $ra is the first register
    sw $a0, 4($sp)          # $a0 is the second register
    
    jal increaseSize            # Call printSize
    
    lw $a3, 4($a3)          # curr = curr->left
    jal size            # Call size
    
    lw $a0, 4($sp)          # Retrieve original value of $a0
    move $a3, $a0           # $s0 = $a0
    lw $a3, 8($a3)          # curr = curr->right
    jal size            # Call size
    
    move $v0, $s5
    lw $ra, 0($sp)          # Retrieve original return address
    addi $sp, $sp, 8        # Free the 2 register stack spaces
    jr $ra              # Return to caller

# End of size

# printSize
increaseSize:
    
    addi $s5, $s5, 1
    jr $ra              # Return to caller
						# Empty function
empty:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal size
	move $t8, $v0
	li $v0, 0
	beq $t8, $zero, isempty
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
isempty:
	addi $v0, $v0, 1
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
# End of empty function

clear:
    move $a0,$s7          # a0 = $s0
    # if (bPtr == NULL)
    bne $a0, $0, clearRecurse
    jr $ra
clearRecurse:
    addi $sp, $sp, -8       # Allocate 2 registers to stack
    sw $ra, 0($sp)          # $ra is the 1st
    sw $a0, 4($sp)          # $a0 is the 2nd

    lw $s7 , 4($s7)        # curr = curr->left
    jal clear          # Call postOrder

    lw $a0, 4($sp)          # Retrieve original $a0
    move $s7, $a0           # $s0 = $a0

    lw $s7, 8($s7)        # curr = curr->right
    jal clear           # Call postOrder

    lw $a0, 4($sp)          # Retrieve original $a0
    move $s7, $a0           # $s0 = $a0
    jal finalclear          # Call printSmall

    lw $ra, 0($sp)          # Retrieve original $ra
    addi $sp, $sp, 8        # Free the 2 register stack spaces
    jr $ra
    
# final clear
finalclear:
    sw $zero,0($s7)
    sw $zero , 4($s7)        # Set left pointer  to null    
    sw $zero , 8($s7)        # Set right pointer  to null
    li $s7 , 0              # Set $s7 to null
    jr $ra                  # Return to caller
    
# End of clear  edit this code to clear all nodes
 #End of clear
######################################################


##############################################################
## Registers Used (save inside stack) ##
########################################
# $a1 : Tree Number
# $t1 : Temporary for carry the start place in .data memory
# $s5 : Pointer to All Trees Roots
##############################################################

Delete:
	move $s5,$ra
	addi $a0,$zero,1
	DeleteTwo:
	jal Search # a2 is the address of the root and $a3 is the value to delete
	move $s0,$v0  # address of element
	move $s1,$v1  # address of parent
	addi $t7,$zero ,-1
	beq $v0, $t7,EEWXIT
	beq $v1,$0,Root
	Abdo:
	lw $t1,4($s0) # address of left of the element
	lw $t2,8($s0) # address of right of the element
	sne $t3,$t2,$0 # if there is right
	sne $t4,$t1,$0 # if there is left
	add $t5,$t3,$t4 # 
	beq $t5,$0,CaseOne # there is no left neither right
	beq $t4,1,CaseTwoI
	beq $t3,1,CaseTwoII
CaseOne:
	addi $s2,$s1,4
	lw $s2,0($s2)
	beq $s2,$s0,Null
	addi $s2,$s1,8
	lw $s2,0($s2)
	beq $s2,$s0,Null
	j RA
Null:
	sw $0,0($s2)
	sw $0,0($s0)
CaseTwoI:
	beq $t3,1,FinalCase
	lw $t8,4($s1) # left of the parent
	beq $t8,$s0,CaseThreeII # if the element in left of the parent
	lw $t6,4($s0)
	sw $t6,8($s1)
	j RA
CaseTwoII:
	beq $t4,1,FinalCase
	lw $t8,4($s1) # left of the parent
	beq $t8,$s0,CaseThreeI # if the element in left of the parent
	# else the element in right of the parent
	lw $t8, 8($s0)
	sw $t8, 8($s1)
	j RA
CaseThreeI:
	lw $t6,8($s0)
	sw $t6,4($s1)
	j RA
CaseThreeII:
	lw $t6,4($s0)
	sw $t6,4($s1)
	j RA
FinalCase:
	# else the element has left and right
	move $t0,$t1 # both t1 and t0 has the address of left of the element
	Loop:
		lw $t2,8($t0) # right of left of the element
		beq $t2,$0,FinalCaseII
		move $t1,$t0
		move $t0,$t2
		j Loop
	FinalCaseII:
	lw $t7,4($s0)
	beq $t7,$t0,LeftWithoutRight
	lw $t6,0($t0)
	sw $t6,0($s0)
	move $a2,$t1
	move $a3,$t6
	j DeleteTwo
LeftWithoutRight:
	beq $s1,$0,RRoot 
	sw $t0,4($s1)
	lw $t8,8($s0)
	sw $t8,8($t0)
	j RA
RRoot:
	lw $t9 ,4($s0)
	lw $s1 ,0($t9)
	sw $s1 , 0($s0)
	sw $0 ,4($s0)
	sw $0 ,0($t9)	
	move $ra,$s5
	jr $ra
Root:
	lw $t2,4($s0)
	lw $t3,8($s0)
	add $t1,$t2,$t3
	beq $t1 , $0 , RA
	beq $t2,$0,RootNoLeft
	beq $t3 , $0 , RootNoRight
	j Abdo
RootNoRight:
	lw $t7,0($t2)
	lw $t8,4($t2)
	lw $t9,8($t2)
	sw $t7,0($s0)
	sw $t8,4($s0)
	sw $t9,8($s0)
	sw $0, 0($t2)
	sw $0, 4($t2)
	sw $0, 8($t2)
	move $ra,$s5
	jr $ra
RootNoLeft:
	lw $t7,0($t3)
	lw $t8,4($t3)
	lw $t9,8($t3)
	sw $t7,0($s0)
	sw $t8,4($s0)
	sw $t9,8($s0)
	sw $0, 0($t3)
	sw $0, 4($t3)
	sw $0, 8($t3)
	move $ra,$s5
	jr $ra
RA:
	move $ra,$s5
	sw $0,0($s0)
	sw $0,4($s0)
	sw $0,8($s0)
	jr $ra	
EEWXIT:
	move $ra,$s5
	li $v0,4
	la $a0,notDeleteMessage
	syscall 
	jr $ra	
Search:
	# Stack Store
	subu $sp, $sp, 28
    sw $a2, 0($sp) # root
    sw $a3, 4($sp) # data
    sw $s0, 8($sp) 
    sw $t0, 12($sp)
    sw $t1, 16($sp)
    sw $t7, 20($sp)
    sw $t9, 24($sp)
 
	# Conditions 
	# Check if Root is not NULL
	beq $a2 , 0 , end

	# Operations
		# Load Value of Data in $t0
		lw $t0 , 0($a2)
		beq $t0 , $a3 , Found
		slt $t1 , $a3 , $t0
		beq $t1 , 1 , GoLeft
		addi $t9, $a2, 0
		lw $t0 , 8($a2)
		move $a2 , $t0
		j Search
		Found:
		beq $a0 , 0, wwexit
			move $v0 , $a2 # address of element 
			move $v1, $t9# address of parent 
			j wwwexit
		wwexit: 
		addi $v1, $zero ,1
		wwwexit:
    		lw $a2, 0($sp)
    		lw $a3, 4($sp)
    		lw $s0, 8($sp)
    		lw $t0, 12($sp)
    		lw $t1, 16($sp)
    		lw $t7, 20($sp)
    	 	lw $t9, 24($sp)
    		addi $sp, $sp, 28
    		move $a0 , $a3
			jr $ra
		GoLeft:
			addi $t9, $a2, 0
			lw $t0 , 4($a2)
			move $a2 , $t0
			j Search
		end:
			addi $v0 , $zero , -1
			lw $a2, 0($sp)
    		lw $a3, 4($sp)
    		lw $s0, 8($sp)
    		lw $t0, 12($sp)
    		lw $t1, 16($sp)
    		lw $t7, 20($sp)
    		    	 	lw $t9, 24($sp)
    		addi $sp, $sp, 28
			jr $ra

NotFound:
	li $v0,4
	la $a0,printnotFound
    syscall	
	jal after
	
############################################################
# $a0 : ID Value
# $a1 : carry Address of Heap
# $t1 : carry value of variables
# $t2 : carry byte of Name and store it in .data memory section two
# $f0 : carry value of salary and store it 
# $s3 : carry ID value
# $s4 : Point to the place that carry Heap Address of this ID then Data Address

SetData:
	addi $sp , $sp , -28
	sw $a0 , 0($sp)
	sw $a1 , 4($sp)
	sw $t1 , 8($sp)
	sw $t2 , 12($sp)
	sw $s3 , 20($sp)
	sw $ra , 24($sp)
	move $s3 , $a0
	# Store Data of this ID .extren
	# Read Age one from user
	li $v0, 4			# Print welcome line
	la $a0, EnterAge
	syscall 
	li $v0 , 5
	syscall
	sw $v0 , Age
	# Read Salary one from user
	# We use 6 with $v0 to get float and it saved in $f0
	li $v0, 4			# Print welcome line
	la $a0, EnterSalary
	syscall 
	li $v0 , 6
	syscall
	swc1 $f0 , Salary
	# Read Name one from user
	li $v0, 4			# Print welcome line
	la $a0, EnterName	
	syscall 
    li $v0, 8           
    la $a0, Name 
    li $a1, 28          
    syscall            
	# Second we will store the data in .extern
	# $s3 carry ID
	move $a0 , $s3
	addi $a0 , $a0 , -1
	mul $a0 , $a0 , 36
	la $s4 , DataAddress
	add $s4 , $s4 , $a0
	# Now we are in .data section two
	# $s4 will used to move inside this 50 bytes
	# Load Age value from Age variable and then store in .data section 2
	lw $t1 , Age
	sw $t1 , 0($s4)
	addi $s4 , $s4 , 4
	# Load Salary value from Salary variable and then store in .data section 2
	lwc1 $f0 , Salary
	swc1 $f0 , 0($s4)
	addi $s4 , $s4 , 4
	# Load Name value from Name variable and then store in .data section 2
	la $t1 , Name
	Copy_Str:
		lb $t2 , 0($t1)
		beqz $t2 , End_Copy_Str
		sb $t2 , 0($s4)
		addi $t1 , $t1 , 1
		addi $s4 , $s4 , 1
		j Copy_Str
	End_Copy_Str:
	
	lw $a0 , 0($sp)
	lw $a1 , 4($sp)
	lw $t1 , 8($sp)
	lw $t2 , 12($sp)
	lwc1 $f0 , 16($sp)
	lw $s3 , 20($sp)
	lw $ra , 24($sp)
	addi $sp , $sp , 28
	jr $ra
	
############################################################

SetData_Delete:
	addi $sp , $sp , -24
	sw $a0 , 0($sp)
	sw $a1 , 4($sp)
	sw $t1 , 8($sp)
	sw $t2 , 12($sp)
	sw $s3 , 20($sp)
	# Second we will store 0 in .extern
	addi $a0 , $a0 , -1
	mul $a0 , $a0 , 36
	la $s4 , DataAddress
	add $s4 , $s4 , $a0
	# Now we are in .extren
	# Load Age value from Age variable and then store in .data section 2
	sw $zero , 0($s4)
	addi $s4 , $s4 , 4
	# Load Salary value from Salary variable and then store in .data section 2
	lwc1 $f0 , Zero_Frac
	swc1 $f0 , 0($s4)
	addi $s4 , $s4 , 4
	# Load Name value from Name variable and then store in .data section 2
	addi $t1 , $zero , 0
	Copy_Str_Delete:
		beq $t1 , 7 , End_Copy_Str_Delete
		sw $zero , 0($s4)
		addi $t1 , $t1 , 1
		addi $s4 , $s4 , 4
		j Copy_Str_Delete
	End_Copy_Str_Delete:
	
	lw $a0 , 0($sp)
	lw $a1 , 4($sp)
	lw $t1 , 8($sp)
	lw $t2 , 12($sp)
	lwc1 $f0 , 16($sp)
	lw $s3 , 20($sp)
	addi $sp , $sp , 24
	jr $ra
	
#########################################################

Print_Data_Variables:
	# Print New Line
	li $v0 , 4
	la $a0 , line
	syscall
	# Print ID Data
	li $v0 , 4
	la $a0 , ID_str
	syscall
	li $v0 , 1
	move $a0 , $a3
	syscall
	li $v0 , 4
	la $a0 , line
	syscall
	# Print Age Data
	li $v0 , 4
	la $a0 , Age_str
	syscall
	lw $t0 , Age
	li $v0 , 1
	move $a0 , $t0
	syscall
	li $v0 , 4
	la $a0 , line
	syscall
	# Print Salary Data
	li $v0 , 4
	la $a0 , Salary_str
	syscall
	lwc1 $f12 , Salary
	li $v0 , 2
	syscall
	li $v0 , 4
	la $a0 , line
	syscall
	# Print Name Data
	li $v0 , 4
	la $a0 , Name_str
	syscall
	li $v0 , 4
	la $a0 , Name
	syscall
	li $v0 , 4
	la $a0 , line
	syscall
	jr $ra

############################################################

Load_From_Extern_Section:
	addi $a0 , $a0 , -1
	mul $a0 , $a0 , 36
	la $s4 , DataAddress
	add $s4 , $s4 , $a0
	# Load Age Data
	lw $t0 , 0($s4)
	sw $t0 , Age
	# Load Salary Data
	lwc1 $f0 , 4($s4)
	swc1 $f0 , Salary
	addi $s4 , $s4 , 8
	# Load Name Data
	la $t0 , Name
	Copy_Str_To_Name:
		lb $t2 , 0($s4)
		beqz $t2 , End_Copy_Str_To_Name
		sb $t2 , 0($t0)
		addi $t0 , $t0 , 1
		addi $s4 , $s4 , 1
		j Copy_Str_To_Name
	End_Copy_Str_To_Name:
	jr $ra



