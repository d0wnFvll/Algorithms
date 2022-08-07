obj := countsort
src := countsort.c

all:
	gcc -O0 -pipe -march=native -Werror -Wall $(src) -o $(obj).noopt
	gcc -O2 -pipe -march=native -Werror -Wall $(src) -o $(obj).opt
clean:
	rm -f $(obj) >/dev/null 2>&1 || exit 0

