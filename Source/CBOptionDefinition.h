/**
 * @file	CBOptionDefinition.h
 * @brief	Define CBOptionDefinition class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import <Coconut/Coconut.h>

struct CBOptionDefinition {
	NSUInteger		optionId ;
	char			shortName ;
	const char *		longName ;
	CNValueType		valueType ;
	const char *		valueDescription ;
	const char *		optionDescription ;
} ;

static const NSUInteger		CBNilOptionId = (NSUInteger) -1 ;

#define CBEndOfOptionDefinition	{CBNilOptionId, '\0', NULL, CNNilValue, NULL, NULL}

static inline BOOL
CBIsEndOfOptionDefinition(const struct CBOptionDefinition * src)
{
	return src->optionId == CBNilOptionId ;
}

CNText *
CBOptionDefinitionToString(const struct CBOptionDefinition * src) ;

