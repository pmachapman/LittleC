# Little C
The Little C Interpreter from Herbert Schildt's C: The Complete Reference (4th Ed.)

## Specifications
The following features are implemented:

 * Parameterized functions with local variables
 * Recursion
 * The **if** statement
 * The **do-while**, **while**, and **for** loops
 * Local and global variables of type **int** and **char**
 * Function parameters of type **int** and **char**
 * Integer and character constants
 * String constants (limited implementation)
 * The return statement, both with and without a value
 * A limited number of standard library functions
 * These operators: +, –, *, /, %, <, >, <=, >=, ==, !=, unary –, and unary +
 * Functions returning integers
 * /* ... */-style comments

## Restrictions

The targets of **if**, **while**, **do**, and **for** must be blocks of code surrounded by beginning and ending curly braces. You cannot use a single statement. For example, code such as this will not correctly interpreted:

```C
for(a=0; a < 10; a=a+1)
  for(b=0; b < 10; b=b+1)
    for(c=0; c < 10; c=c+1)
      puts ("hi");

if(a=c)
  if(a=b) x = 10;
```

Instead, you must write the code like this:

```C
for(a=0; a < 10; a=a+1) {
  for(b=0; b < 10; b=b+1) {
    for(c=0; c < 10; c=c+1) {
      puts("hi");
    }
  }
}
if(a=c) {
  if(a=b) {
    x = 10;
  }
}
```

Prototypes are not supported. All functions are assumed to return an integer type (**char** return types are allowed, but elevated to **int**), and no parameter type checking is performed.

All local variables must be declared at the start of a function, immediately after the opening brace. Local variables cannot be declared within any other block. The following function is invalid:

```C
int myfunc()
{
  int i; /* this is valid */
  if(1) {
    int i; /* this is not valid */
    /*...*/
  }
}
```

All functions must be preceded by either an **int** or **char** type specifier. For example, this declaration is valid:

```C
int main()
{
  /*...*/
}
```

However, this one is not:

```C
main ()
{
  /*...*/
}
```

## Library Functions

The following library functions are implemented:

```c
int getche(void);    /* Read a character from keyboard and return its value */
int putch(char ch);  /* Write a character to the screen */
int puts(char *s);   /* Write a string to the screen */
int getnum(void);    /* Read an integer from the keyboard and return its value */
int print(char *s);  /* Write a string to the screen */
int print(int i);    /* Write an integer to the screen */
```
