#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <windows.h>
#include <malloc.h>
#include <wfdb/wfdb.h>   
#include <time.h> 

#include <gtk/gtk.h>
#include <gdk/gdkkeysyms.h>

#include <gtkdatabox.h>
#include <gtkdatabox_points.h>
#include <gtkdatabox_ruler.h>

#define POINTS 2000

GtkWidget *box;

//генерация числа от min до max
double randfrom(double min, double max) {
	double range = (max - min); 
	double div = RAND_MAX / range;
	
	return min + (rand() / div);
}

//вывод файла на график
void out_signal(char *name) {
	WFDB_Sample *v;
	WFDB_Siginfo *s;
	
	gfloat *x;
	gfloat *y;
	
	GtkDataboxGraph *graph;
	
	//открытие файла сигналов
	//и получаем количество записей
	int nsig = isigopen(name, NULL, 0);
	
	if (nsig < 1) {
		//выход так как ошибка открытия
	}
	
	//очистка box
	gtk_databox_graph_remove_all(GTK_DATABOX(box));
	
	//для отрисовки всех сигналов
	for (int i = 0; i < nsig; i++) {
		s = (WFDB_Siginfo *)malloc(nsig * sizeof(WFDB_Siginfo));
		
		if (isigopen(name, s, nsig) != nsig) {
			//выход так как ошибка
		}
		
		v = (WFDB_Sample *)malloc(nsig * sizeof(WFDB_Sample));
		
		x = g_new0(gfloat, POINTS);
		y = g_new0(gfloat, POINTS);
		
		GdkRGBA color;
		color.red = randfrom(0.0, 1.0);
		color.green = randfrom(0.0, 1.0);
		color.blue = randfrom(0.0, 1.0);
		color.alpha = 1;
		
		for (int j = 0; j < POINTS; j++) {
			getvec(v);
			
			x[j] = j;
			y[j] = (v[i] - 1000) * 0.01;
		}
		
		//тут обратить внимание
		graph = gtk_databox_lines_new(POINTS, x, y, &color, 1);
		gtk_databox_graph_add(GTK_DATABOX(box), graph);
		gtk_databox_auto_rescale(GTK_DATABOX(box), 0.05);
		
		//очистка памяти динамических массивов
		free(v);
		free(s);
	}
	
	//завершаем работу с WFDB
	wfdbquit();
}

//открытие диалога выбора файла
void open_dialog() {
	OPENFILENAME ofn;
	ZeroMemory(&ofn, sizeof(ofn));
	
	char fileName[MAX_PATH] = "";
	
	ofn.lStructSize = sizeof(OPENFILENAME);
	ofn.hwndOwner = NULL;
	ofn.lpstrFilter = "WFDBFiles (*.atr *.dat *.hea)\0*.atr;*.dat;*.hea\0";
	ofn.lpstrFile = fileName;
	ofn.nMaxFile = MAX_PATH;
	ofn.Flags = OFN_EXPLORER | OFN_FILEMUSTEXIST | OFN_HIDEREADONLY;
	ofn.lpstrDefExt = "";
	
	if (GetOpenFileName(&ofn)) {
		WIN32_FIND_DATA findFileData;
		FindFirstFile(fileName, &findFileData);
		
		char *name = findFileData.cFileName;
		
		//убрать расширение
		for (int i = 0; name[i] != '\0'; i++) {
			if (name[i] == '.') {
				name[i] = '\0';
				
				break;
			}
		}
		
		out_signal(name);
	}
}

//открытие диалога помощи о функциях графика
void schedule_help() {
    //This creates (but does not yet display) a message dialog with
    //the given text as the title.
    GtkWidget *message = gtk_message_dialog_new(NULL, GTK_DIALOG_MODAL, 
	GTK_MESSAGE_INFO, GTK_BUTTONS_OK, "Помощь по графику!");
	
    //The (optional) secondary text shows up in the "body" of the
    //dialog. Note that printf-style formatting is available.
    //gtk_message_dialog_format_secondary_text(GTK_MESSAGE_DIALOG(help), 
	//"This is secondary text with printf-style formatting: %d", 99);
	gtk_message_dialog_format_secondary_text(GTK_MESSAGE_DIALOG(message), 
"Код для этого примера демонстрирует самый простой способ \
использования виджета GtkDatabox.\n\nПрименение:\nНарисуйте \
выделение с нажатой левой кнопкой, \nзатем щелкните выделение.\
\nИспользуйте правую кнопку мыши, чтобы уменьшить масштаб.\
\nShift+правая кнопка мыши увеличивает масштаб по умолчанию.\
\n\nКолесо прокрутки мыши: \n*Удерживая Ctrl+колесо прокрутки, \
увеличивает/уменьшает масштаб. \nКолесо прокрутки перемещается \
вверх/вниз. \n*Удерживая Shift+, колесо прокрутки перемещается \
влево/вправо по графику.");
	
    // This displays our message dialog as a modal dialog, waiting for
    // the user to click a button before moving on. The return value
    // comes from the :response signal emitted by the dialog. By
    // default, the dialog only has an OK button, so we'll get a
    // GTK_RESPONSE_OK if the user clicked the button. But if the user
    // destroys the window, we'll get a GTK_RESPONSE_DELETE_EVENT.
    int response = gtk_dialog_run(GTK_DIALOG(message));
	
	//тема полезная для отладки
    printf("response was %d (OK=%d, DELETE_EVENT=%d)\n", 
	response, GTK_RESPONSE_OK, GTK_RESPONSE_DELETE_EVENT);
	
    // If we don't destroy the dialog here, it will still be displayed
    // (in back) when the second dialog below is run.
    gtk_widget_destroy(message);
}

void create_basics() {
	GtkWidget *window;
	GtkWidget *vbox;
	GtkWidget *menubar;
	GtkWidget *fileMenu;
	GtkWidget *helpMenu;
	GtkWidget *fileMi;
	GtkWidget *helpMi;
	GtkWidget *openMi;
	GtkWidget *quitMi;
	GtkWidget *scheMi;
	GtkWidget *close_button;
	GtkWidget *separator;
	GtkWidget *table;
	
	window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
	gtk_widget_set_size_request(window, 500, 500);
	
	g_signal_connect(G_OBJECT(window), "destroy", 
	G_CALLBACK(gtk_main_quit), NULL);
	
	gtk_window_set_title(GTK_WINDOW(window), "WDTFViewer");
	gtk_container_set_border_width(GTK_CONTAINER(window), 0);
	
	vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
	gtk_container_add(GTK_CONTAINER(window), vbox);
	
	//создание бара меню (приколы с кодировкой, перевести файл в utf8)
	menubar = gtk_menu_bar_new();
	fileMenu = gtk_menu_new();
	helpMenu = gtk_menu_new();
	
	fileMi = gtk_menu_item_new_with_label("Файл");
	helpMi = gtk_menu_item_new_with_label("Справка");
	
	openMi = gtk_menu_item_new_with_label("Открыть");
	quitMi = gtk_menu_item_new_with_label("Выйти");
	
	scheMi = gtk_menu_item_new_with_label("График");
	
	gtk_menu_item_set_submenu(GTK_MENU_ITEM(fileMi), fileMenu);
	gtk_menu_item_set_submenu(GTK_MENU_ITEM(helpMi), helpMenu);
	
	gtk_menu_shell_append(GTK_MENU_SHELL(fileMenu), openMi);
	gtk_menu_shell_append(GTK_MENU_SHELL(fileMenu), quitMi);
	
	gtk_menu_shell_append(GTK_MENU_SHELL(helpMenu), scheMi);
	
	gtk_menu_shell_append(GTK_MENU_SHELL(menubar), fileMi);
	gtk_menu_shell_append(GTK_MENU_SHELL(menubar), helpMi);
	
	gtk_box_pack_start(GTK_BOX(vbox), menubar, FALSE, FALSE, 0);
	
	//добавление событий на пункты меню
	g_signal_connect(G_OBJECT(quitMi), "activate", 
	G_CALLBACK(gtk_main_quit), NULL);
	g_signal_connect(G_OBJECT(scheMi), "activate", 
	G_CALLBACK(schedule_help), NULL);
	g_signal_connect(G_OBJECT(openMi), "activate", 
	G_CALLBACK(open_dialog), NULL);
	
	separator = gtk_separator_new(GTK_ORIENTATION_HORIZONTAL);
	gtk_box_pack_start(GTK_BOX(vbox), separator, FALSE, FALSE, 0);
	
	/*----------------------------------------------------------------
	This is all you need:
	----------------------------------------------------------------*/
	
	/* Create the GtkDatabox widget */
	gtk_databox_create_box_with_scrollbars_and_rulers(&box, &table, 
	TRUE, TRUE, TRUE, TRUE);
	
	/* Put it somewhere */
	gtk_box_pack_start(GTK_BOX(vbox), table, TRUE, TRUE, 0);
	
	gtk_databox_set_total_limits(GTK_DATABOX(box), -1000., 5000., 
	-10000., 23000.);
	gtk_databox_auto_rescale(GTK_DATABOX(box), 0.05);
	
	/*---------------------------------------------------------------
	Done
	---------------------------------------------------------------*/
	
	separator = gtk_separator_new(GTK_ORIENTATION_HORIZONTAL);
	gtk_box_pack_start(GTK_BOX(vbox), separator, FALSE, TRUE, 0);
	
	close_button = gtk_button_new_with_label("Закрыть");
	g_signal_connect_swapped(G_OBJECT(close_button), "clicked", 
	G_CALLBACK(gtk_main_quit), G_OBJECT(box));
	gtk_box_pack_start(GTK_BOX(vbox), close_button, FALSE, FALSE, 0);
	gtk_widget_set_can_default(close_button, TRUE);
	gtk_widget_grab_default(close_button);
	gtk_widget_grab_focus(close_button);
	
	gtk_widget_show_all(window);
	gdk_window_set_cursor(gtk_widget_get_window(box), 
	gdk_cursor_new_for_display(gdk_display_get_default(), GDK_CROSS));
}

int main(int argc, char *argv[]) {
	srand(time(0));
	
	gtk_init(&argc, &argv);
	
	create_basics();
	gtk_main();
    
    return 0;
}
