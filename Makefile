all:	monoid.o writer.o	optional.o contact.o

monoid.o:	monoid.cpp
	clang -std=c++2a -c monoid.cpp
	
writer.o:	writer.cpp
	clang -c writer.cpp
	
optional.o:	optional.cpp
	clang -c optional.cpp

contact.o:	contact.cpp
	clang -c contact.cpp
	
	