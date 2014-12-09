/**
 * @file	CBOptionFormat.m
 * @brief	Define CBOptionFormat class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import "CBOptionFormat.h"

@implementation CBOptionFormat

@synthesize optionDefinition ;

+ (CNList *) generateOptionFormats: (const struct CBOptionDefinition *) optdefs
{
	CNList * newlist = [[CNList alloc] init] ;
	for( ; optdefs->optionId != CBNilOptionId ; optdefs++){
		CBOptionFormat * newform = [[CBOptionFormat alloc] initWithOptionDefinition: optdefs] ;
		[newlist addObject: newform] ;
	}
	return newlist ;
}

- (instancetype) initWithOptionDefinition: (const struct CBOptionDefinition *) optdef
{
	if((self = [super init]) != nil){
		self.optionDefinition = *optdef ;
	}
	return self ;
}

- (void) printToFile: (FILE *) outfp
{
	if(self.optionDefinition.longName != NULL){
		fprintf(outfp, "--%s ", self.optionDefinition.longName) ;
	}
	if(self.optionDefinition.shortName != '\0'){
		fprintf(outfp, "-%c ", self.optionDefinition.shortName) ;
	}
	if(self.optionDefinition.valueDescription != NULL){
		fprintf(outfp, "%s ", self.optionDefinition.valueDescription) ;
	}
	if(self.optionDefinition.optionDescription){
		fprintf(outfp, ": %s", self.optionDefinition.optionDescription) ;
	}
	fputs("\n", outfp) ;
}

@end
