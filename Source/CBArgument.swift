/**
 * @file	CBArgument.swift
 * @brief	Define CBArgument class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Canary
import Foundation

open class CBArgument
{

}

public class CBOptionArgument: CBArgument
{
	public var optionType:	CBOptionType
	public var parameters:	Array<CNValue>

	public init(optionType otype: CBOptionType){
		optionType	= otype
		parameters 	= []
	}
}

public class CBNormalArgument: CBArgument
{
	public var argument: String

	public init(argument arg: String){
		argument = arg
	}
}
