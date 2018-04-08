typedef struct 	TNODE	{
	char	*info;
	int	tag;
	struct   TNODE   *left;	
	struct   TNODE   *right;
}TREENODE, *TREEPTR;

typedef struct node{
	int quadnum;
	struct node *link;
} *LIST, LISTNODE;

