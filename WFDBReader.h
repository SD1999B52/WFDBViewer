/*-------------------------------------------------------
 gcc -c WFDBReader.c -o WFDBReader.o -I/usr/local/include
-------------------------------------------------------*/

#ifndef WFDBREADER_H
#define WFDBREADER_H

//вывести входные сигналы
int outSignal(char *name);
//вывести аннотацию
int outAnnotation(char *name);

#endif /*WFDBREADER_H*/
