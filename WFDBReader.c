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

//вывести аннотацию
int outAnnotation(char *name) {
	WFDB_Anninfo a;
	WFDB_Annotation annot;
	
	//количество WFDB_Anninfo структур в массиве
	a.name = "atr";
	a.stat = WFDB_READ;
	
	//1 - это количество WFDB_Anninfo структур
	//WFDB_Anninfo может быть массив
	if (annopen(name, &a, 1) < 0) {
		//выход так как ошибка открытия
		return 1;
	}
	
	while (getann(0, &annot) == 0) {
		char *time = mstimstr(annot.time);
		char *code = annstr(annot.anntyp);
		
		printf("%s %s\n", time, code);
	}
	
	return 0;
}
