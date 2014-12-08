/**
 * @file	CBError.m
 * @brief	Define CBError class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */


#import "CBError.h"

@implementation CBError
- (instancetype) init
{
	if((self = [super init]) != nil){
		
	}
	return self ;
}

- (NSString *) toString
{
	assert(false) ;
	return @"" ;
}

@end

@implementation CBUnknownShortNameOptionError

- (instancetype) initWithUnknownShortName: (unsigned char) c
{
	if((self = [super init]) != nil){
		unknownShortOptionName = c ;
	}
	return self ;
}

- (NSString *) toString
{
	return [[NSString alloc] initWithFormat: @"Unknown short name option \"%c\"", unknownShortOptionName] ;
}

@end
