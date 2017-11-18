/**
 * @file	CBError.swift
 * @brief	Define CBError enum type
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Canary
import Foundation

public enum CBError: Error
{
	case UnknownLongOptionName(name: String)
	case UnknownShortOptionName(name: Character)
	case TooFewParameter(optionType: CBOptionType)
	case InvalidParameter(optionType: CBOptionType, argument: String)
}
