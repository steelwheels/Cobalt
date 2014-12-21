/**
 * @file	UTCommandLine.m
 * @brief	UnitTest for CBCommandLine class in Cobalt Framework
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import "UnitTest.h"

enum {
	OPTION_OPT1,
	OPTION_OPT2,
	OPTION_OPT3
} ;

static const struct CBOptionDefinition s_optdefs[] = {
	{OPTION_OPT1, 's',  "opt1", CNNilValue, NULL, "sample option 1"},
	{OPTION_OPT2, '\0', "opt2", CNSignedIntegerValue, "size", "sample option 2"},
	{OPTION_OPT3, 'a',  NULL,   CNBooleanValue, "bool", "sample option 3"},
	CBEndOfOptionDefinition
} ;

static void
commandLineTest(int argc, const char ** argv) ;
static void
optionTest(int optionid, CBCommandLine * cmdline) ;

void UTCommandLineTest(void)
{
#	define ARGNUM(ARG)	(sizeof(ARG) / sizeof(const char *))
	
	const char * argv0[] = {"hello"} ;
	commandLineTest(ARGNUM(argv0), argv0) ;
	
	const char * argv1[] = {"--opt1"} ;
	commandLineTest(ARGNUM(argv1), argv1) ;
}

static void
commandLineTest(int argc, const char ** argv)
{
	CBCommandLine * cmdline ;
	NSError * error = nil ;
	cmdline = [CBCommandLine parseArguments: argv
				     withCounts: argc
			  withOptionDefinitions: s_optdefs
				      withError: &error] ;
	if(cmdline == nil){
		puts("-- parseArguments: NG") ;
		[error printToFile: stdout] ;
		return ;
	}
	
	puts("-- parseArguments: OK") ;
	CNText * cmdlineinfo = [cmdline toText] ;
	puts("-- print command line info") ;
	[cmdlineinfo printToFile: stdout] ;
	
	optionTest(OPTION_OPT1, cmdline) ;
	optionTest(OPTION_OPT2, cmdline) ;
	optionTest(OPTION_OPT3, cmdline) ;
	
	puts("-- print argument") ;
	const struct CNListItem * item = [cmdline firstArgument] ;
	BOOL isfirstitem = YES ;
	for( ; item ; item = item->nextItem){
		if(!isfirstitem){
			fputs(", ", stdout) ;
		}
		NSString * str = (NSString *) CNObjectInListItem(item) ;
		fputs([str UTF8String], stdout) ;
		isfirstitem = NO ;
	}
	fputs("\n", stdout) ;
}

static void
optionTest(int optionid, CBCommandLine * cmdline)
{
	printf("-- Check option id %d\n", optionid) ;
	
	CBOption * opt = [cmdline searchOptionById: optionid] ;
	if(opt){
		if(opt.optionValue){
			NSString * valstr = [opt.optionValue description] ;
			fprintf(stdout, " -> Found with argument \"%s\"\n",
				[valstr UTF8String]) ;
		} else {
			fputs(" -> Found without argument\n", stdout) ;
		}
	} else {
		fputs(" -> No such option\n", stdout) ;
	}
}
