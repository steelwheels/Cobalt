/**
 * @file	CBArgument.m
 * @brief	Define CBArgument class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import "CBArgument.h"
#import "CBError.h"
#import <Coconut/Coconut.h>

static CBError *
parseOneArgument(CNList * dst, const char * arg) ;

@implementation CBArgument

+ (CBError *) parseArguments: (const char **) argv withCount: (NSUInteger) count into: (CNList **) dstlist
{
	*dstlist = [[CNList alloc] init] ;
	for(NSUInteger i=0 ; i<count ; i++){
		CBError * error ;
		if((error = parseOneArgument(*dstlist, argv[i])) != nil){
			return error ;
		}
	}
	return nil;
}

- (instancetype) initWithType: (CBArgumentType) type withValue: (NSString *) value
{
	if((self = [super init]) != nil){
		self.type  = type ;
		self.value = value ;
	}
	return self ;
}

@end

static void
addOneArgument(CNList * dst, CBArgumentType type, const char * str)
{
	NSString * newval = [[NSString alloc] initWithUTF8String: str] ;
	CBArgument * newarg = [[CBArgument alloc] initWithType: type withValue: newval] ;
	[dst addObject: newarg] ;
}

static CBError *
parseOneArgument(CNList * dst, const char * arg)
{
	if(arg[0] == '-'){
		if(arg[1] == '-'){
			if(isalnum(arg[2])){
				/* Long name option */
				addOneArgument(dst, CBLongNameOptionArgument, &(arg[2])) ;
			} else if(arg[2] != '\0'){
				/* Normal option */
				addOneArgument(dst, CBNormalArgument, arg) ;
			} else {
				addOneArgument(dst, CBNormalArgument, arg) ;
			}
		} else {
			NSUInteger i ;
			char c ;
			/* Short name options */
			for(i=1 ; (c = arg[i]) != '\0' ; i++){
				if(isalnum(c)){
					char str[] = {c, '\0'} ;
					addOneArgument(dst, CBShortNameOptionArgument, str) ;
				} else {
					return [[CBUnknownShortNameOptionError alloc] initWithUnknownShortName: c] ;
				}
			}
		}
	} else {
		/* Normal option */
		addOneArgument(dst, CBNormalArgument, arg) ;
	}
	return nil ;
}
