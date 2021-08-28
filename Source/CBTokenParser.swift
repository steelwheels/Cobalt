/**
 * @file	CBParser.swift
 * @brief	Define CBParser class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import CoconutData
import Foundation

public func CBParseToken(tokens tks: Array<CBToken>, optionTypes opttypes: Array<CBOptionType>) -> (CBError?, Array<CBArgument>)
{
	let parser = CBTokenParser(optionTypes: opttypes)
	parser.parse(tokens: tks)
	return (parser.error, parser.results)
}

private class CBTokenParser
{
	private var optionTypes:	Array<CBOptionType>
	public var results:		Array<CBArgument>
	public var error:		CBError?

	public init(optionTypes opttypes: Array<CBOptionType>){
		optionTypes	= opttypes
		results 	= []
		error		= nil
	}

	public func parse(tokens tks: Array<CBToken>){
		do {
			try parseTokens(tokens: tks)
		} catch let err {
			if let e = err as? CBError {
				error = e
			} else {
				fatalError("Invalid error type")
			}
		}
	}

	public func parseTokens(tokens tks: Array<CBToken>) throws {
		let stream = CNArrayStream(source: tks)
		while true {
			if let token = stream.get() {
				switch token {
				case .LongNameToken(let name):
					if let opt = searchLongNameOption(optionName: name) {
						try parseOption(optionType: opt, withShortName: false, tokenStream: stream)
					} else {
						throw CBError.UnknownLongOptionName(name: name)
					}
				case .ShortNameToken(let name):
					if let opt = searchShortNameOption(optionName: name) {
						try parseOption(optionType: opt, withShortName: true, tokenStream: stream)
					} else {
						throw CBError.UnknownShortOptionName(name: name)
					}
				case .NormalToken(let str):
					results.append(CBNormalArgument(argument: str))
				}
			} else {
				break
			}
		}
	}

	private func searchLongNameOption(optionName optname: String) -> CBOptionType? {
		for opttype in optionTypes {
			if opttype.longName == optname {
				return opttype
			}
		}
		return nil
	}

	private func searchShortNameOption(optionName optname: Character) -> CBOptionType? {
		for opttype in optionTypes {
			if opttype.shortName == optname {
				return opttype
			}
		}
		return nil
	}

	private func parseOption(optionType opttype: CBOptionType, withShortName withshort: Bool,tokenStream stream: CNArrayStream<CBToken>) throws {
		let opt = CBOptionArgument(optionType: opttype)
		results.append(opt)
		for _ in 0..<opttype.parameterNum {
			if let arg = stream.get() {
				if let val = try decodeArgument(optionType: opttype, withShortName: withshort, parameterType: opttype.parameterType, argument: arg) {
					opt.parameters.append(val)
				}
			} else {
				throw CBError.TooFewParameter(optionType: opttype, withShortName: withshort)
			}
		}
	}

	private func decodeArgument(optionType opttype: CBOptionType, withShortName withshort: Bool, parameterType ptype: CBValueType, argument arg: CBToken) throws -> CBValue? {
		switch arg {
		case .LongNameToken(_), .ShortNameToken(_):
			throw CBError.TooFewParameter(optionType: opttype, withShortName: withshort)
		case .NormalToken(let str):
			if let val = CBStringToValue(type: ptype, string: str) {
				return val
			} else {
				throw CBError.InvalidParameter(optionType: opttype, withShortName: withshort, argument: str)
			}
		}
	}
}
