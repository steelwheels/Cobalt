/**
 * @file	CBToken.swift
 * @brief	Define CBToken class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Foundation

public enum CBToken
{
	case LongNameToken(name: String)
	case ShortNameToken(name: Character)
	case NormalToken(string: String)

	public var description: String {
		var result: String = ""
		switch self {
		case .LongNameToken(let lname):
			result = "L(\(lname))"
		case .ShortNameToken(let sname):
			result = "S(\(sname))"
		case .NormalToken(let nstr):
			result = "N(\(nstr))"
		}
		return result
	}
}

