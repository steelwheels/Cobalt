/**
 * @file	CBOptionDefinition.m
 * @brief	Define CBOptionDefinition class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import "CBOptionDefinition.h"

void
CBPrintOptionDefinition(FILE * outfp, const struct CBOptionDefinition * src)
{
	if(src->longName != NULL){
		fprintf(outfp, "--%s ", src->longName) ;
	}
	if(src->shortName != '\0'){
		fprintf(outfp, "-%c ", src->shortName) ;
	}
	if(src->valueDescription != NULL){
		fprintf(outfp, "%s ", src->valueDescription) ;
	}
	if(src->optionDescription){
		fprintf(outfp, ": %s", src->optionDescription) ;
	}
	fputs("\n", outfp) ;
}

