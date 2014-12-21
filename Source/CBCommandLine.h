/**
 * @file	CBCommandLine.h
 * @brief	Define CBCommandLine class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import <Coconut/Coconut.h>
#import "CBForwarders.h"

@interface CBCommandLine : NSObject

/** List of CBOption */
@property (strong, nonatomic) CNList *	commandLineOptions ;
/** List of NSString */
@property (strong, nonatomic) CNList *  commandLineArguments ;

- (instancetype) init ;

- (CBOption *) searchOptionById: (NSUInteger) optionid ;
- (CNText *) toText ;

+ (CBCommandLine *) parseArguments: (const char **) argv
			withCounts: (NSUInteger) counts
	     withOptionDefinitions: (const struct CBOptionDefinition *) defs
			 withError: (NSError * __autoreleasing *) error ;

@end
