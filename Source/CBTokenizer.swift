/**
 * @file	CBTokenizer.swift
 * @brief	Define CBParser class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import CoconutData
import Foundation

public func CBTokenizeArguments(arguments args: Array<String>) -> (Array<CBToken>, Array<String>)
{
	let parser     			= CBTokenizer()
	var terminated 			= false
	var subargs: Array<String> 	= []
	for arg in args {
		if !terminated {
			parser.parse(argument: arg)
		} else {
			subargs.append(arg)
		}
		terminated = parser.terminated
	}
	return (parser.result, subargs)
}

private class CBTokenizer
{
	public var	result: 	Array<CBToken>
	public var	terminated:	 Bool
	public init(){
		result	   = []
		terminated = false
	}

	public func parse(argument arg: String) {
		let stream = CNStringStream(string: arg)
		skipSpace(stream: stream)
		if let c0 = stream.peek(offset: 0) {
			if c0 == "-" {
				parseOption(argument: stream)
			}
		}
		/* append as the normal string */
		if let str = streamToString(stream: stream){
			result.append(CBToken.NormalToken(string: str))
		}
	}

	public func parseOption(argument stream: CNStringStream) {
		/* 1st char is "-" */
		if let c0 = stream.peek(offset: 1) {
			if c0 == "-" {
				parseLongOption(argument: stream)
			} else {
				parseShortOption(argument: stream)
			}
		}
	}

	public func parseLongOption(argument stream: CNStringStream) {
		/* 1st and 2nd char is "-" */
		if let c0 = stream.peek(offset: 2) {
			if c0.isLetter {
				stream.skip(count: 2) // drop 1st and 2nd "-"
				if let str = streamToString(stream: stream){
					result.append(CBToken.LongNameToken(name: str))
				}
			} else if c0.isWhitespace {
				stream.skip(count: 2) // drop 1st and 2nd "-"
				terminated = true
			}
		} else {
			stream.skip(count: 2) // drop 1st and 2nd "-"
			terminated = true
		}
	}

	public func parseShortOption(argument stream: CNStringStream) {
		/* 1st char is "-"  */
		if let c0 = stream.peek(offset: 1) {
			if c0.isLetter {
				result.append(CBToken.ShortNameToken(name: c0))
				stream.skip(count: 2) // drop 1st "-" and 2nd alphabet
				if let str = streamToString(stream: stream) {
					result.append(CBToken.NormalToken(string: str))
				}
			}
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
				if !c.isWhitespace {
					let _ = strm.ungetc()
					docont = false
				}
			} else {
				docont = false
			}
		}
	}
}

