/**
 * @file	UTCommandLine.m
 * @brief	UnitTest for CBCommandLine class in Cobalt Framework
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import "UnitTest.h"

static const struct CBOptionDefinition s_optdefs[] = {
	{0, 's',  "opt1", CNNilValue, NULL, "sample option 1"},
	{1, '\0', "opt2", CNSignedIntegerValue, "size", "sample option 2"},
	{2, 'a',  NULL,	  CNBooleanValue, "bool", "sample option 3"},
	CBEndOfOptionDefinition
} ;

static void
commandLineTest(int argc, const char ** argv) ;

void UTCommandLineTest(void)
{
	const char * argv0[] = {"hello"} ;
	commandLineTest(1, argv0) ;
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
	if(cmdline){
		puts("-- parseArguments: OK") ;
		CNText * cmdlineinfo = [cmdline toText] ;
		puts("-- print command line info") ;
		[cmdlineinfo printToFile: stdout] ;
		puts("-- end of command line info") ;
	} else {
		puts("-- parseArguments: NG") ;
		[error printToFile: stdout] ;
	}
}
