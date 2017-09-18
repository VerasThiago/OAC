.eqv VGA 0xFF000000
 
.data
# SpriteInfo: width, heigth, curr frame, max frame
# Hitbox info: width, heigth, type, adress index
ryuidle: .byte 48, 91, 0, 4
frameSequence: .byte 0, 1, 2, 3, 0
hitboxInfo: .space 4
hitboxAddress: .space 4
.align 2
buffer: .space 20000
 
.macro openFile (%file, %mode)
.data
str: .asciiz %file
.text
    la, $a0, str
    li $a1, %mode
    li $v0, 13
    syscall
.end_macro
 
.macro readToBuff
    la $a1, buffer
    li $a2, 20000
    li $v0, 14
    syscall
.end_macro
 
.macro closeFile
    li $v0, 16
    syscall
.end_macro
 
.macro done
    li $v0,10
    syscall
.end_macro
   
.text
 
    openFile ("ryu_idle.bin", 0)
    move $a0, $v0
    readToBuff
    closeFile
   
   li $s0, 0
spriteWhile:
    li $a0, 0
    li $a1, 100
    li $a2, 100
    la $a3, ryuidle
    jal printSprite
    addi $s0, $s0, 1
    bne $v1, $zero, spriteWhile
    done
   
   
   
printSprite:    # prints sprites. $a0 = sprite intent, $a1 = x-position, $a2 = y-position, $a3 = sprite info
    addi $sp, $sp, -4  
    sw $ra, 0($sp)      # saves $ra
    move $t3, $a0       # saves intent
   
    # finding VGA start address in $t0
    la $t0, VGA # open VGA memory
    mul $a1, $a1, 320   # correct line
    add $t0, $a1, $t0   # correct line in VGA adress
    add $t0, $t0, $a2   # correct column in Bitmap Display
   
    # getting sprite info
    lb $t9, 0($a3)  # sprite width
    lb $t8, 1($a3)  # sprite heigth
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
    beq $t3, 0, passive # decides which action the sprite is taking
    beq $t3, 1, active  # so that appropriate hitboxes can be created
    beq $t3, 2, special
    beq $t3, 3, block
   
passive:
 
active:
 
special:
 
block:
   
    # function now calls colisionTest
   
    # returns any colision and updates frames. Returns if movement is finished
    lb $t5, 2($a3)  # current frame
    addi $t5, $t5, 1  # next frame      
   
    sb $t5, 2($a3)  # next idx in frameSequence
    lb $t5, frameSequence($t5)
    move $v1, $t5   # if next idx is 0, movement is finished
    lw $ra, 0($sp)  # correct return address
    add $sp, $sp, 4 # de-allocate stack
    jr $ra
