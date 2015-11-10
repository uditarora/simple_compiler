# About
A simple compiler made for the final project of a class on Compiler construction using the Lex and Yacc tools. Converts a simple language to MIPS assembly code using a stack machine with accumulator model.

# Compilation
Compile the code using -
```bash
$ yacc -d lang.y
$ lex lang.l
$ gcc -ll y.tab.c -o ucc
```

# Usage
```bash
$ ./ucc {input_filename} {output_filename}
# OR
$ ./ucc {input_filename}
# OR
$ ./ucc
```

If both the input_filename and output_filename are entered, the source code is read from input file, and the output MIPS assembly code is saved in the output file.
If no output_filename is given, the output is saved by default in 'out.s'.
If no input_filename is given, input is read from STDIN and output is saved in 'out.s'.

The MIPS assembly code generated has been tested on the SPIM simulator.

# Examples

```bash
$ ./ucc prog1.txt prog1.s
$ ./ucc prog2.txt prog2.s
$ ./ucc prog3.txt prog3.s
```

* 'prog1.txt' demonstrates the evaluation of arithmetic expressions.
* 'prog2.txt' calculates the sum of even and odd numbers upto 'n' (input from user), and prints them.
* 'prog3.txt' calculates the factorial of the number entered by the user, and prints it.

# TODO
* Add support for 'if' blocks without matching 'else'
* Add support for LSHIFT, RSHIFT and POW operators.
* Add support for functions.
