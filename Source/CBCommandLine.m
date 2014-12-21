/**
 * @file	CBCommandLine.m
 * @brief	Define CBCommandLine class
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import "CBCommandLine.h"
#import "CBArgument.h"
#import "CBOption.h"
#import "CBOptionDefinition.h"

static const BOOL LOCAL_DEBUG = false ;

static NSError *
parseOneArgument(CBCommandLine * cmdline, CBArgument * arg, CNList * nextargs, const struct CBOptionDefinition * optdefs) ;

@implementation CBCommandLine

@synthesize commandLineOptions ;
@synthesize commandLineArguments ;

- (instancetype) init
{
	if((self = [super init]) != nil){
		self.commandLineOptions   = [[CNList alloc] init] ;
		self.commandLineArguments = [[CNList alloc] init] ;
	}
	return self ;
}

- (CBOption *) searchOptionById: (NSUInteger) optionid
{
	const struct CNListItem * item = self.commandLineOptions.firstItem ;
	for( ; item ; item = item->nextItem){
		CBOption * opt = (CBOption *) CNObjectInListItem(item) ;
		if((opt.optionDefinition)->optionId == optionid){
			return opt ;
		}
	}
	return nil ;
}

- (const struct CNListItem *) firstArgument
{
	return [self.commandLineArguments firstItem] ;
}

- (CNText *) toText
{
	CNTextSection * text = [[CNTextSection alloc] initWithTitle: @"CommandLine"] ;
	
	CNTextSection * optsec = [[CNTextSection alloc] initWithTitle: @"Options:"] ;
	const struct CNListItem * optitem ;
	for(optitem = [self.commandLineOptions firstItem] ; optitem ; optitem = optitem->nextItem){
		CBOption * opt = (CBOption *) CNObjectInListItem(optitem) ;
		CNText * opttext = [opt toText] ;
		[optsec appendChildText: opttext] ;
	}
	
	CNTextSection * argsec = [[CNTextSection alloc] initWithTitle: @"Arguments:"] ;
	const struct CNListItem * argitem ;
	for(argitem = [self.commandLineArguments firstItem] ; argitem ; argitem = argitem->nextItem){
		NSString * argstr = (NSString *) CNObjectInListItem(argitem) ;
		CNTextLine * line = [[CNTextLine alloc] initWithString: argstr] ;
		[argsec appendChildText: line] ;
	}
	
	[text appendChildText: optsec] ;
	[text appendChildText: argsec] ;
	return text ;
}

+ (CBCommandLine *) parseArguments: (const char **) argv withCounts: (NSUInteger) argc withOptionDefinitions: (const struct CBOptionDefinition *) optdefs withError:(NSError *__autoreleasing *) error
{
	CBCommandLine * cmdline = [[CBCommandLine alloc] init] ;
	
	CNList *	args = [CBArgument parseArguments: argv withCount: argc] ;
	CBArgument *	arg ;
	while((arg = (CBArgument *) [args popObject]) != nil){
		NSError * errret = parseOneArgument(cmdline, arg, args, optdefs) ;
		if(errret){
			*error = errret ;
			return nil ;
		}
	}
	
	return cmdline ;
}

@end

static const struct CBOptionDefinition *
searchShortOptionDefinition(const struct CBOptionDefinition * optdefs, NSString * optname) ;
static const struct CBOptionDefinition *
searchLongOptionDefinition(const struct CBOptionDefinition * optdefs, NSString * optname) ;
static CBOption *
allocateOption(const struct CBOptionDefinition * targdef, CNList * nextargs, NSError ** error) ;
static CNValue *
decodeOption(CNValueType valuetype, NSString * value, NSError ** error) ;
static NSError *
unknownOptionError(CBArgumentType argtype, NSString * givenopt) ;
static NSError *
optionDoesNotHaveParameterError(CBArgumentType argtype, NSString * givenopt) ;

static NSError *
parseOneArgument(CBCommandLine * cmdline, CBArgument * arg, CNList * nextargs, const struct CBOptionDefinition * optdefs)
{
	NSError * error = nil ;
	if(LOCAL_DEBUG){
		NSString * argstr = [arg description] ;
		printf("ARG: %s\n", [argstr UTF8String]) ;
	}
	switch(arg.type){
		case CBNormalArgument: {
			[cmdline.commandLineArguments addObject: arg.value] ;
		} break ;
		case CBLongNameOptionArgument: {
			const struct CBOptionDefinition * targdef ;
			targdef = searchLongOptionDefinition(optdefs, arg.value) ;
			if(targdef){
				CBOption * opt = allocateOption(targdef, nextargs, &error) ;
				[cmdline.commandLineOptions addObject: opt] ;
			} else {
				error = unknownOptionError(CBLongNameOptionArgument, arg.value) ;
			}
		} break ;
		case CBShortNameOptionArgument: {
			const struct CBOptionDefinition * targdef ;
			targdef = searchShortOptionDefinition(optdefs, arg.value) ;
			if(targdef){
				CBOption * opt = allocateOption(targdef, nextargs, &error) ;
				[cmdline.commandLineOptions addObject: opt] ;
			} else {
				error = unknownOptionError(CBShortNameOptionArgument, arg.value) ;
			}
		} break ;
	}
	return error ;
}

static const struct CBOptionDefinition *
searchShortOptionDefinition(const struct CBOptionDefinition * optdefs, NSString * optname)
{
	char optchar = '\0' ;
	if(optname != nil && [optname length] == 1){
		const char * optstr = [optname UTF8String] ;
		optchar = optstr[0] ;
	} else {
		return NULL ;
	}
	for( ; !CBIsEndOfOptionDefinition(optdefs) ; optdefs++){
		if(optdefs->shortName == optchar){
			return optdefs ;
		}
	}
	return NULL ;
}

static const struct CBOptionDefinition *
searchLongOptionDefinition(const struct CBOptionDefinition * optdefs, NSString * optname)
{
	for( ; !CBIsEndOfOptionDefinition(optdefs) ; optdefs++){
		if(optdefs->longName != NULL && strcmp(optdefs->longName, [optname UTF8String]) == 0){
			return optdefs ;
		}
	}
	return NULL ;
}

static CBOption *
allocateOption(const struct CBOptionDefinition * targdef, CNList * nextargs, NSError ** error)
{
	CNValue * param = nil ;
	if(targdef->valueType != CNNilValue){
		CBArgument * paramarg = (CBArgument *) [nextargs popObject] ;
		if(paramarg.type == CBNormalArgument){
			param = decodeOption(targdef->valueType, paramarg.value, error) ;
		} else {
			*error = optionDoesNotHaveParameterError(paramarg.type, paramarg.value) ;
			return nil ;
		}
	}
	return [[CBOption alloc] initWithOptionDefinition: targdef withValue: param] ;
}

static CNValue *
decodeOption(CNValueType type, NSString * value, NSError ** error)
{
	return [CNValue stringToValue: value withType: type withError: error] ;
}

static NSError *
unknownOptionError(CBArgumentType argtype, NSString * givenopt)
{
	NSString * opttype = (argtype == CBLongNameOptionArgument) ? @"--" : @"-" ;
	NSString * message = [[NSString alloc] initWithFormat: @"Unknown option \"%s%s\"",
			      [opttype UTF8String], [givenopt UTF8String]] ;
	return [NSError parseErrorWithMessage: message] ;
}

static NSError *
optionDoesNotHaveParameterError(CBArgumentType argtype, NSString * givenopt)
{
	NSString * opttype = (argtype == CBLongNameOptionArgument) ? @"--" : @"-" ;
	NSString * message = [[NSString alloc] initWithFormat: @"No parameter given for option \"%s%s\"",
			      [opttype UTF8String], [givenopt UTF8String]] ;
	return [NSError parseErrorWithMessage: message] ;
}


