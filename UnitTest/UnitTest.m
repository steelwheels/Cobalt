/**
 * @file	UnitTest.m
 * @brief	UnitTest for Cobalt Framework
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import "UnitTest.h"

static void printTestName(const char * name) ;

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		printTestName("CBArgument") ;		UTArgumentTest() ;
		printTestName("CBOptionDefinition") ;	UTOptionDefinitionTest() ;
	}
    return 0;
}

static void
printLine(void)
{
	NSUInteger	i ;
	for(i=0 ; i<80 ; i++){
		fputc('-', stdout) ;
	}
	fputc('\n', stdout) ;
}

static void
printTestName(const char * name)
{
	printLine() ;
	printf("* %s\n", name) ;
	printLine() ;
}