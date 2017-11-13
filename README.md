# Cobalt

## Introduction
The cobalt framework is used to analyze command line options and arguments for console application

## Target
* macOS: 10.13 (High Sierra) or later

## Copyright
This software is distributed under [GNU LESSER GENERAL PUBLIC LICENSE Version 2.1](https://www.gnu.org/licenses/lgpl-2.1-standalone.html).

## Command line format
The command line arguments are classified into following kinds
  * --opt : Long name option. The "opt" matched with a word. The option can have zero, one or more parameters.
  * -o    : Short name option. The "o" matched with an alphabet. The option can have zero, one or more parameters. The argument can be follow the alphabet without any spaces like "-ofile".
  * word  : Normal argument.
