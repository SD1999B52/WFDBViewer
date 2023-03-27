# WFDBViewer
## WFDBViewer.c
- int main(int argc, char *argv[]);
- void out_signal(char *name);//вывод файла на график
- void open_dialog();//открытие диалога выбора файла
- void schedule_help();//открытие диалога помощи о функциях графика
- void create_basics();//создание форм и тд.
- и тд.

# WFDBReader.h(Удален)
- объявления функций ...

# WFDBReader.c(Удален)
- int outSignal(char *name);//вывести входные сигналы
- int outAnnotation(char *name);//вывести аннотацию
- другие функции ...

# Заметки
- добавить глобальную переменную WFDB_HOME (полный путь к wfdb-10.7.0 каталогу)
- переделать диалог выбора файла с winApi на GTK3
- переделать в функциях выход по ошибке
- проверить на утечки памяти
