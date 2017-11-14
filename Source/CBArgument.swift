/**
 * @file	CBArgument.swift
 * @brief	Define CBArgument class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Foundation

open class CBArgument
{
	public var string: String = ""
}

public class CBOption: CBArgument
{
	public var optionType:	CBOptionType

	public init(optionType otype: CBOptionType){
		optionType	= otype
	}
}
