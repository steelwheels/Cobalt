/**
 * @file    main.swift
 * @brief   Main function for unit test
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Cobalt
import CoconutData
import Foundation

let console = CNFileConsole()
console.print(string: "[Unit Test]\n")

UTTokenizer(console: console)
UTParser(console: console)

console.print(string: "Bye\n\n")

