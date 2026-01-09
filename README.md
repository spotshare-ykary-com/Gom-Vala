# Gom-Vala
Gom-Vala is Gnome Object Mapper for SQL it includes a vala API and is adapted to support GTask instead of GSimpleAsyncResult some test code and libgom.a (the static compilation of the Gom adapted). 
This is a first try to adapt the lib.

 > to compile using vala directly:
 
 valac --vapidir . -X -I/{dir_path containing gom's headers files} -X -L/{dir_path containing libgom.a} -X -lgom --pkg glib-2.0 --pkg gio-2.0 --pkg json-glib-1.0 --pkg sqlite3 main.vala gom.vapi
 
 > to compile with gcc (2 step)
 
 1. first generate the "c" code:
  
 valac --ccode --vapidir . -X -I/{dir_path containing gom's headers files} -X -L/{dir_path containing libgom.a} -X -lgom --pkg glib-2.0 --pkg gio-2.0 --pkg json-glib-1.0 --pkg sqlite3 main.vala gom.vapi
  
 2. compile the c code with gcc 
 
 gcc -I/{dir_path containing gom's headers files} -L/{dir_path containing libgom.a}   main.c -o main -lgom $(pkg-config --cflags gio-2.0 json-glib-1.0 sqlite3) $(pkg-config --libs gio-2.0 json-glib-1.0 sqlite3)
 
 > to test on linux
 
 ./main
 
 
 #### it may be easier to place all the files in the sa folder for testing purpose  #####
