#=============================================================================
#Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
#Copyright (C) 2015 - Scilab-Enterprises - Cedric Delamarre
#This file is distributed under the same license as the Scilab package.
#=============================================================================

# These two environment variables must be defined
# export SCI=~/your/install/path/share/scilab
# export LD_LIBRARY_PATH=~/your/install/path/lib/scilab/
# From this directory:
# export SCI=$(pwd)/../../../../../../share/scilab
# export LD_LIBRARY_PATH=$(pwd)/../../../../../../lib/scilab/

# /!\ To avoid "undefined reference to" error with libcurl, delete it from lib/thirdparty /!\
# /!\ Only work with a release due to include and libs path /!\

CC=gcc
EXEC=bug_7601 \
	bug_7602 \
	bug_8115 \
	bug_8830 \
	bug_11394

SRC= $(EXEC:=.c)

CFLAGS= -W -Wall -Werror=implicit-function-declaration \
		-I$(SCI)/../../include/scilab/

LDFLAGS=-L$(SCI)/../../lib/scilab/ \
		-lscicall_scilab \
		-lscilab-cli

all: $(EXEC)

bug_7601: bug_7601.o
	$(CC) -o $@ $^ $(LDFLAGS)

bug_7602: bug_7602.o
	$(CC) -o $@ $^ $(LDFLAGS)

bug_8115: bug_8115.o
	$(CC) -o $@ $^ $(LDFLAGS) -lsciast

bug_8830: bug_8830.o
	$(CC) -o $@ $^ $(LDFLAGS)

bug_11394: bug_11394.o
	$(CC) -o $@ $^ $(LDFLAGS)

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

.PHONY: clean

clean:
	rm -rf *.o
	rm -rf $(EXEC)
