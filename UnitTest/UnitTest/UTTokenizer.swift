/**
 * @file    UTTokenizer.swift
 * @brief   Unit test for CBTokenizer
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import CoconutData
import Cobalt
import Foundation

public func UTTokenizer(console cons: CNConsole)
{
    	tokenize(console: cons, arguments: ["abc"])
	tokenize(console: cons, arguments: ["a b c"])
	tokenize(console: cons, arguments: ["-fa"])
	tokenize(console: cons, arguments: ["--file", "file-a"])
}

private func tokenize(console cons: CNConsole, arguments args: Array<String>)
{
    	cons.print(string: "[")
	for arg in args {
		cons.print(string: "\(arg) ")
	}
    	cons.print(string: "] ... ")

    	let tokens = CBTokenizeArguments(arguments: args)
    	for token in tokens {
        	cons.print(string: token.description + " ")
	}
	cons.print(string: "\n")
}
