### MMM transform core2.tab.h into a function that given a token code prints the "defined constant"

import re

filename="core2.tab.h"
# create the header part of the function
print("char *")
print("toTokenName(int tokenCode){")
print("\t char ascii[2];")
print("\t ascii[1]=(char)0; // EOS (End Of String) ")
print("\t if(tokenCode < 128){")
print("\t\t ascii[0] = (char) tokenCode;")
print("\t\t return(strdup((char *) ascii));")
print("\t }")
print("\t switch(tokenCode){")

# compile the regular expression to do searches etc.
dfa = re.compile("\s\s\s\s([A-Z][A-Z]+)\s*=\s*([0-9][0-9][0-9])")

# open the file "core2.tab.h" and process each line by matching the reg expr
f = open(filename)
for line in f:
   match = dfa.search(line)
   if match:
       print("\t\t case "+ match.group(2) + ":  return(\"" + match.group(1) + "\");")
       
#print the tail of the function
print("\t\t default: return(\"UNRECOGNIZED TOKEN CODE!\");")
print("\t\t }\n}")
