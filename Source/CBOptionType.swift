/**
 * @file	CBOptionType.swift
 * @brief	Define CBOptionType class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Canary
import Foundation

public class CBOptionType
{
	public var shortName: 		Character?
	public var longName:  		String?
	public var parameterType:	CNValueType
	public var parameterNum:	Int
	public var helpInfo:		String

	public init(shortName sname: Character?, longName lname: String?, parameterType ptype: CNValueType, parameterNum pnum: Int, helpInfo help:String){
		shortName	= sname
		longName	= lname
		parameterType	= ptype
		parameterNum	= pnum
		helpInfo	= help
	}
}

