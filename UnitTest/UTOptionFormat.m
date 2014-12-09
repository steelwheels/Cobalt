/**
 * @file	UTOptionFormat
 * @brief	UnitTest for CBOptionFormat class in Cobalt Framework
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

void
UTOptionFormatTest(void)
{
	CNList * optlist = [CBOptionFormat generateOptionFormats: s_optdefs] ;
	
	puts("*** Option formats") ;
	const struct CNListItem * item = [optlist firstItem] ;
	for( ; item ; item = item->nextItem){
		CBOptionFormat * form = (CBOptionFormat *) CNObjectInListItem(item) ;
		[form printToFile: stdout] ;
	}
}
