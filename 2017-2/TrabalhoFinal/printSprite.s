.eqv VGA 0xFF000000
 
.data
# SpriteInfo: width, height, curr frame, max frame
# Hitbox info: type, width, height, y-position, x-position. Ends with value -1.
# Hitbox types: passive = 0, active = 1, block = 2, ...
hitMsg: .asciiz "hit detected!!!"

sprite: .space 4
frameSequence: .space 10 # 10 frames max
hitboxBuff: .space 20 # temporary
hitboxInfoP1: .space 20 # 5 bytes per hitbox
hitboxInfoP2: .space 20
.align 2
fileAddrs: .space 4
.align 2
fileDsc: .space 4
 
.macro openFile (%file, %mode)	# opens file %file in read mode %mode
.data
str: .asciiz %file
.text
    la, $a0, str
    li $a1, %mode
    li $v0, 13
    syscall
.end_macro
 
.macro closeFile	# closes file
    li $v0, 16
    syscall
.end_macro
 
.macro done	# finish program
    li $v0,10
    syscall
.end_macro

.macro sleep(%d)	# stop program execution for %d milisseconds
    li $a0, %d
    li $v0, 32
    syscall
.end_macro

.text
 
    openFile ("Ryu_L_Punch.spr", 0)
    sw $v0, fileDsc
    move $a0, $v0
    jal extractInfo 
    
    
    li $s0, 0
spriteWhile:	# prints all frames of a movement.
    li $a0, -2
    move $s1, $a0 	# saves intent
    li $a1, 100
    li $a2, 100
    la $a3, sprite
    jal printSprite
    addi $s0, $s0, 1
    bne $v0, -1, hit  # a hit has occured
    bne $a0, $zero, spriteWhile # still frames to go
    closeFile()
   
hit: 
    
#### FUNCTIONS ####
extractInfo:

la $a1, sprite


# frames
addi $a0, $a0, 8
lw $t0, 0($a0) # number of frames to print
addi $t0, $t0, 1
addi $a0, $a0, 4
la $a1, frameSequence 
add $t1, $zero, $zero

FLOOP:
beq $t1, $t0, goBox
	lh $t2, 0($a0)
	sb $t2, 0($a1)
	addi $a0, $a0, 2
	addi $a1, $a1, 1
	addi $t1, $t1, 1
	j FLOOP

#hitboxes
goBox:
lw $t0, 0($a0)
add $t1, $zero, $zero
addi $a0, $a0, 4

BLOOP:
beq $t1, $t0, ffin
	lh $t2, 0($a0)
	lh $t3, 2($a0)
	lh $t4, 4($a0)
	lh $t5, 6($a0)
	lh $t6, 8($a0)
	addi $a0, $a0, 10
	
	sb $t2, 0($a1)
	sb $t3, 1($a1)
	sb $t4, 2($a1)
	sb $t5, 3($a1)
	sb $t6, 4($a1)
	addi $a1, $a1, 5
	
	addi $t1, $t1, 1
	j BLOOP
	
ffin:    la $t1, -1
	sb $t1, 0($a1)
	
        la $t0, fileAddrs
    	sw $a0, 0($t0)  # saves file true starting address to label
    	jr $ra
	
   
printSprite:    # prints sprites. $a0 = sprite intent && player, $a1 = y-position, $a2 = x-position, $a3 = sprite info
    addi $sp, $sp, -4  
    sw $ra, 0($sp)      # saves $ra
    move $t3, $a0       # saves intent
    move $t4, $a1	# saves x-position
    move $t5, $a2	# saves y-position
   
    # finding VGA start address in $t0
    la $t0, VGA # open VGA memory
    mul $a1, $a1, 320   # correct line
    add $t0, $a1, $t0   # correct line in VGA adress
    add $t0, $t0, $a2   # correct column in Bitmap Display
   
    # getting sprite info
    lb $t9, 0($a3)  # sprite width
    lb $t8, 1($a3)  # sprite height
    lb $t7, 2($a3)  # current frame idx
    lb $t6, 3($a3)  # number of frames
   
    # getting correct frame
    lb $t7, frameSequence($t7)
   
    # getting sprite file first address
    la $a0, fileAddrs     # sprite images will be under fileAddrs tag
    mul $t7, $t7, $t9  # sprite image start from start of file
    add $a0, $a0, $t7  # sprite image real start
   
    # getting next line width ready
    mul $t7, $t6, $t9  # width of file
   
    # actually printing it
    move $a1, $t9  # first line end
    mul $a2, $t8, $t9  # number of words to end
    li $t1, 0      # bytes computed
printWhile: beq $t1, $a2, fin   # $t1 == $a2 ?
        beq $t1, $a1, nextLine
        lw $t2, 0($a0)  # next byte to print
        sw $t2, 0($t0)  # print word
        addi $a0, $a0, 4    # next file address
        addi $t0, $t0, 4    # next VGA address
        addi $t1, $t1, 4    # counts computed bytes
        j printWhile
       
nextLine:   addi $t0, $t0, 320  # same column, a line below in VGA
        sub $t0, $t0, $t9   # correct start column
        add $a0, $a0, $t7   # same column, a line bellow in file
        sub $a0, $a0, $t9   # correct start column
        add $a1, $a1, $t9
        j printWhile
       
fin:    # updating hitboxes 
    sleep(200)
    jal createHitBox	# internal function. Will not be called in any other context. No need to follow regular protocol.
    
   
    # function now calls colisionTest if necessary.
    # if it is necessary, then there will be only one active hitbox
    # in the 1st position of array.
    beq $a0, 0, skip
    beq $a0, 2, skip
    move $a0, $v0	# vector of player calling it
    move $a1, $v1	# vector for check
    jal colisionTest 
    j end
skip:    li $v0, -1
    # returns any colision and updates frames. Returns if movement is finished
end:lb $t5, 2($a3)  # current frame
    addi $t5, $t5, 1  # next frame      
   
    sb $t5, 2($a3)  # next idx in frameSequence
    lb $t5, frameSequence($t5)
    move $a0, $t5   # if next idx is 0, movement is finished
    lw $ra, 0($sp)  # correct return address
    add $sp, $sp, 4 # de-allocate stack
    jr $ra



createHitBox:  
	# $t2 = player's hitbox vector, $t3 = intent, $t4 = x-position, $t5 = y-position
	# deciding player
	# player 1 sends intent with positive values. Player 2 with negative values.
	slt $t0, $t3, $zero 
	bne $t0, $zero, P2 
	la $t2, hitboxInfoP1
	la $v1, hitboxInfoP2
	j box

P2:	la $t2, hitboxInfoP2
	la $v1, hitboxInfoP1
	move $v0, $t2	
	
box:	#creates hitboxes from intent & buffer
	la $t8, hitboxBuff
	
makeB:
	lb $t9, 0($t8)
	sb $t9, 0($t2)
	beq $t9, -1, finit
	addi $t8, $t8, 1
	addi $t2, $t2, 1
	lw $t9, 0($t8)
	sw $t9, 0($t2)
	addi $t8, $t8, 4
	addi $t2, $t2, 4
	j makeB
	
finit: # return ?
	lb $a0, 0($v0)
	jr $ra

colisionTest: 
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	
	# gets active box
	lb $s0, 0($a0) # type
	lb $s1, 1($a0) # width
	lb $s2, 2($a0) # height
	lb $s3, 3($a0) # y-position l1y
	lb $s4, 4($a0) # x-position l1x
	add $t8, $s1, $s4 # Rax
	add $t7, $s2, $s3 # Ray
	
whileThereAreBoxesToCheck:
	lb $t9, 0($a1) # type or end of array
	beq $t9, -1, noMoreBox
	lb $t1, 1($a1) # width
	lb $t2, 2($a1) # height
	lb $t3, 3($a1) # y-position2 l2y
	lb $t4, 4($a1) # x-position2 l2x
	add $v0, $t1, $t4  # Rbx
	add $v1, $t2, $t3  # Rby
	
	# actual check
	# dont change these lines
	# check if no overlap
	li $t5, 0
	sgt $t0, $s4, $v1  # La > Rb
	sll $t5, $t0, 3
	sgt $t0, $t4, $t8  # Lb > Ra
	sll $t0, $t0, 2
	or $t5, $t5, $t0
	sgt $t0, $s3, $v1  # Ua > Bb
	sll $t0, $t0, 1
	or $t5, $t5, $t0
	sgt $t0, $t3, $t7  # Ub > Ba
	or $t5, $t5, $t0
	bne $t5, $zero, noColision
	
	# if there is colision
	# only one colision will be counted
	move $v0, $s0	# type of hit maker
	move $v1, $t9	# type of hit taker
	j noMoreBox
	
	
	
noColision:
	# next possible hitbox
	addi $a1, $a1, 5
	li $v0, -1  # no hit
	j whileThereAreBoxesToCheck
	
noMoreBox:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	addi $sp, $sp, 20
	jr $ra
	
	
