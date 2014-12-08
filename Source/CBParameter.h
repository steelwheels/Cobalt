/**
 * @file	CBParameter.h
 * @brief	Define CBParameter class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import <Coconut/Coconut.h>

typedef struct {
	const char *		optionName ;
	CNValueType		optionValueType ;
} KDCommandOptionFormat ;

@interface CBParameter : NSObject

@end
