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
	public var description:		String

	public init(shortName sname: Character?, longName lname: String?, parameterType ptype: CNValueType, description desc:String){
		shortName	= sname
		longName	= lname
		parameterType	= ptype
		description	= desc
	}
}

