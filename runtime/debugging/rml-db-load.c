/*
Copyright (c) 2002-2006 by Adrian Pop

Permission to use, copy, modify, and distribute this software and
its documentation for NON-COMMERCIAL purposes and without fee is hereby 
granted, provided that this copyright notice appear in all copies and 
that both the copyright notice and this permission notice and warranty
disclaimer appear in supporting documentation, and that the name of
The Author not be used in advertising or publicity pertaining to
distribution of the software without specific, written prior permission.
For COMMERCIAL uses of versions above rml-2.1.8 please contact 
Adrian Pop, adrpo@ida.liu.se. 

THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS.
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, INDIRECT OR
CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE
USE OR PERFORMANCE OF THIS SOFTWARE.
*/
/***********************************************************
[ rml-db-load.c ] 
- Adrian Pop, adrpo@ida.liu.se, http://www.ida.liu.se/~adrpo 
- creation: 2005-12-27
  + implementation for rml debugging 
    this file contains all the functions for loading the program database.
    look also into runtime/debugging for:
    * debug-debug.c 
    * debug-print.c
    * debug-push-vars.c
	* rml-debug.*
  + all things in this file starts with rmldb_
- last modified: 2005-12-27
************************************************************/

#ifndef  _RML_DB_LOAD_H_
#include "rml.h"
#endif
#include <stdio.h>
#include <stdlib.h>

rmldb_var_db_t *rmldb_var_db_start;
rmldb_var_db_t *rmldb_var_db_end;
rmldb_type_db_t *rmldb_type_db_start;
rmldb_type_db_t *rmldb_type_db_end;
rmldb_con_db_t *rmldb_con_db_start;
rmldb_con_db_t *rmldb_con_db_end;
rmldb_relation_db_t *rmldb_relation_db_start;
rmldb_relation_db_t *rmldb_relation_db_end;

/* ---- components ---- */
/* create a list from two tys */
extern rmldb_LISTty_t* rmldb_make_rmldb_LISTty(rmldb_type_t* type1, rmldb_type_t* type2)
{
	rmldb_LISTty_t* rmlLISTty_node = (rmldb_LISTty_t*)malloc(sizeof(rmldb_LISTty_t));
	rmlLISTty_node->list_start = NULL;
	rmlLISTty_node->list_end = NULL;
	if (type1)
		rmldb_type_list_push_back(
			&(rmlLISTty_node->list_start),
			&(rmlLISTty_node->list_end),
			type1);
	if (type2)
		rmldb_type_list_push_back(
			&(rmlLISTty_node->list_start),
			&(rmlLISTty_node->list_end),
			type2);
	if (type1 || type2)
		rmlLISTty_node->length = rmlLISTty_node->list_end->depth + 1;
	else
		rmlLISTty_node->length = 0;
	return rmlLISTty_node;
}

/* appends ty in front of the list */
extern rmldb_LISTty_t* rmldb_make_cons_rmldb_LISTty(rmldb_type_t* type, rmldb_LISTty_t* list)
{
	if (type && list)
		rmldb_type_list_push_front(
			&list->list_start,
			&list->list_end,
			type);
	if (list->list_end) 
		list->length = list->list_end->depth + 1;
	else
		list->length = 0;
	return list;
}

/* make a VARty */
extern rmldb_VARty_t* rmldb_make_rmldb_VARty(char* id)
{
	rmldb_VARty_t* rmlVARty_node = (rmldb_VARty_t*)malloc(sizeof(rmldb_VARty_t));
	rmlVARty_node->id = id;
	return rmlVARty_node;
}

/* make a CONSty */
extern rmldb_CONSty_t* rmldb_make_rmldb_CONSty(rmldb_LISTty_t* list, char* id)
{
	rmldb_CONSty_t* rmlCONSty_node = (rmldb_CONSty_t*)malloc(sizeof(rmldb_CONSty_t));
	rmlCONSty_node->list = list;
	rmlCONSty_node->id = id;
	return rmlCONSty_node;
}

/* make a TUPLEty */
extern rmldb_TUPLEty_t* rmldb_make_rmldb_TUPLEty(rmldb_LISTty_t* list)
{
	rmldb_TUPLEty_t* rmlTUPLEty_node = (rmldb_TUPLEty_t*)malloc(sizeof(rmldb_TUPLEty_t));
	rmlTUPLEty_node->list = list;
	return rmlTUPLEty_node;	
}

/* make a RELty */
extern rmldb_RELty_t* rmldb_make_rmldb_RELty(rmldb_LISTty_t* list1, rmldb_LISTty_t* list2)
{
	rmldb_RELty_t* rmlRELty_node = (rmldb_RELty_t*)malloc(sizeof(rmldb_RELty_t));
	rmlRELty_node->list1 = list1;
	rmlRELty_node->list2 = list2;
	return rmlRELty_node;	
}

/* makes a type from a component, and casts it according to kind */
extern rmldb_type_t* rmldb_make_rmldb_type(rmldb_tyKind_t kind, void* component)
{
	rmldb_type_t* rmldb_type_node = (rmldb_type_t*)malloc(sizeof(rmldb_type_t));
	rmldb_type_node->kind = kind;
	switch (kind)
	{
	case RMLDB_eLISTty:  rmldb_type_node->component.l = (rmldb_LISTty_t*)component; break;
	case RMLDB_eVARty:   rmldb_type_node->component.v = (rmldb_VARty_t*)component; break;
	case RMLDB_eCONSty:  rmldb_type_node->component.c = (rmldb_CONSty_t*)component; break;
	case RMLDB_eTUPLEty: rmldb_type_node->component.t = (rmldb_TUPLEty_t*)component; break;
	case RMLDB_eRELty:   rmldb_type_node->component.r = (rmldb_RELty_t*)component; break;
	}
	rmldb_type_node->depth = 0;
    rmldb_type_node->prev = 0;
    rmldb_type_node->next = 0;
	return rmldb_type_node;
}

extern void rmldb_type_list_push_back(rmldb_type_t **start_node, rmldb_type_t **end_node, rmldb_type_t *node)
{
	rmldb_type_t *last;
	last = node;
	if(*start_node)
		last->depth = ((rmldb_type_t*)*end_node)->depth + 1;
	else { *start_node = last; last->depth = 0; }
	last->next = NULL;	last->prev = *end_node;
	if(*end_node) ((rmldb_type_t*)*end_node)->next = last;
	*end_node = last;
}

extern void rmldb_type_list_push_front(rmldb_type_t **start_node, rmldb_type_t **end_node, rmldb_type_t *node)
{
	rmldb_type_t *first, *tmp;
	first = node;
	first->depth = 0;
	first->next = NULL;
	if(*start_node)
	{
		/* depth++ on all */
		for(tmp = *start_node; tmp; tmp = tmp->next)
		{
			tmp->depth++;
		}
		/* link front */
		first->next = *start_node;
		((rmldb_type_t*)*start_node)->prev = first;
	}
	else
	{
		if (!*end_node) *end_node = first;
	}
	first->prev = NULL;
	*start_node = first;
}


extern rmldb_var_db_t* rmldb_make_rmldb_var_db(
		char* file,
		rmldb_range_db_t* range,
		rmldb_range_db_t* clause_range,
		char* relation,
		char* name,
		rmldb_type_db_t* type_db)
{
	rmldb_var_db_t* rmldb_var_db_node = (rmldb_var_db_t*)malloc(sizeof(rmldb_var_db_t));
	rmldb_var_db_node->file = file;
	rmldb_var_db_node->range = range;
	rmldb_var_db_node->clause_range = clause_range;
	rmldb_var_db_node->relation = relation;
	rmldb_var_db_node->name = name;
	rmldb_var_db_node->type_db = type_db;
	rmldb_var_db_node->depth = 0;
	rmldb_var_db_node->prev = NULL;
	rmldb_var_db_node->next = NULL;
	return rmldb_var_db_node;
}

void rmldb_var_db_add(rmldb_var_db_t **start_node, 
				    rmldb_var_db_t **end_node, 
					rmldb_var_db_t *node)
{
	rmldb_var_db_t *last;
	last = node;
	if(*start_node)
		last->depth = ((rmldb_var_db_t*)*end_node)->depth + 1;
	else { *start_node = last; last->depth = 0; }
	last->next = NULL;	last->prev = *end_node;
	if(*end_node) ((rmldb_var_db_t*)*end_node)->next = last;
	*end_node = last;
}

extern rmldb_con_db_t* rmldb_make_rmldb_con_db(
		char* file,
		rmldb_range_db_t* range,
		char* name,
		rmldb_type_db_t* type_db,
		int constructor)
{
	rmldb_con_db_t* rmldb_con_db_node = (rmldb_con_db_t*)malloc(sizeof(rmldb_con_db_t));
	rmldb_con_db_node->file = file;
	rmldb_con_db_node->range = range;
	rmldb_con_db_node->name = name;
	rmldb_con_db_node->type_db = type_db;
	rmldb_con_db_node->constructor = constructor;
	rmldb_con_db_node->is_transparent = 0;
	rmldb_con_db_node->depth = 0;
	rmldb_con_db_node->prev = NULL;
	rmldb_con_db_node->next = NULL;
	return rmldb_con_db_node;
}

void rmldb_con_db_add(struct rmldb_con_db **start_node, 
				    struct rmldb_con_db **end_node, 
					struct rmldb_con_db *node)
{
	struct rmldb_con_db *last;
	last = node;
	if(*start_node)
		last->depth = ((struct rmldb_con_db*)*end_node)->depth + 1;
	else { *start_node = last; last->depth = 0; }
	last->next = NULL;	last->prev = *end_node;
	if(*end_node) ((struct rmldb_con_db*)*end_node)->next = last;
	*end_node = last;
}

extern rmldb_type_db_t* rmldb_make_rmldb_type_db(
		char* file,
		rmldb_range_db_t* range,
		char* name)
{
	rmldb_type_db_t* rmldb_type_db_node = (rmldb_type_db_t*)malloc(sizeof(rmldb_type_db_t));
	rmldb_type_db_node->file = file;
	rmldb_type_db_node->name = name;
	rmldb_type_db_node->range = range;
	rmldb_type_db_node->type = NULL;
	rmldb_type_db_node->depth = 0;
	rmldb_type_db_node->prev = NULL;
	rmldb_type_db_node->next = NULL;
	return rmldb_type_db_node;
}

extern rmldb_type_db_t* rmldb_make_rmldb_type_db_t(
		rmldb_type_t *type)
{
	rmldb_type_db_t* rmldb_type_db_node = (rmldb_type_db_t*)malloc(sizeof(rmldb_type_db_t));
	rmldb_type_db_node->file = NULL;
	rmldb_type_db_node->range = NULL;
	rmldb_type_db_node->name = NULL;
	rmldb_type_db_node->type = type;
	rmldb_type_db_node->depth = 0;
	rmldb_type_db_node->prev = NULL;
	rmldb_type_db_node->next = NULL;
	return rmldb_type_db_node;
}


void rmldb_type_db_add(struct rmldb_type_db **start_node, 
				    struct rmldb_type_db **end_node, 
					struct rmldb_type_db *node)
{
	struct rmldb_type_db *last;
	last = node;
	if(*start_node)
		last->depth = ((struct rmldb_type_db*)*end_node)->depth + 1;
	else { *start_node = last; last->depth = 0; }
	last->next = NULL;	last->prev = *end_node;
	if(*end_node) ((struct rmldb_type_db*)*end_node)->next = last;
	*end_node = last;
}

extern rmldb_relation_db_t* rmldb_make_rmldb_relation_db(
		char* file,
		rmldb_range_db_t* range,
		char* name,
		rmldb_type_db_t* type_db)
{
	rmldb_relation_db_t* rmldb_relation_db_node = (rmldb_relation_db_t*)malloc(sizeof(rmldb_relation_db_t));
	rmldb_relation_db_node->file = file;
	rmldb_relation_db_node->range = range;
	rmldb_relation_db_node->name = name;
	rmldb_relation_db_node->type_db = type_db;	
	rmldb_relation_db_node->depth = 0;
	rmldb_relation_db_node->prev = NULL;
	rmldb_relation_db_node->next = NULL;
	return rmldb_relation_db_node;
}

void rmldb_relation_db_add(struct rmldb_relation_db **start_node, 
				    struct rmldb_relation_db **end_node, 
					struct rmldb_relation_db *node)
{
	struct rmldb_relation_db *last;
	last = node;
	if(*start_node)
		last->depth = ((struct rmldb_relation_db*)*end_node)->depth + 1;
	else { *start_node = last; last->depth = 0; }
	last->next = NULL;	last->prev = *end_node;
	if(*end_node) ((struct rmldb_relation_db*)*end_node)->next = last;
	*end_node = last;
}

extern int rmldb_load_db(char* programdb_file)
{
#ifdef RML_DEBUG
	char line[RMLDB_MAX_STRING];  /* declare a char array */
	rmldb_var_db_t *rmldb_var_db_node;
	struct rmldb_type_db *rmldb_type_db_node;
	struct rmldb_con_db *rmldb_con_db_node;
	struct rmldb_relation_db *rmldb_relation_db_node;

	/*
	fprintf(stderr, "loading program database from: %s\n", programdb_file);
	*/

	aarmldbin = fopen(programdb_file, "r"); 
	/* open a text file for reading */

	if(aarmldbin==NULL) 
	{
		fprintf(stderr, "Error: can't open file %s.\n", programdb_file);
		/* fclose(file); DON'T PASS A NULL POINTER TO fclose !! */
		rml_exit(2);
	}
	else 
	{
		aarmldbrestart(aarmldbin);
		if (aarmldbparse())
		  fprintf(stderr, "parsing of program database for file %s failed!\n", programdb_file); 
		fclose(aarmldbin);
		rmldb_order_rmldb_con_db();
		return 0;
	}
#endif /* RML_DEBUG */
}


