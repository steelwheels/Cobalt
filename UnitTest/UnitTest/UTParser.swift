/**
 * @file    UTParser.swift
 * @brief   Unit test for CNParseArguments function
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Cobalt
import Canary
import Foundation

public func UTParser(console cons: CNConsole)
{
	let verbose_opt	= CBOptionType(shortName: nil, longName: "verbose", parameterNum: 0, parameterType: .VoidType, helpInfo: "print verbose message")
	let file_opt	= CBOptionType(shortName: "f", longName: "file", parameterNum: 1, parameterType: .StringType, helpInfo: "file name")
	let opts = [verbose_opt, file_opt]

	parseTest(optionTypes: opts, arguments: ["a", "b"], console: cons)
	parseTest(optionTypes: opts, arguments: ["-fa", "-f", "b", "--file", "c"], console: cons)
}

private func parseTest(optionTypes opttypes : Array<CBOptionType>, arguments args: Array<String>, console cons: CNConsole)
{
	/* print input */
	var is1st = true
	console.print(string: "[")
	for arg in args {
		if is1st {
			is1st = false
		} else {
			console.print(string: ", ")
		}
		console.print(string: arg)
	}
	console.print(string: "] -> ")

	/* parse argument */
	let (error, results) = CBParseArguments(optionTypes: opttypes, arguments:  args)
	if let e = error {
		console.print(string: "[Error] \(e.description)\n")
	} else {
		var cmdline = ""
		for result in results {
			cmdline += result.description + " "
		}
		console.print(string: "[Result] " + cmdline + "\n")
	}
}
