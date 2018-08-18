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
	tokenize(console: cons, arguments: ["a", "-b", "--", "c", "--de"])
}

private func tokenize(console cons: CNConsole, arguments args: Array<String>)
{
    	cons.print(string: "[")
	for arg in args {
		cons.print(string: "\(arg) ")
	}
    	cons.print(string: "] ... ")

    	let (tokens, subargs) = CBTokenizeArguments(arguments: args)
    	for token in tokens {
        	cons.print(string: token.description + " ")
	}
	if subargs.count > 0 {
		cons.print(string: "[")
		for subarg in subargs {
			cons.print(string: "U(\(subarg)) ")
		}
		cons.print(string: "]")
	}
	cons.print(string: "\n")
}
