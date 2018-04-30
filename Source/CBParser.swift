/**
 * @file	CBParser.swift
 * @brief	Define CBParser class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Foundation

public func CBParseArguments(parserConfig config: CBParserConfig, arguments args: Array<String>) -> (NSError?, String?, Array<CBArgument>)
{
	let tokens = CBTokenizeArguments(arguments: args)

	if config.hasSubCommand {
		if tokens.count >= 1 {
			let firsttkn = tokens[0]
			switch firsttkn {
			case .LongNameToken(_), .ShortNameToken(_):
				return parseDefaultOptions(parserConfig: config, tokens: tokens)
			case .NormalToken(let command):
				if tokens.count >= 2 {
					if let opttypes = config.optionTypes(commandName: command){
						var subtokens = tokens
						subtokens.removeFirst()
						let (err, args) = CBParseToken(tokens: subtokens, optionTypes: opttypes)
						return (errorToObject(error: err), command, args)
					} else {
						let err: CBError = .InternalError(place: "CBParseArguments")
						return (errorToObject(error: err), nil, [])
					}
				} else {
					return (nil, command, [])
				}
			}
		} else {
			let err: CBError = .NoSubCommand
			return (errorToObject(error: err), nil, [])
		}
	} else {
		return parseDefaultOptions(parserConfig: config, tokens: tokens)
	}
}

private func parseDefaultOptions(parserConfig config: CBParserConfig, tokens srctkns: Array<CBToken>) -> (NSError?, String?, Array<CBArgument>)
{
	if let opttypes = config.defaultOptionTypes() {
		let (err, args) = CBParseToken(tokens: srctkns, optionTypes: opttypes)
		return (errorToObject(error: err), nil, args)
	} else {
		let err: CBError = .InternalError(place: "parseDefaultOptions")
		return (errorToObject(error: err), nil, [])
	}
}

private func errorToObject(error err: CBError?) -> NSError? {
	if let e = err {
		return e.toObject()
	} else {
		return nil
	}
}


