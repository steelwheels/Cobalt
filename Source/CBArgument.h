/**
 * @file	CBArgument.h
 * @brief	Define CBArgument class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import <Coconut/Coconut.h>
#import "CBForwarders.h"

typedef enum {
	CBNormalArgument,
	CBLongNameOptionArgument,
	CBShortNameOptionArgument,
} CBArgumentType ;

@interface CBArgument : NSObject

@property (assign, nonatomic) CBArgumentType	type ;
@property (strong, nonatomic) NSString *	value ;

+ (CBError *) parseArguments: (const char **) argv withCount: (NSUInteger) count into: (CNList **) dstlist ;
- (instancetype) initWithType: (CBArgumentType) type withValue: (NSString *) value ;

@end

