/*
    Copyright PELAB, Linkoping University

    This file is part of Open Source Modelica (OSM).

    OSM is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    OSM is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Foobar; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

*/
/**************************************************
[ loadprogramdb.c ] 
- creation: adrpo 2005-03-01
- last modified:  2005-03-01
***************************************************/

#include <stdio.h>
#include <errno.h>
#include "rml.h"
#include "rml-db-parse.h"

/* Glue to call program database parser (and thus scanner) from RML */
 
/* The yacc parser will deposit the program database absyn tree here */
 
void *yyrmldb_absyntree;
 
/* No init for this module */

void LoadProgramDB_5finit(void) 
{

}

/* program database stream */
extern FILE *yyrmldbin; /* the stream we need to parse */
extern int yyrmldberror(char*);
extern int yyrmldbparse(void);
extern int yyrmldbdebug;


/* The glue function */ 
RML_BEGIN_LABEL(LoadProgramDB__parse)
{
    void *a0 = rmlA0;
    yyrmldbin = fopen(RML_STRINGDATA(a0), "r"); 
    if(yyrmldbin==NULL) 
    {
		fprintf(stderr, "fopen %s failed: %s\n",
		RML_STRINGDATA(a0), strerror(errno));
		RML_TAILCALLK(rmlFC);
    }
    if( yyrmldbparse() != 0 )  
	{
		fprintf(stderr,"Fatal: parsing failed!\n");
		RML_TAILCALLK(rmlFC);
	}
	rmlA0=yyrmldb_absyntree;
	RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(LoadProgramDB__debug_5fon)
{
  yyrmldbdebug = 1;
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(LoadProgramDB__debug_5foff)
{
  yyrmldbdebug = 0;
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

