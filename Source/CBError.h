/**
 * @file	CBError.h
 * @brief	Define CBError class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import <Foundation/Foundation.h>

@protocol CBErrorOperating <NSObject>
- (NSString *) toString ;
@end


@interface CBError : NSObject <CBErrorOperating>
- (instancetype) init ;
@end

@interface CBUnknownShortNameOptionError : CBError <CBErrorOperating>
{
	unsigned char		unknownShortOptionName ;
}
- (instancetype) initWithUnknownShortName: (unsigned char) c ;

@end


