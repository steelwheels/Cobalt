/**
 * @file	CBParserConfig.swift
 * @brief	Define CBParserConfig class
 * @par Copyright
 *   Copyright (C) 2018 Steel Wheels Project
 */

import Foundation

public class CBParserConfig
{
	private static let NullCommandName: String	= "_"

	private var mHasSubCommand:	Bool
	private var mOptionTypeTable:	Dictionary<String, Array<CBOptionType>>

	public init(hasSubCommand hascmd: Bool){
		mHasSubCommand   = hascmd
		mOptionTypeTable = [:]
	}

	public var hasSubCommand: Bool { get { return mHasSubCommand }}

	public func optionTypes(commandName name: String) -> Array<CBOptionType>? {
		return mOptionTypeTable[name]
	}

	public func defaultOptionTypes() -> Array<CBOptionType>? {
		return mOptionTypeTable[CBParserConfig.NullCommandName]
	}

	public func addSubCommand(commandName name: String, optionTypes opttyps: Array<CBOptionType>) {
		mOptionTypeTable[name] = opttyps
	}

	public func setDefaultOptions(optionTypes opttyps: Array<CBOptionType>) {
		addSubCommand(commandName: CBParserConfig.NullCommandName, optionTypes: opttyps)
	}
}
