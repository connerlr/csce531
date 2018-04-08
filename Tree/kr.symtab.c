#define ENDSTR 0
#define MAXSTR 100
#include <stdio.h>
int nextquad = 1;

struct nlist { /* basic table entry */
	char *name;
	int val;
	struct nlist *next;	/*next entry in chain */
	struct nlist *tnext;	/*next entry for settype */
	int typ;
};

#define	HASHSIZE	100
static struct nlist *hashtab[HASHSIZE];	/* pointer table */
/*
FUNCTION: HASH
PURPOSE: Hash determines hash value based on the sum of the 
	 character values in the string. 
USAGE:  n = hash(s);
DESCRIPTION OF PARAMETERS: s(array of char) string to be hashed
AUTHOR:  Kernighan and Ritchie
LAST REVISION: 12/11/83
*/

hash(s)		/* form hash value for string s */
char *s;
{
	int hashval;

	for (hashval = 0;  *s != '\0'; )
		hashval += *s++;
	return (hashval % HASHSIZE);
}
/*
FUNCTION: LOOKUP
PURPOSE: Lookup searches for entry in symbol table and returns a pointer
USAGE:  np= lookup(s);
DESCRIPTION OF PARAMETERS: s(array of char) string  searched for
AUTHOR:  Kernighan and Ritchie
LAST REVISION: 12/11/83
*/

struct nlist *lookup(s)  /* look for s in hashtab */
char *s;
{
	struct nlist *np;

	for (np = hashtab[hash(s)]; np != NULL; np = np->next)
		if (strcmp(s, np->name) == 0)
			return(np);		/* found it */
	return(NULL);		/* not found */
}
/*
FUNCTION: INSTALL
PURPOSE: Install checks hash table using lookup and if entry not found,
	 it "installs" the entry.
USAGE:  np = install(name); 
DESCRIPTION OF PARAMETERS: name(array of char) name to install in 
symbol table
AUTHOR:  Kernighan and Ritchie, modified by Ron Sobczak
LAST REVISION: 12/11/83
*/

struct nlist *install(name)		/* put (name) in hashtab */
char *name;
{
	struct nlist *np, *lookup();
	char *strsave(), *malloc();
	int hashval;

	if ((np = lookup(name))  == NULL) {	/* not found */
		np = (struct nlist *) malloc(sizeof(*np));
		if (np == NULL)
			return(NULL);
		if ((np->name = strsave(name)) == NULL)
			return(NULL);
		hashval = hash(np->name);
		np->next = hashtab[hashval];
		hashtab[hashval] = np;
		np->tnext = NULL;
		np->typ = NULL;
	}
	return(np);
}
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
