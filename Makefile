CXX ?= g++
CC ?= gcc
CFLAGS = -Wall -Wconversion -O3 -fPIC
LIBS = blas/blas.a
SHVER = 1
OS = $(shell uname)
#LIBS = -lblas

PREFIX ?= /usr/local

all: train predict lib

lib: linear.o tron.o blas/blas.a
	if [ "$(OS)" = "Darwin" ]; then \
		LIBEXT=".dylib"; \
		SHARED_LIB_FLAG="-dynamiclib -install_name $(PREFIX)/lib/liblinear$${LIBEXT}"; \
	else \
		LIBEXT=".so.$(SHVER)"; \
		SHARED_LIB_FLAG="-shared -Wl,-soname,liblinear$${LIBEXT}"; \
	fi; \
	$(CXX) $${SHARED_LIB_FLAG} linear.o tron.o blas/blas.a -o liblinear$${LIBEXT}

train: tron.o linear.o train.c blas/blas.a eval.o
	$(CXX) $(CFLAGS) -o train train.c tron.o eval.o linear.o $(LIBS)

predict: tron.o linear.o predict.c blas/blas.a eval.o
	$(CXX) $(CFLAGS) -o predict predict.c tron.o eval.o linear.o $(LIBS)

eval.o: eval.h eval.cpp
	$(CXX) $(CFLAGS) -c -o eval.o eval.cpp

tron.o: tron.cpp tron.h
	$(CXX) $(CFLAGS) -c -o tron.o tron.cpp

linear.o: linear.cpp linear.h
	$(CXX) $(CFLAGS) -c -o linear.o linear.cpp

blas/blas.a: blas/*.c blas/*.h
	make -C blas OPTFLAGS='$(CFLAGS)' CC='$(CC)';

clean:
	make -C blas clean
	make -C matlab clean
	rm -f *~ tron.o eval.o linear.o train predict liblinear.*
