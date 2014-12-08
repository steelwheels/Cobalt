/**
 * @file	CBError.m
 * @brief	Define CBError class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */


#import "CBError.h"

@implementation CBError

- (instancetype) initWithMessage: (NSString *) message
{
	if((self = [super init]) != nil){
		self.message = message ;
	}
	return self ;
}

@end

