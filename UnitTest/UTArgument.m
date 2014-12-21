/**
 * @file	UTArgument.m
 * @brief	UnitTest for CBArgument class in Cobalt Framework
 * @par Copyright
 *   Copyright (C) 2014 Steel Wheels Project
 */

#import "UnitTest.h"
#import <Coconut/Coconut.h>

static void
argumentTest(NSUInteger count, const char ** argv) ;

#define	ARGNUM(ARGV)	(sizeof(ARGV) / sizeof(const char *))

void
UTArgumentTest(void)
{
	{
	  const char * argv0[] = {
		"hello"
	  } ;
	  argumentTest(ARGNUM(argv0), argv0) ;
	}
	{
	  const char * argv1[] = {
		"--help",
		"-v",
		"file"
	  } ;
	  argumentTest(ARGNUM(argv1), argv1) ;
	}
	{
	  const char * argv1[] = {
		"--verbose",
		"-ab",
		"-o./ofile",
		"file"
	  } ;
	  argumentTest(ARGNUM(argv1), argv1) ;
	}
}

static void
argumentTest(NSUInteger count, const char ** argv)
{
	printf("%s : count %u\n", __func__, (unsigned int) count) ;
	
	CNList * arglist = [CBArgument parseArguments: argv withCount: count] ;
	const struct CNListItem * item ;
	for(item = [arglist firstItem] ; item ; item = item->nextItem){
		CBArgument * arg = (CBArgument *) CNObjectInListItem(item) ;
		UTPrintArgument(arg) ;
	}
}

void
UTPrintArgument(CBArgument * src)
{
	switch(src.type){
		case CBNormalArgument:		fputs("(normal: ", stdout) ;		break ;
		case CBLongNameOptionArgument:	fputs("(long-name-opt: ", stdout) ;	break ;
		case CBShortNameOptionArgument:	fputs("(short-name-opt: ", stdout) ;	break ;
	}
	printf("\"%s\")\n", [src.value UTF8String]) ;
}
