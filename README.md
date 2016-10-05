# Little C
The Little C Interpreter from Herbert Schildt's C: The Complete Reference (4th Ed.)

## Table of Contents

 * [Project Structure] (#project-structure)
 * [Specifications] (#specifications)
 * [Restrictions] (#restrictions)
 * [Library Functions] (#library-functions)
 * [Example Programs] (#example-programs)

## Project Structure

The files for this project are in the following directories:

    .
    ├── bcb3                  # Borland C++ Builder 3.0 Project Files
    ├── bcc55                 # Borland C++ Compiler 5.5 Makefile
    ├── dev-cpp               # Dev-C++ 4.9 Project Files
    ├── gcc                   # Gnu C Compiler Makefile
    ├── qc25                  # Microsoft Quick C 2.5 Makefile
    ├── src                   # Project Source Code
    ├── vc152                 # Visual C++ 1.52 Project File
    ├── vc6                   # Visual C++ 6.0 Project File
    ├── vs2015                # Visual Studio 2015 Project File
    ├── watcom                # Open Watcom 1.9 Project File
    ├── LICENSE.md
    └── README.md

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
 * The **return** statement, both with and without a value
 * The **break**, **continue** and **end** statements
 * A limited number of standard library functions
 * These operators: +, –, *, /, %, <, >, <=, >=, ==, !=, unary –, and unary +
 * Functions returning integers
 * /* ... */-style comments
 * C++ style comments

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

```C
int getche(void);    /* Read a character from keyboard and return its value */
int putch(char ch);  /* Write a character to the screen */
int puts(char *s);   /* Write a string to the screen */
int getnum(void);    /* Read an integer from the keyboard and return its value */
int print(char *s);  /* Write a string to the screen */
int print(int i);    /* Write an integer to the screen */
```

## Example Programs

A program demonstrating all of the features of Little C:

```C
/* Little C Demonstration Program #1.

   This program demonstrates all features
   of C that are recognized by Little C.
*/

int i, j;   /* global vars */
char ch;

int main()
{
  int i, j;  /* local vars */

  puts("Little C Demo Program.");

  print_alpha();

  do {
    puts("enter a number (0 to quit): ");
    i = getnum();
    if(i < 0 ) {
      puts("numbers must be positive, try again");
    }
    else {
      for(j = 0; j < i; j=j+1) {
        print(j);
        print("summed is");
        print(sum(j));
        puts("");
      }
    }
  } while(i!=0);

  return 0;
}

/* Sum the values between 0 and num. */
int sum(int num)
{
  int running_sum;

  running_sum = 0;

  while(num) {
    running_sum = running_sum + num;
    num = num - 1;
  }
  return running_sum;
}

/* Print the alphabet. */
int print_alpha()
{
  for(ch = 'A'; ch<='Z'; ch = ch + 1) {
    putch(ch);
  }
  puts("");

  return 0;
}
```

A program demonstrating nested loops:

```C
/* Nested loop example. */
int main()
{
  int i, j, k;

  for(i = 0; i < 5; i = i + 1) {
    for(j = 0; j < 3; j = j + 1) {
      for(k = 3; k ; k = k - 1) {
        print(i);
        print(j);
        print(k);
        puts("");
      }
    }
  }
  puts("done");

  return 0;
}
```

A program demonstrating the assignment operator:

```C
/* Assigments as operations. */
int main()
{
  int a, b;

  a = b = 10;

  print(a); print(b);

  while(a=a-1) {
    print(a);
    do {
       print(b);
    } while((b=b-1) > -10);
  }

  return 0;
}
```

A program demonstrating recursive functions:

```C
/* This program demonstrates recursive functions. */

/* return the factorial of i */
int factr(int i)
{
  if(i<2) {
    return 1;
  }
  else {
     return i * factr(i-1);
  }
}

int main()
{
  print("Factorial of 4 is: ");
  print(factr(4));

  return 0;
}
```

A program demonstrating function arguments:

```C
/* A more rigorous example of function arguments. */

int f1(int a, int b)
{
  int count;

  print("in f1");

  count = a;
  do {
    print(count);
  } while(count=count-1);

  print(a); print(b);
  print(a*b);
  return a*b;
}

int f2(int a, int x, int y)
{
  print(a); print(x);
  print(x / a);
  print(y*x);

  return 0;
}

int main()
{
  f2(10, f1(10, 20), 99);

  return 0;
}
```

A program demonstrating loop statements:

```C
/* The loop statements. */
int main()
{
  int a;
  char ch;

  /* the while */
  puts("Enter a number: ");
  a = getnum();
  while(a) {
    print(a);
    print(a*a);
    puts("");
    a = a - 1;
  }

  /* the do-while */
  puts("enter characters, 'q' to quit");
  do {
     ch = getche();
  } while(ch !='q');

  /* the for */
  for(a=0; a<10; a = a + 1) {
     print(a);
  }

  return 0;
}
```
