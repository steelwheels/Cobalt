/**
 * @file	CBValue.swift
 * @brief	Define CBValue class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Foundation

public enum CBValueType: Int {
	case intType
	case doubleType
	case stringType
}

public enum CBValue {
	case intValue(Int)
	case doubleValue(Double)
	case stringValue(String)

	public var description: String { get {
		let result: String
		switch self {
		case .intValue(let val):
			result = "\(val)"
		case .doubleValue(let val):
			result = "\(val)"
		case .stringValue(let str):
			result = str
		}
		return result
	}}
}

public func CBStringToValue(type ptype: CBValueType, string str: String) -> CBValue? {
	var result: CBValue? = nil
	switch ptype {
	case .intType:
		if let val = Int(str) {
			result = .doubleValue(Double(val))
		}
	case .doubleType:
		if let val = Double(str) {
			result = .doubleValue(val)
		} else if let val = Int(str) {
			result = .doubleValue(Double(val))
		}
	case .stringType:
		result = .stringValue(str)
	}
	return result
}
