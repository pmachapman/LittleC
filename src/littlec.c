/* A Little C interpreter. */

#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include <setjmp.h>
#include <math.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

#define NUM_FUNC        100
#define NUM_GLOBAL_VARS 100
#define NUM_LOCAL_VARS  200
#define NUM_BLOCK       100
#define ID_LEN          32
#define FUNC_CALLS      31
#define NUM_PARAMS      31
#define PROG_SIZE       10000
#define LOOP_NEST       31

enum tok_types {
	DELIMITER, IDENTIFIER, NUMBER, KEYWORD,
	TEMP, STRING, BLOCK
};

/* add additional C keyword tokens here */
enum tokens {
	ARG, CHAR, INT, IF, ELSE, FOR, DO, WHILE,
	SWITCH, RETURN, CONTINUE, BREAK, EOL, FINISHED, END
};

/* add additional double operators here (such as ->) */
enum double_ops { LT = 1, LE, GT, GE, EQ, NE };

/* These are the constants used to call sntx_err() when
   a syntax error occurs. Add more if you like.
   NOTE: SYNTAX is a generic error message used when
   nothing else seems appropriate.
*/
enum error_msg
{
	SYNTAX, UNBAL_PARENS, NO_EXP, EQUALS_EXPECTED,
	NOT_VAR, PARAM_ERR, SEMI_EXPECTED,
	UNBAL_BRACES, FUNC_UNDEF, TYPE_EXPECTED,
	NEST_FUNC, RET_NOCALL, PAREN_EXPECTED,
	WHILE_EXPECTED, QUOTE_EXPECTED, NOT_TEMP,
	TOO_MANY_LVARS, DIV_BY_ZERO
};

char *prog;    /* current location in source code */
char *p_buf;   /* points to start of program buffer */
jmp_buf e_buf; /* hold environment for longjmp() */

/* An array of these structures will hold the info
   associated with global variables.
*/
struct var_type {
	char var_name[ID_LEN];
	int v_type;
	int value;
}  global_vars[NUM_GLOBAL_VARS];

struct var_type local_var_stack[NUM_LOCAL_VARS];

struct func_type {
	char func_name[ID_LEN];
	int ret_type;
	char *loc;  /* location of entry point in file */
} func_table[NUM_FUNC];

int call_stack[NUM_FUNC];

struct commands { /* keyword lookup table */
	char command[20];
	char tok;
} table[] = { /* Commands must be entered lowercase */
	{ "if", IF }, /* in this table. */
	{ "else", ELSE },
	{ "for", FOR },
	{ "do", DO },
	{ "while", WHILE },
	{ "char", CHAR },
	{ "int", INT },
	{ "return", RETURN },
	{ "continue", CONTINUE },
	{ "break", BREAK },
	{ "end", END },
	{ "", END } /* mark end of table */
};

char token[80];
char token_type, tok;

int functos;  /* index to top of function call stack */
int func_index; /* index into function table */
int gvar_index; /* index into global variable table */
int lvartos; /* index into local variable stack */

int ret_value; /* function return value */
int ret_occurring; /* function return is occurring */
int break_occurring; /* loop break is occurring */

void print(void), prescan(void);
void decl_global(void), call(void), putback(void);
void decl_local(void), local_push(struct var_type i);
void eval_exp(int *value), sntx_err(int error);
void exec_if(void), find_eob(void), exec_for(void);
void get_params(void), get_args(void);
void exec_while(void), func_push(int i), exec_do(void);
void assign_var(char *var_name, int value);
int load_program(char *p, char *fname), find_var(char *s);
void interp_block(void), func_ret(void);
int func_pop(void), is_var(char *s);
char *find_func(char *name), get_token(void);

int main(int argc, char *argv[])
{
	if (argc != 2) {
		printf("Usage: littlec <filename>\n");
		exit(1);
	}

	/* allocate memory for the program */
	if ((p_buf = (char *)malloc(PROG_SIZE)) == NULL) {
		printf("Allocation Failure");
		exit(1);
	}

	/* load the program to execute */
	if (!load_program(p_buf, argv[1])) exit(1);
	if (setjmp(e_buf)) exit(1); /* initialize long jump buffer */

	gvar_index = 0;  /* initialize global variable index */

	/* set program pointer to start of program buffer */
	prog = p_buf;
	prescan(); /* find the location of all functions
				  and global variables in the program */

	lvartos = 0;     /* initialize local variable stack index */
	functos = 0;     /* initialize the CALL stack index */
	break_occurring = 0; /* initialize the break occurring flag */

	/* setup call to main() */
	prog = find_func("main"); /* find program starting point */

	if (!prog) { /* incorrect or missing main() function in program */
		printf("main() not found.\n");
		exit(1);
	}

	prog--; /* back up to opening ( */
	strcpy(token, "main");
	call(); /* call main() to start interpreting */

	return 0;
}

/* Interpret a single statement or block of code. When
   interp_block() returns from its initial call, the final
   brace (or a return) in main() has been encountered.
*/
void interp_block(void)
{
	int value;
	char block = 0;

	do {
		token_type = get_token();

		/* If interpreting single statement, return on
		   first semicolon.
		*/

		/* see what kind of token is up */
		if (token_type == IDENTIFIER) {
			/* Not a keyword, so process expression. */
			putback();  /* restore token to input stream for
						   further processing by eval_exp() */
			eval_exp(&value);  /* process the expression */
			if (*token != ';') sntx_err(SEMI_EXPECTED);
		}
		else if (token_type == BLOCK) { /* if block delimiter */
			if (*token == '{') /* is a block */
				block = 1; /* interpreting block, not statement */
			else return; /* is a }, so return */
		}
		else /* is keyword */
			switch (tok) {
			case CHAR:
			case INT:     /* declare local variables */
				putback();
				decl_local();
				break;
			case RETURN:  /* return from function call */
				func_ret();
				ret_occurring = 1;
				return;
			case CONTINUE:  /* continue loop execution */
				return;
			case BREAK:  /* break loop execution */
				break_occurring = 1;
				return;
			case IF:      /* process an if statement */
				exec_if();
				if (ret_occurring > 0 || break_occurring > 0) {
					return;
				}
				break;
			case ELSE:    /* process an else statement */
				find_eob(); /* find end of else block and continue execution */
				break;
			case WHILE:   /* process a while loop */
				exec_while();
				if (ret_occurring > 0) {
					return;
				}
				break;
			case DO:      /* process a do-while loop */
				exec_do();
				if (ret_occurring > 0) {
					return;
				}
				break;
			case FOR:     /* process a for loop */
				exec_for();
				if (ret_occurring > 0) {
					return;
				}
				break;
			case END:
				exit(0);
			}
	} while (tok != FINISHED && block);
}

/* Load a program. */
int load_program(char *p, char *fname)
{
	FILE *fp;
	int i;

	if ((fp = fopen(fname, "rb")) == NULL) return 0;

	i = 0;
	do {
		*p = (char)getc(fp);
		p++; i++;
	} while (!feof(fp) && i < PROG_SIZE);

	if (*(p - 2) == 0x1a) *(p - 2) = '\0'; /* null terminate the program */
	else *(p - 1) = '\0';
	fclose(fp);
	return 1;
}

/* Find the location of all functions in the program
   and store global variables. */
void prescan(void)
{
	char *p, *tp;
	char temp[ID_LEN + 1];
	int datatype;
	int brace = 0;  /* When 0, this var tells us that
					   current source position is outside
					   of any function. */

	p = prog;
	func_index = 0;
	do {
		while (brace) {  /* bypass code inside functions */
			get_token();
			if (*token == '{') brace++;
			if (*token == '}') brace--;
		}

		tp = prog; /* save current position */
		get_token();
		/* global var type or function return type */
		if (tok == CHAR || tok == INT) {
			datatype = tok; /* save data type */
			get_token();
			if (token_type == IDENTIFIER) {
				strcpy(temp, token);
				get_token();
				if (*token != '(') { /* must be global var */
					prog = tp; /* return to start of declaration */
					decl_global();
				}
				else if (*token == '(') {  /* must be a function */
					func_table[func_index].loc = prog;
					func_table[func_index].ret_type = datatype;
					strcpy(func_table[func_index].func_name, temp);
					func_index++;
					while (*prog != ')') prog++;
					prog++;
					/* now prog points to opening curly
					   brace of function */
				}
				else putback();
			}
		}
		else if (*token == '{') brace++;
	} while (tok != FINISHED);
	prog = p;
}

/* Return the entry point of the specified function.
   Return NULL if not found.
*/
char *find_func(char *name)
{
	register int i;

	for (i = 0; i < func_index; i++)
		if (!strcmp(name, func_table[i].func_name))
			return func_table[i].loc;

	return NULL;
}

/* Declare a global variable. */
void decl_global(void)
{
	int vartype;

	get_token();  /* get type */

	vartype = tok; /* save var type */

	do { /* process comma-separated list */
		global_vars[gvar_index].v_type = vartype;
		global_vars[gvar_index].value = 0;  /* init to 0 */
		get_token();  /* get name */
		strcpy(global_vars[gvar_index].var_name, token);
		get_token();
		gvar_index++;
	} while (*token == ',');
	if (*token != ';') sntx_err(SEMI_EXPECTED);
}

/* Declare a local variable. */
void decl_local(void)
{
	struct var_type i;

	get_token();  /* get type */

	i.v_type = tok;
	i.value = 0;  /* init to 0 */

	do { /* process comma-separated list */
		get_token(); /* get var name */
		strcpy(i.var_name, token);
		local_push(i);
		get_token();
	} while (*token == ',');
	if (*token != ';') sntx_err(SEMI_EXPECTED);
}

/* Call a function. */
void call(void)
{
	char *loc, *temp;
	int lvartemp;

	loc = find_func(token); /* find entry point of function */
	if (loc == NULL)
		sntx_err(FUNC_UNDEF); /* function not defined */
	else {
		lvartemp = lvartos;  /* save local var stack index */
		get_args();  /* get function arguments */
		temp = prog; /* save return location */
		func_push(lvartemp);  /* save local var stack index */
		prog = loc;  /* reset prog to start of function */
		ret_occurring = 0; /* P the return occurring variable */
		get_params(); /* load the function's parameters with the values of the arguments */
		interp_block(); /* interpret the function */
		ret_occurring = 0; /* Clear the return occurring variable */
		prog = temp; /* reset the program pointer */
		lvartos = func_pop(); /* reset the local var stack */
	}
}

/* Push the arguments to a function onto the local
   variable stack. */
void get_args(void)
{
	int value, count, temp[NUM_PARAMS];
	struct var_type i;

	count = 0;
	get_token();
	if (*token != '(') sntx_err(PAREN_EXPECTED);

	/* process a comma-separated list of values */
	do {
		eval_exp(&value);
		temp[count] = value;  /* save temporarily */
		get_token();
		count++;
	} while (*token == ',');
	count--;
	/* now, push on local_var_stack in reverse order */
	for (; count >= 0; count--) {
		i.value = temp[count];
		i.v_type = ARG;
		local_push(i);
	}
}

/* Get function parameters. */
void get_params(void)
{
	struct var_type *p;
	int i;

	i = lvartos - 1;
	do { /* process comma-separated list of parameters */
		get_token();
		p = &local_var_stack[i];
		if (*token != ')') {
			if (tok != INT && tok != CHAR)
				sntx_err(TYPE_EXPECTED);

			p->v_type = token_type;
			get_token();

			/* link parameter name with argument already on
			   local var stack */
			strcpy(p->var_name, token);
			get_token();
			i--;
		}
		else break;
	} while (*token == ',');
	if (*token != ')') sntx_err(PAREN_EXPECTED);
}

/* Return from a function. */
void func_ret(void)
{
	int value;

	value = 0;
	/* get return value, if any */
	eval_exp(&value);

	ret_value = value;
}

/* Push a local variable. */
void local_push(struct var_type i)
{
	if (lvartos >= NUM_LOCAL_VARS) {
		sntx_err(TOO_MANY_LVARS);
	}
	else {
		local_var_stack[lvartos] = i;
		lvartos++;
	}
}

/* Pop index into local variable stack. */
int func_pop(void)
{
	int index = 0;
	functos--;
	if (functos < 0) {
		sntx_err(RET_NOCALL);
	}
	else if (functos >= NUM_FUNC) {
		sntx_err(NEST_FUNC);
	}
	else {
		index = call_stack[functos];
	}

	return index;
}

/* Push index of local variable stack. */
void func_push(int i)
{
	if (functos >= NUM_FUNC) {
		sntx_err(NEST_FUNC);
	}
	else {
		call_stack[functos] = i;
		functos++;
	}
}

/* Assign a value to a variable. */
void assign_var(char *var_name, int value)
{
	register int i;

	/* first, see if it's a local variable */
	for (i = lvartos - 1; i >= call_stack[functos - 1]; i--) {
		if (!strcmp(local_var_stack[i].var_name, var_name)) {
			local_var_stack[i].value = value;
			return;
		}
	}
	if (i < call_stack[functos - 1])
		/* if not local, try global var table */
		for (i = 0; i < NUM_GLOBAL_VARS; i++)
			if (!strcmp(global_vars[i].var_name, var_name)) {
				global_vars[i].value = value;
				return;
			}
	sntx_err(NOT_VAR); /* variable not found */
}

/* Find the value of a variable. */
int find_var(char *s)
{
	register int i;

	/* first, see if it's a local variable */
	for (i = lvartos - 1; i >= call_stack[functos - 1]; i--)
		if (!strcmp(local_var_stack[i].var_name, token))
			return local_var_stack[i].value;

	/* otherwise, try global vars */
	for (i = 0; i < NUM_GLOBAL_VARS; i++)
		if (!strcmp(global_vars[i].var_name, s))
			return global_vars[i].value;

	sntx_err(NOT_VAR); /* variable not found */
	return -1;
}

/* Determine if an identifier is a variable. Return
   1 if variable is found; 0 otherwise.
*/
int is_var(char *s)
{
	register int i;

	/* first, see if it's a local variable */
	for (i = lvartos - 1; i >= call_stack[functos - 1]; i--)
		if (!strcmp(local_var_stack[i].var_name, token))
			return 1;

	/* otherwise, try global vars */
	for (i = 0; i < NUM_GLOBAL_VARS; i++)
		if (!strcmp(global_vars[i].var_name, s))
			return 1;

	return 0;
}

/* Execute an if statement. */
void exec_if(void)
{
	int cond;

	eval_exp(&cond); /* get if expression */

	if (cond) { /* is true so process target of IF */
		interp_block();
	}
	else { /* otherwise skip around IF block and
		   process the ELSE, if present */
		find_eob(); /* find start of next line */
		get_token();

		if (tok != ELSE) {
			putback();  /* restore token if
						   no ELSE is present */
			return;
		}
		interp_block();
	}
}

/* Execute a while loop. */
void exec_while(void)
{
	int cond;
	char *temp;

	break_occurring = 0; /* clear the break flag */
	putback();
	temp = prog;  /* save location of top of while loop */
	get_token();
	eval_exp(&cond);  /* check the conditional expression */
	if (cond) {
		interp_block();  /* if true, interpret */
		if (break_occurring > 0) {
			break_occurring = 0;
			return;
		}
	}
	else {  /* otherwise, skip around loop */
		find_eob();
		return;
	}
	prog = temp;  /* loop back to top */
}

/* Execute a do loop. */
void exec_do(void)
{
	int cond;
	char *temp;

	putback();
	temp = prog;  /* save location of top of do loop */
	break_occurring = 0; /* clear the break flag */

	get_token(); /* get start of loop */
	interp_block(); /* interpret loop */
	if (ret_occurring > 0) {
		return;
	}
	else if (break_occurring > 0) {
		break_occurring = 0;
		return;
	}
	get_token();
	if (tok != WHILE) sntx_err(WHILE_EXPECTED);
	eval_exp(&cond); /* check the loop condition */
	if (cond) prog = temp; /* if true loop; otherwise,
							 continue on */
}

/* Find the end of a block. */
void find_eob(void)
{
	int brace;

	get_token();
	brace = 1;
	do {
		get_token();
		if (*token == '{') brace++;
		else if (*token == '}') brace--;
	} while (brace);
}

/* Execute a for loop. */
void exec_for(void)
{
	int cond;
	char *temp, *temp2;
	int brace;

	break_occurring = 0; /* clear the break flag */
	get_token();
	eval_exp(&cond);  /* initialization expression */
	if (*token != ';') sntx_err(SEMI_EXPECTED);
	prog++; /* get past the ; */
	temp = prog;
	for (;;) {
		eval_exp(&cond);  /* check the condition */
		if (*token != ';') sntx_err(SEMI_EXPECTED);
		prog++; /* get past the ; */
		temp2 = prog;

		/* find the start of the for block */
		brace = 1;
		while (brace) {
			get_token();
			if (*token == '(') brace++;
			if (*token == ')') brace--;
		}

		if (cond) {
			interp_block();  /* if true, interpret */
			if (ret_occurring > 0) {
				return;
			}
			else if (break_occurring > 0) {
				break_occurring = 0;
				return;
			}
		}
		else {  /* otherwise, skip around loop */
			find_eob();
			return;
		}
		prog = temp2;
		eval_exp(&cond); /* do the increment */
		prog = temp;  /* loop back to top */
	}
}
