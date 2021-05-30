/**
 * @file	CBError.swift
 * @brief	Define CBError enum type
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import CoconutData
import Foundation

public enum CBError: Error
{
	case InternalError(place: String)
	case UnknownLongOptionName(name: String)
	case UnknownShortOptionName(name: Character)
	case TooFewParameter(optionType: CBOptionType, withShortName: Bool)
	case InvalidParameter(optionType: CBOptionType, withShortName: Bool, argument: String)
	case NoSubCommand
	case UnknownSubCommand(name: String)

	public func toObject() -> NSError {
		return NSError.parseError(message: self.description)
	}

	public var description: String {
		get {
			var result = "?"
			switch self {
			case .InternalError(let place):
				result = "Internal error: \(place)"
			case .UnknownLongOptionName(let name):
				result = "Unknown long option name: \(name)"
			case .UnknownShortOptionName(let name):
				result = "Unknown short option name: \(name)"
			case .InvalidParameter(let opttype, let withshort, let arg):
				let optname = optionName(optionType: opttype, withShortName: withshort)
				result = "Invalid parameter \"\(arg)\" for option \"\(optname)\""
			case .TooFewParameter(let opttype, let withshort):
				let optname = optionName(optionType: opttype, withShortName: withshort)
				result = "Too few parameter(s) for option \"\(optname)\""
			case .NoSubCommand:
				result = "Sub command is required but it is not given"
			case .UnknownSubCommand(let cmdname):
				result = "Unknown sub command: \"\(cmdname)\""
			}
			return result
		}
	}

	private func optionName(optionType opttype: CBOptionType, withShortName withshort: Bool) -> String {
		var result: String
		if withshort {
			if let sname = opttype.shortName {
				result = "\(sname)"
			} else {
				CNLog(logLevel: .error, message: "No short name", atFunction: #function, inFile: #file)
				result = "?"
			}
		} else {
			if let lname = opttype.longName {
				result = lname
			} else {
				CNLog(logLevel: .error, message: "No long name", atFunction: #function, inFile: #file)
				result = "?"
			}
		}
		return result
	}
}
