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
	open var description: String {
		get { return "" }
	}
}

public class CBOptionArgument: CBArgument
{
	public var optionType:	CBOptionType
	public var parameters:	Array<CNValue>

	public init(optionType otype: CBOptionType){
		optionType	= otype
		parameters 	= []
	}

	public override var description: String {
		get {
			var result: String = ""
			if let lname = optionType.longName {
				result += "--\(lname)"
			} else if let sname = optionType.shortName {
				result += "-\(sname)"
			}
			for param in parameters {
				result += " " + param.description
			}
			return result
		}
	}
}

public class CBNormalArgument: CBArgument
{
	public var argument: String

	public init(argument arg: String){
		argument = arg
	}

	public override var description: String {
		get { return argument }
	}
}
