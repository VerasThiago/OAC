#include <stdio.h>

float proc(unsigned char *v, unsigned char i)
{
	float a;
	a= v[i]*v[i+1];
	return a;
}


void main(void)
{
	unsigned char i,v[10]={1,2,3,4,5,6,7,8,9,10};
	printf("Digite um numero:");
	scanf("%d",&i);
	printf("Resultado:%f\n",proc(v,i));
}