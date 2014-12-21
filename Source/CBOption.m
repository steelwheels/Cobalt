/**
 * @file	CBOption.m
 * @brief	Define CBOption class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import "CBOption.h"
#import "CBOptionDefinition.h"

@implementation CBOption

@synthesize optionDefinition ;
@synthesize optionValue ;

- (instancetype) initWithOptionDefinition: (const struct CBOptionDefinition *) optdef withValue: (CNValue *) value
{
	if((self = [super init]) != nil){
		self.optionDefinition = optdef ;
		self.optionValue = value ;
	}
	return self ;
}

- (CNText *) toText
{
	CNTextSection * result = [[CNTextSection alloc] init] ;
	
	CNTextSection * defsec = [[CNTextSection alloc] init] ;
	defsec.sectionTitle = @"Option definition" ;
	[defsec appendChildText: CBOptionDefinitionToString(self.optionDefinition)] ;
	[result appendChildText: defsec] ;
	
	if(self.optionValue){
		CNTextSection * valsec = [[CNTextSection alloc] init] ;
		valsec.sectionTitle = @"Value" ;
		
		NSString * valstr = [self.optionValue description] ;
		[valsec appendChildText: [[CNTextLine alloc] initWithString: valstr]] ;
		[result appendChildText: valsec] ;
	}
	return result ;
}

@end
