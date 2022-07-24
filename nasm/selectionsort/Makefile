OBJ := sort
ASMFLAGS := -felf64
LDFLAGS  := -no-pie

all: debug
	gcc $(LDFLAGS) -o $(OBJ) $(OBJ).o

debug:
	nasm $(ASMFLAGS) -g -F dwarf $(OBJ).asm

clean:
	rm -f $(OBJ)
	rm -f *.o

.PHONY: clean
