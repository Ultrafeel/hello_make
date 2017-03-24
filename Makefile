#.SUFFIXES:
#.SUFFIXES: .c .o

CC=gcc
CFLAGS=-c -Wall -g
#-gfull
LDFLAGS=
LIBSRCH=libhello.h libgoodbye.h 
  
SOURCES=hello.c
#OBJECTS=$(SOURCES:.c=.o)
OBJDIR:=objdir
#$(OBJDIR)/
OBJS=hello.o
LIBS1=libhello.a libgoodbye.a
LIBSO=$(LIBS1:.a=.o)
EXECUTABLE=hello
RM := rm
#all: $(OBJS) $(SOURCES)
#all: myProgram
all: main
	#echo order-only!: $(filter order-only, $(.FETAURES))
# libs


#$(SOURCES) $(EXECUTABLE)

main: $(EXECUTABLE)
#libs: libmylib.a
libs: $(LIBS1)



#myProgram: main.o libmylib.a #libmylib.a is the dependency for the executable
 #       gcc -lm -o myProgram main.o -L. -lmylib




#$(LIBS1):  -Wl,-trace-symbol=some_ref 
#	-L.-lgoodbye -L. -lhello   $(LIBSO)  $(LDFLAGS)  
$(EXECUTABLE): $(OBJS) libs  $(LIBSO)
#	$(CC)  -o $(EXECUTABLE) hello.o -L. -lhello  -L. -lgoodbye 
	$(CC)  -o $@ $(OBJS)  -v -L. -Wl,--verbose=5 -lhello  -L.  -lgoodbye 
#ld  --warn-common -Wl,-trace-symbol=fH  -L.  -lgoodbye -L. -lhello $(LDFLAGS) $(OBJS) -o $@
# -static -Wl,--warn-common 
.PHONY: clean main libs


hello.o: hello.c
	$(CC) -O -c hello.c

libhello.o: libhello.c libhello.h
	$(CC) -O -c libhello.c

libgoodbye.o: libgoodbye.c libgoodbye.h
	$(CC)  $(CFLAGS)  -O -c libgoodbye.c

#$(OBJDIR)/%.o:%.c $(LIBSRCH)
#	$(CC) -I. $(CFLAGS) -c -o $@ $<
	
#%.o:%.c $(LIBSRCH)
#	$(CC) -I. $(CFLAGS) -c -o $@ $<

libhello.a: libhello.o libhello.h #let's link library files into a static library
	ar rcsv libhello.a libhello.o

libgoodbye.a: libgoodbye.o libgoodbye.h #let's link library files into a static library
	ar rcsv libgoodbye.a libgoodbye.o

#%.a:%.o
#	@echo archiv: $@ $<
#	ar rcsv $@ $<
#$(CC) $(CFLAGS) -c -o	


#$(OBJS): | $(OBJDIR)

#$(OBJDIR):
#	mkdir $(OBJDIR)


#hello.c $(OBJDIR)/

#$(addprefix $(OBJDIR)/,hello.c)
#make --trace -w
#%.o: %.c $(OBJECTS)
#	$(CC) $(CFLAGS) $< -o $@
#	@echo objs receipe for: $<  $@

#
clean:
	@echo clean : $(OBJS)  $(EXECUTABLE) $(LIBS1)
	-$(RM)  -rfv $(OBJS)  $(EXECUTABLE)  $(LIBS1)  $(LIBSO)  *.o *.a *.gch #This way is cleaner than your clean
	
