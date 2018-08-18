/**
 * @file    UTParser.swift
 * @brief   Unit test for CNParseArguments function
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Cobalt
import CoconutData
import Foundation

public func UTParser(console cons: CNConsole)
{
	let verbose_opt	= CBOptionType(optionId:0 , shortName: nil, longName: "verbose", parameterNum: 0, parameterType: .VoidType, helpInfo: "print verbose message")
	let file_opt	= CBOptionType(optionId:1, shortName: "f", longName: "file", parameterNum: 1, parameterType: .StringType, helpInfo: "file name")
	let opts = [verbose_opt, file_opt]

	parseTest(optionTypes: opts, arguments: ["a", "b"], console: cons)
	parseTest(optionTypes: opts, arguments: ["-fa", "-f", "b", "--file", "c"], console: cons)
	parseTest(optionTypes: opts, arguments: ["-NSDocumentRevisionsDebugMode", "YES", "a", "b"], console: cons)
	parseCommandTest(command: "file", optionTypes: opts, arguments: ["file", "-fa", "-f", "b", "--file", "c"], console: cons)
	parseCommandTest(command: "file", optionTypes: opts, arguments: ["file", "-fa", "--", "b", "--file", "c"], console: cons)
	parseCommandTest(command: "file", optionTypes: opts, arguments: ["--help"], console: cons)
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

	/* allocate config */
	let config = CBParserConfig(hasSubCommand: false)
	config.setDefaultOptions(optionTypes: opttypes)

	/* parse argument */
	let (error, command, results, subargs) = CBParseArguments(parserConfig: config, arguments:  args)
	if let e = error {
		console.print(string: "[Error] \(e.description)\n")
	} else {
		let cmdstr: String
		if let c = command {
			cmdstr = c
		} else {
			cmdstr = "nil"
		}

		var cmdline = ""
		for result in results {
			cmdline += result.description + " "
		}

		var substr = ""
		for subarg in subargs {
			substr += subarg + " "
		}
		console.print(string: "[Result] command=\(cmdstr), args=[\(cmdline)], subargs=[\(substr)]\n")
	}
}

private func parseCommandTest(command cmd: String, optionTypes opttypes : Array<CBOptionType>, arguments args: Array<String>, console cons: CNConsole)
{
	let help_opt	= CBOptionType(optionId:0 , shortName: nil, longName: "help", parameterNum: 0, parameterType: .VoidType, helpInfo: "print help message")

	/* allocate config */
	let config = CBParserConfig(hasSubCommand: true)
	config.addSubCommand(commandName: cmd, optionTypes: opttypes)
	config.setDefaultOptions(optionTypes: [help_opt])

	/* parse argument */
	let (error, command, results, subargs) = CBParseArguments(parserConfig: config, arguments: args)
	if let e = error {
		console.print(string: "[Error] \(e.description)\n")
	} else {
		let cmdstr: String
		if let c = command {
			cmdstr = c
		} else {
			cmdstr = "nil"
		}

		var cmdline = ""
		for result in results {
			cmdline += result.description + " "
		}

		var substr = ""
		for subarg in subargs {
			substr += subarg + " "
		}
		console.print(string: "[Result] command=\(cmdstr), args=[\(cmdline)] + subargs=[\(substr)]\n")
	}
}

