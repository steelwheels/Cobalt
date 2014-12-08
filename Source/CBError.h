/**
 * @file	CBError.h
 * @brief	Define CBError class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import <Foundation/Foundation.h>

@interface CBError : NSObject
@property (strong, nonatomic) NSString * message ;
- (instancetype) initWithMessage: (NSString *) message ;
@end





