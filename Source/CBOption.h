/**
 * @file	CBOption.h
 * @brief	Define CBOption class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import <Coconut/Coconut.h>
#import "CBForwarders.h"

@interface CBOption : NSObject

@property (assign, nonatomic) const struct CBOptionDefinition *	optionDefinition ;
@property (strong, nonatomic) CNValue * optionValue ;

- (instancetype) initWithOptionDefinition: (const struct CBOptionDefinition *) optdef withValue: (CNValue *) value ;
- (CNText *) toText ;

@end
