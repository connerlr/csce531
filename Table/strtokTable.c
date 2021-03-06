// A C/C++ program for splitting a string
// using strtok()
// https://www.geeksforgeeks.org/strtok-strtok_r-functions-c-examples/ 
#include <stdio.h>
#include <string.h>
#include "kr.symtab.h"
 
int main()
{
    char str[1024];
 
    if (fgets(str, 1024, stdin) != NULL){  // read a line (up to 1024 characters) into str
    
    // Returns first token 
    char *token = strtok(str, " ");
   
    // Keep printing tokens while one of the
    // delimiters present in str[].
    while (token != NULL)
    {
        printf("%s\n", token);
	install(token); // install returns a pointer that should not be ignored
        token = strtok(NULL, " ");
        
    }
    } 
    dumptable();
    return 0;
}
