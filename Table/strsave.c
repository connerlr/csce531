#define NULL 0
#define ENDSTR 0
#define MAXSTR 100
/*
FUNCTION: STRSAVE

PURPOSE: Strsave makes sure there is space allocated for the
	 string being saved.

USAGE:  ptr = strsave(s);

DESCRIPTION OF PARAMETERS: s(array of char) name to save

AUTHOR:  Kernighan and Ritchie, modified by Ron Sobczak

LAST REVISION: 12/11/83

*/

char *strsave(s)		/* save string s somewhere */
char *s;
{
	char *p, *malloc();

	if ((p = malloc((unsigned) strlen(s) + 1)) != NULL)
		strcpy(p,s);
	return(p);
}
