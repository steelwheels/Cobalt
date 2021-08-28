/**
 * @file	CBOptionType.swift
 * @brief	Define CBOptionType class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import CoconutData
import Foundation

public class CBOptionType
{
	public var optionId:		Int
	public var shortName: 		Character?
	public var longName:  		String?
	public var parameterType:	CBValueType
	public var parameterNum:	Int
	public var helpInfo:		String

	public init(optionId oid: Int, shortName sname: Character?, longName lname: String?, parameterNum pnum: Int, parameterType ptype: CBValueType, helpInfo help:String){
		optionId	= oid
		shortName	= sname
		longName	= lname
		parameterNum	= pnum
		parameterType	= ptype
		helpInfo	= help
	}

	public var optionDescription: String {
		var result: String
		if let lname = longName {
			result = "--\(lname)"
		} else if let sname = shortName {
			result = "-\(sname)"
		} else {
			fatalError("Can not happen")
		}
		return result
	}
}

