#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
	/* code */
	FILE* ptr;
	ptr = fopen("Ryu_L_Punch.spr", "rb");
	unsigned char info[30];
	fread(info, sizeof(char), 30, ptr);
	for(int i = 0; i < 30; i++){
		printf("%u ",(int) info[i]);
	}
	printf("\n");
	return 0;
}