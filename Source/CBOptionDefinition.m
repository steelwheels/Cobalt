/**
 * @file	CBOptionDefinition.m
 * @brief	Define CBOptionDefinition class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import "CBOptionDefinition.h"

static inline NSString *
appendString(NSString * basestr, NSString * addstr)
{
	NSString * result ;
	if(basestr){
		result = [basestr stringByAppendingString: addstr] ;
	} else {
		result = addstr ;
	}
	return result;
}

CNText *
CBOptionDefinitionToString(const struct CBOptionDefinition * src)
{
	NSString *	result = nil ;
	if(src->longName != NULL){
		result = [[NSString alloc] initWithFormat: @"--%s ", src->longName] ;
	}
	if(src->shortName != '\0'){
		NSString * shortstr = [[NSString alloc] initWithFormat: @"-%c ", src->shortName] ;
		result = appendString(result, shortstr) ;
	}
	if(src->valueDescription != NULL){
		NSString * valstr = [[NSString alloc] initWithUTF8String: src->valueDescription] ;
		result = appendString(result, valstr) ;
	}
	if(src->optionDescription != NULL){
		NSString * optstr = [[NSString alloc] initWithFormat: @": %s", src->optionDescription] ;
		result = appendString(result, optstr) ;
	}
	return [[CNTextLine alloc] initWithString: result] ;
}


