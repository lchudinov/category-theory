all:	monoid.o writer.o	optional.o contact.o list.o shape.o list-functor.o

monoid.o:	monoid.cpp
	clang -std=c++2a -c monoid.cpp
	
writer.o:	writer.cpp
	clang -c writer.cpp
	
optional.o:	optional.cpp
	clang -c optional.cpp

contact.o:	contact.cpp
	clang -c contact.cpp
	
list.o:	list.cpp
	clang -c list.cpp

shape.o:	shape.cpp
	clang -c shape.cpp

list-functor.o:	list-functor.cpp
	clang -c list-functor.cpp
	
	