/**
 * @file	CBOptionFormat.h
 * @brief	Define CBOptionFormat class
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

@interface CBOptionFormat : NSObject

@property (assign, nonatomic) struct CBOptionDefinition	optionDefinition ;

+ (CNList *) generateOptionFormats: (const struct CBOptionDefinition *) optdefs ;

- (instancetype) initWithOptionDefinition: (const struct CBOptionDefinition *) optdef ;

- (void) printToFile: (FILE *) outfp ;

@end
