#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
	/* code */
	FILE* ptr;
	ptr = fopen("Ryu_L_Punch.spr", "rb");
	unsigned short info[11];
	fread(info, sizeof(uint16_t), 11, ptr);
	for(int i = 0; i < 11; i++){
		printf("%hu ", info[i]);
	}
	printf("\n");
	return 0;
}