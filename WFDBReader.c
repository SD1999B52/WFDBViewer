#include "WFDBReader.h"

#include <stdio.h>
#include <malloc.h>
#include <wfdb/wfdb.h>

//вывести входные сигналы
int outSignal(char *name) {
	int i, j, nsig;
	WFDB_Sample *v;
	WFDB_Siginfo *s;
	
	//открытие файла сигналов
	nsig = isigopen(name, NULL, 0);
	
	if (nsig < 1) {
		//выход так как ошибка открытия
		return 1;
	}
	
	s = (WFDB_Siginfo *)malloc(nsig * sizeof(WFDB_Siginfo));
	
	if (isigopen(name, s, nsig) != nsig) {
		return 1;
	}
	
	v = (WFDB_Sample *)malloc(nsig * sizeof(WFDB_Sample));
	
	while (getvec(v) >= 0) {
    	for (j = 0; j < nsig; j++) {
    		printf("%8d", v[j]);
		}
		
		printf("\n");
	}
	
	free(v);
	free(s);
	
	return 0;
}
