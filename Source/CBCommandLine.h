/**
 * @file	CBCommandLine.h
 * @brief	Define CBCommandLine class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import <Coconut/Coconut.h>

typedef struct  {
	NSUInteger		optionId ;
	const char *		optionName ;
	CNValueType		valueType ;
} CBCommandLineOptionFormat ;

#define KDEndOfCommandLineOptionFormat	{0, NULL, KDNilValue}

@interface CBCommandLine : NSObject

@end
