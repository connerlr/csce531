char *
toTokenName(int tokenCode){
	 char ascii[2];
	 ascii[1]=(char)0; // EOS (End Of String) 
	 if(tokenCode < 128){
		 ascii[0] = (char) tokenCode;
		 return(strdup((char *) ascii));
	 }
	 switch(tokenCode){
		 case 258:  return("INT");
		 case 259:  return("RELOP");
		 case 260:  return("IF");
		 case 261:  return("THEN");
		 case 262:  return("ELSE");
		 case 263:  return("AND");
		 case 264:  return("ASSIGNOP");
		 case 265:  return("OR");
		 case 266:  return("NOT");
		 case 267:  return("PROGRAM");
		 case 268:  return("BEGN");
		 case 269:  return("END");
		 case 270:  return("WHILE");
		 case 271:  return("DO");
		 case 272:  return("ENDLOOP");
		 case 273:  return("LOOP");
		 case 275:  return("LT");
		 case 276:  return("GT");
		 case 277:  return("EQ");
		 case 278:  return("ID");
		 default: return("UNRECOGNIZED TOKEN CODE!");
		 }
}
