/**
 * @file	CBParser.swift
 * @brief	Define CBParser class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Foundation

public func CBParseArguments(parserConfig config: CBParserConfig, arguments args: Array<String>) -> (NSError?, String?, Array<CBArgument>, Array<String>)
{
	let newargs   	      = removeNeedlessOptions(arguments: args)
	let (tokens, subargs) = CBTokenizeArguments(arguments: newargs)

	if config.hasSubCommand {
		if tokens.count >= 1 {
			let firsttkn = tokens[0]
			switch firsttkn {
			case .LongNameToken(_), .ShortNameToken(_):
				return parseDefaultOptions(parserConfig: config, tokens: tokens, subArguments: subargs)
			case .NormalToken(let command):
				if tokens.count >= 2 {
					if let opttypes = config.optionTypes(commandName: command){
						var subtokens = tokens
						subtokens.removeFirst()
						let (err, args) = CBParseToken(tokens: subtokens, optionTypes: opttypes)
						return (errorToObject(error: err), command, args, subargs)
					} else {
						let err: CBError = .InternalError(place: "CBParseArguments")
						return (errorToObject(error: err), nil, [], [])
					}
				} else {
					return (nil, command, [], [])
				}
			}
		} else {
			let err: CBError = .NoSubCommand
			return (errorToObject(error: err), nil, [], [])
		}
	} else {
		return parseDefaultOptions(parserConfig: config, tokens: tokens, subArguments: subargs)
	}
}

private func removeNeedlessOptions(arguments args: Array<String>) -> Array<String>
{
	var result	: Array<String> = []
	var doskip	: Bool = false

	/* Do not copy "-NSDocumentRevisionsDebugMode" and it's value */
	for arg in args {
		if arg.caseInsensitiveCompare("-NSDocumentRevisionsDebugMode") == .orderedSame {
			doskip = true
			continue
		}
		if !(doskip && isYesNo(arg)) {
			result.append(arg)
		}
		doskip = false
	}
	return result
}

private func isYesNo(_ str: String) -> Bool {
	return ((str.caseInsensitiveCompare("yes") == .orderedSame)
		|| (str.caseInsensitiveCompare("no") == .orderedSame))
}

private func parseDefaultOptions(parserConfig config: CBParserConfig, tokens srctkns: Array<CBToken>, subArguments subargs: Array<String>) -> (NSError?, String?, Array<CBArgument>, Array<String>)
{
	if let opttypes = config.defaultOptionTypes() {
		let (err, args) = CBParseToken(tokens: srctkns, optionTypes: opttypes)
		return (errorToObject(error: err), nil, args, subargs)
	} else {
		let err: CBError = .InternalError(place: "parseDefaultOptions")
		return (errorToObject(error: err), nil, [], [])
	}
}

private func errorToObject(error err: CBError?) -> NSError? {
	if let e = err {
		return e.toObject()
	} else {
		return nil
	}
}


