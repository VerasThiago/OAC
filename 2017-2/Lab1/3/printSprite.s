.eqv VGA 0xFF000000
 
.data
# SpriteInfo: width, height, curr frame, max frame
# Hitbox info: type, width, height, y-position, x-position. Ends with value -1.
# Hitbox types: passive = 0, active = 1, block = 2, ...
hitMsg: .asciiz "hit detected!!!"
ryuidle: .byte 48, 91, 0, 4
honda:	.byte 48, 91, 0, 4
ryupunch: .byte 60, 91, 0, 3
frameSequence: .byte 0, 1, 2, 3, 2, 1, 0
hitboxInfoP1: .space 20 # 5 bytes per hitbox
hitboxInfoP2: .space 20
.align 2
buffer: .space 20000
 
.macro openFile (%file, %mode)	# opens file %file in read mode %mode
.data
str: .asciiz %file
.text
    la, $a0, str
    li $a1, %mode
    li $v0, 13
    syscall
.end_macro
 
.macro readToBuff	# reads file to buffer
    la $a1, buffer
    li $a2, 20000
    li $v0, 14
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
 
    openFile ("SpriteHonda.bin", 0)
    move $a0, $v0
    readToBuff
    closeFile
   
   li $s0, 0
spriteWhile:	# prints all frames of a movement.
    li $a0, -2
    move $s1, $a0 	# saves intent
    li $a1, 100
    li $a2, 100
    la $a3, honda
    jal printSprite
    addi $s0, $s0, 1
    bne $v0, -1, hit  # a hit has occured
    bne $a0, $zero, spriteWhile # still frames to go
   
   openFile ("ryu_idleB.bin", 0)
    move $a0, $v0
    readToBuff
    closeFile
   
   li $s0, 0
spriteWhile0:	# prints all frames of a movement.
    li $a0, 2
    move $s1, $a0 	# saves intent
    li $a1, 100
    li $a2, 180
    la $a3, ryuidle
    jal printSprite
    addi $s0, $s0, 1
    bne $v0, -1, hit  # a hit has occured
    bne $a0, $zero, spriteWhile0 # still frames to go
   
   openFile ("RyuLPunch.bin", 0)
    move $a0, $v0
    readToBuff
    closeFile
   
   la $t0, frameSequence
   li $a0, 0
   sb $a0, 0($t0)
   li $a0, 1
   sb $a0, 1($t0)
   li $a0, 2
   sb $a0, 2($t0)
   sb $a0, 3($t0)
   li $a0, 1
   sb $a0, 4($t0)
   li $a0, 0
   sb $a0, 5($t0)
   
   
   li $s0, 0
spriteWhile1:	# prints all frames of a movement.
    li $a0, 1
    move $s1, $a0 	# saves intent
    li $a1, 100
    li $a2, 60
    la $a3, ryupunch
    jal printSprite
    addi $s0, $s0, 1
    bne $v0, -1, hit  # a hit has occured
    bne $a0, $zero, spriteWhile1 # still frames to go
    done
hit:    # take action regarding hit.
	# $v0 has hitbox type of hit maker.
	# $v1 has hitbox type of hit taker.
	# $s1 has intent. So it can figure who hit who.
	la $a0, hitMsg
	li $v0, 4
	syscall
    done
    
   
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
    la $a0, buffer     # sprite images will be under buffer tag
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
    # li $v0, -1
    beq $a0, -1, skip
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
	# $t2 = player's hitbox vactor, $t3 = intent, $t4 = x-position, $t5 = y-position
	
	# deciding player
	# player 1 sends intent with positive values. Player 2 with negative values.
	slt $t0, $t3, $zero 
	bne $t0, $zero, P2 
	la $t2, hitboxInfoP1
	la $v1, hitboxInfoP2
	j box

P2:	la $t2, hitboxInfoP2
	la $v1, hitboxInfoP1
	neg $t3, $t3	
	
box:	#creates hitboxes from intent
	# $t2 has correct vector address
	beq $t3, 2, passive # decides which action the sprite is taking
    	beq $t3, 1, punchM  # so that appropriate hitboxes can be created
    	beq $t3, 2, punchH
    	beq $t3, 3, kickM
    	beq $t3, 4, kickH
    	beq $t3, 5, special
    	beq $t3, 6, block
    	beq $t3, 7, jump
    	beq $t3, 8, damage
    # more movements possible ...
    	jr $ra # some prints dont create hitboxes (e.g. printing background)
   
passive: sb $zero, 0($t2)	# passive type - 2 hitboxes (superior and inferior)
	 addi $at, $zero, 2
	 div $t8, $at
	 mflo $v0		# sprite height/2
	 sb $t9, 1($t2)		# passive width = sprite width
	 sb $v0, 2($t2)		# passive height = sprite height/2
	 sb $t4, 3($t2)		# y-position
	 sb $t5, 4($t2)		# x-position
	 mfhi $at
	 add $v0, $at, $v0  # height/2 + resto
	 sb $zero,  5($t2)  # and repeats
	 sb $t9, 6($t2)	 
	 sb $v0, 7($t2)
	 mflo $at
	 add $at, $at, $t4
	 sb $t4, 8($t2)
	 sb $t5, 9($t2)
	 
	 li $a0, -1
	 sb $a0, 10($t2)		# signal end of hitboxInfo array
	 move $v0, $t2
	 jr $ra

punchM:  li $at, 1
	 sb $at, 0($t2) 	# active type - 3 hitboxes (superior, punch, inferior)
	 addi $at, $zero, 4
	 div $t9, $at		# width/4
	 lb $t7, 2($a3)
	 lb $t7, frameSequence($t7)	 # current frame
	 addi $t7, $t7, 1  #for the case that the frame is zero
	 mflo $v0
	 mul $at, $t7, $v0	# hand width
	 sb $at, 1($t2)		# box width
	 addi $at, $zero, 3
	 mul $at, $v0, $at	# x-position ?
	 add $at, $at, $t5	# x-position
	 sb $at, 4($t2)		# x-position 
	 addi $at, $zero, 2
	 div $at, $t8, $at	# height/2
	 sb $at, 2($t2)
	 sb $t4, 3($t2)		# y- position ? 
	 
	 mfhi $at
	 add $v0, $at, $v0  # height/2 + resto
	 sb $zero,  5($t2)  # and repeats
	 sb $t9, 6($t2)	 
	 sb $v0, 7($t2)
	 mflo $at
	 add $at, $at, $t4
	 sb $t4, 8($t2)
	 sb $t5, 9($t2)
	 
	 li $a0, -1
	 sb $a0, 10($t2)		# signal end of hitboxInfo array
	 li $a0, 0
	 move $v0, $t2
	 jr $ra
	 
	 
	 

punchH:

kickM:

kickH:
 
special:
 
block:

jump:

damage:

	
	
	
	
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
	
	
	
