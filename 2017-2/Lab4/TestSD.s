# Test of reading from SD to VGA memory.
# by Gguidini - 2017/2

#################################################################################
#                       Teste Syscall 49 - SD Card Read                         #
#                                                                               #
#  - $a0    =    Origem Addr          [Argumento]                               #
#  - $a1    =    Destino Addr         [Argumento]                               #
#  - $a2    =    Quantidade de Bytes  [Argumento]                               #
#  - $v0    ?    Falha : Sucesso      [Retorno]                                 #
#                                                                               #
#################################################################################

.eqv VGA 0xFF000000	# VGA initial address
.eqv VGASize 76800	# screen size

# .eqv SD_DATA_ADDR dunno	# Addr = Offset + 0x00011200 (defasagem de setores lógicos/físicos * tamanho do setor)

.data

.text
	la $a0, SD_DATA_ADDR
	la $a1, VGA
	li $a2, VGASize
	li $v0, 49
	syscall
	
PAUSE:	j PAUSE