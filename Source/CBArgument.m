/**
 * @file	CBArgument.m
 * @brief	Define CBArgument class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import "CBArgument.h"
#import <Coconut/Coconut.h>

static void
parseOneArgument(CNList * dst, const char * arg) ;

@implementation CBArgument

+ (CNList *) parseArguments: (const char **) argv withCount: (NSUInteger) count
{
	CNList * newlist = [[CNList alloc] init] ;
	for(NSUInteger i=0 ; i<count ; i++){
		parseOneArgument(newlist, argv[i]) ;
	}
	return newlist ;
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

static void
parseOneArgument(CNList * dst, const char * arg)
{
	if(arg[0] == '-'){
		if(arg[1] == '-'){
			if(arg[2] == '\0'){
				/* '--' is treated as normal option */
				addOneArgument(dst, CBNormalArgument, arg) ;
			} else {
				/* Long name option */
				addOneArgument(dst, CBLongNameOptionArgument, &(arg[2])) ;
			}
		} else {
			NSUInteger i ;
			char c ;
			/* Short name options */
			for(i=1 ; (c = arg[i]) != '\0' ; i++){
				if(isalpha(c)){
					char str[] = {c, '\0'} ;
					addOneArgument(dst, CBShortNameOptionArgument, str) ;
				} else {
					break ;
				}
			}
			if(arg[i] != '\0'){
				addOneArgument(dst, CBNormalArgument, &(arg[i])) ;
			}
		}
	} else {
		/* Normal option */
		addOneArgument(dst, CBNormalArgument, arg) ;
	}
}
