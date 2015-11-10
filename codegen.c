/*
	Developed By: Udit Arora
*/

// Output initial instructions and definitions
void initialize_out() {
	fprintf(yyout, ".data\n");
	fprintf(yyout, "vars: .word 0:26\n");
	fprintf(yyout, "prompt: .asciiz	\"Input: \"\n");
	fprintf(yyout, ".text\n");
	fprintf(yyout, ".globl main\n");
	fprintf(yyout, "main:\n");
}

void print_instr(char* str) {
	fprintf(yyout, "\t%s\n", str);
}

void push(int val) {
	stack[st_top++] = val;
}
int get_top() {
	return stack[st_top-1];
}
void pop() {
	st_top--;
}

// Push $a0 onto stack
void cgen_push() {
	print_instr("sw $a0 0($sp)");
	print_instr("addiu $sp $sp -4");
}
// Pop from stack
void cgen_pop() {
	print_instr("addiu $sp $sp 4");
}

void cgen_int() {
	char str[100];
	// Load immediate with INT value
	sprintf(str, "li $a0 %d", yylval);
	print_instr(str);
}
void cgen_var() {
	char str[100];
	// Load address of vars array and load appropriate variable word in $a0
	print_instr("la $t0 vars");
	sprintf(str, "lw $a0 %d($t0)", 4*yylval);
	print_instr(str);
}
// Generate code for assignment
void cgen_assign(int var_id) {
	char str[100];
	// Load address of vars array
	print_instr("la $t0 vars");

	// Store value at $a0 at the appropriate location in array
	sprintf(str, "sw $a0 %d($t0)", 4*var_id);
	print_instr(str);
	vars[var_id] = get_top();
}
// Generate code for printing a value
void cgen_print() {
	// Print value
	print_instr("li $v0 1");
	print_instr("syscall");

	// Store $a0 in temp reg
	print_instr("move $t0 $a0");

	// Print newline
	print_instr("li $v0 11");
	print_instr("li $a0 10");
	print_instr("syscall");

	// Load $a0 from temp reg
	print_instr("move $a0 $t0");
}
// Generate code for reading an input into a variable
void cgen_input(int var_id) {
	print_instr("move $t1 $a0");

	// Syscall to print input prompt
	print_instr("li	$v0 4");
	print_instr("la	$a0 prompt");
	print_instr("syscall");

	// Syscall for read integer
	print_instr("li $v0 5");
	print_instr("syscall");

	char str[100];
	// Load address of vars array
	print_instr("la $t0 vars");

	// Store value at $v0 from input at the appropriate location in array
	sprintf(str, "sw $v0 %d($t0)", 4*var_id);
	print_instr(str);
	vars[var_id] = get_top();
	print_instr("move $a0 $t1");
}

// Multiply $a0 by -1
void cgen_neg() {
	print_instr("li $t0 -1");
	print_instr("mul $a0 $a0 $t0");
}

// Perform binary operation between two operands
void cgen_binop(char op) {
	// Operate value in $a0 with value on top of stack
	print_instr("lw $t0 4($sp)");
	cgen_pop();
	char str[100] = "\0";
	switch (op) {
		case '+':
			sprintf(str, "add");
			break;
		case '-':
			sprintf(str, "sub");
			break;
		case '*':
			sprintf(str, "mul");
			break;
		case '&':
			sprintf(str, "and");
			break;
		case '|':
			sprintf(str, "or");
			break;
	}
	strcat(str, " $a0 $t0 $a0");
	print_instr(str);
}
// Perform devision between two operands
void cgen_div() {
	// Operate value in $a0 with value on top of stack
	print_instr("lw $t0 4($sp)");
	cgen_pop();
	print_instr("div $t0 $a0");
	print_instr("mflo $a0");
}

// Store 1 in $a0 if true, 0 if false
void cgen_relop(char *op, int num) {
	print_instr("lw $t0 4($sp)");
	cgen_pop();
	print_instr("move $t1 $a0");
	print_instr("li $a0 1");
	char str[100] = "\0";
	if (strcmp(op, "<") == 0) {
		sprintf(str, "blt $t0 $t1 SKIP%d", num);
	}
	else if (strcmp(op, "<=") == 0) {
		sprintf(str, "ble $t0 $t1 SKIP%d", num);
	}
	else if (strcmp(op, ">") == 0) {
		sprintf(str, "bgt $t0 $t1 SKIP%d", num);
	}
	else if (strcmp(op, ">=") == 0) {
		sprintf(str, "bge $t0 $t1 SKIP%d", num);
	}
	else if (strcmp(op, "==") == 0) {
		sprintf(str, "beq $t0 $t1 SKIP%d", num);
	}
	else if (strcmp(op, "!=") == 0) {
		sprintf(str, "bne $t0 $t1 SKIP%d", num);
	}
	print_instr(str);
	print_instr("li $a0 0");
	fprintf(yyout, "SKIP%d:\n", num);
}

// Generate code for if
void cgen_if(int num) {
	// Load 0 in $t0 to compare with $a0 containing boolean value of expr
	print_instr("li $t0 0");
	char str[100];
	sprintf(str, "beq $a0 $t0 END_IF%d", num);
	print_instr(str);
}
// Generate code for if-else block
void cgen_ifelse(int num) {
	// Load 0 in $t0 to compare with $a0 containing boolean value of expr
	print_instr("li $t0 0");
	char str[100];
	sprintf(str, "beq $a0 $t0 ELSE%d", num);
	print_instr(str);
}

// Generate code for loop block
void cgen_loop(int num) {
	char str[100];
	sprintf(str, "j LOOP%d", num);
	print_instr(str);
}

// Generate code for loop condition
void cgen_loop_condition(int num) {
	print_instr("li $t0 0");
	char str[100];
	sprintf(str, "beq $a0 $t0 END_LOOP%d", num);
	print_instr(str);
}