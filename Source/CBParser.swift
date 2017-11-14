/**
 * @file	CBAParser.swift
 * @brief	Define CBParser class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Canary
import Foundation

public enum CBToken
{
	case LongNameToken(name: String)
	case ShortNameToken(name: Character)
	case NormalToken(string: String)
}

public func CBTokenizeArguments(optionTypes otypes: Array<CBOptionType>, arguments args: Array<String>) -> (Array<CBToken>, Array<CBError>)
{
	let parser = CBTokenizer()
	for arg in args {
		parser.parse(argument: arg)
	}
	return (parser.result, parser.errors)
}

private class CBTokenizer
{
	public var	result: Array<CBToken>
	public var	errors: Array<CBError>

	public init(){
		result	= []
		errors  = []
	}

	public func parse(argument arg: String){
		let stream = CNStringStream(string: arg)
		skipSpace(stream: stream)
		if let c0 = stream.peek(offset: 0) {
			if c0 == "-" {
				if let c1 = stream.peek(offset: 1) {
					if c1 == "-" {
						if stream.peek(offset: 2) != nil {
							/* Long name option */
							stream.skip(count: 2)
							if let str = streamToString(stream: stream) {
								result.append(CBToken.LongNameToken(name: str))
							} else {
								fatalError("Can not happen")
							}
						}
					} else {
						/* Short name option */
						stream.skip(count: 2)
						result.append(CBToken.ShortNameToken(name: c1))
						if let str = streamToString(stream: stream) {
							result.append(CBToken.NormalToken(string: str))
						}
						return
					}
				}
			}
		}
		if let str = streamToString(stream: stream) {
			result.append(CBToken.NormalToken(string: str))
		}
	}

	private func streamToString(stream strm: CNStringStream) -> String? {
		var result = ""
		var docont = true
		while docont {
			if let c = strm.getc() {
				result.append(c)
			} else {
				docont = false
			}
		}
		if result.count > 0 {
			return result
		} else {
			return nil
		}
	}

	private func skipSpace(stream strm: CNStringStream){
		var docont = true
		while docont {
			if let c = strm.getc() {
				if !c.isSpace() {
					let _ = strm.ungetc()
					docont = false
				}
			} else {
				docont = false
			}
		}
	}
}

