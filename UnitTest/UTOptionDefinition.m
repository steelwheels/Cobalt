/**
 * @file	UTOptionDefinition.m
 * @brief	UnitTest for CBOptionDefinition class in Cobalt Framework
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
UTOptionDefinitionTest(void)
{
	const struct CBOptionDefinition * defs = s_optdefs ;
	for( ; !CBIsEndOfOptionDefinition(defs) ; defs++){
		CNText * text = CBOptionDefinitionToString(defs) ;
		[text printToFile: stdout] ;
	}
}
