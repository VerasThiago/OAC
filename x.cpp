#include <stdio.h>
#define ll long long 
#define MOD 1000003

ll mult(ll a, ll b){return (a*b)%1000003;}
 
ll fat(ll n){
	ll ans = 1;
	for(int i = 2; i <= n; i++)	ans = mult(ans,i);
	return ans;
}

long long inverso(long long x){
	long long ans = 1, n = MOD - 2;
	while(n--) ans = (ans*x) % MOD;
	return ans;
}
int main(){
	ll n, k;
	scanf("%lld %lld",&n,&k);
	printf("%lld\n", mult(fat(n),inverso(fat(k)*fat(n-k))));
	return 0;
}