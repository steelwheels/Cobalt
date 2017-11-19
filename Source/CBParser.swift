/**
 * @file	CBParser.swift
 * @brief	Define CBParser class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Foundation

public func CBParseArguments(optionTypes opttypes: Array<CBOptionType>, arguments args: Array<String>) -> (CBError?, Array<CBArgument>)
{
	let tokens = CBTokenizeArguments(arguments: args)
	return CBParseToken(tokens: tokens, optionTypes: opttypes)
}

