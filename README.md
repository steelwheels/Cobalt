# Cobalt

## Introduction
The cobalt framework is used to analyze command line options and arguments for console application

## Copyright
This software is distributed under [GNU LESSER GENERAL PUBLIC LICENSE Version 2.1](https://www.gnu.org/licenses/lgpl-2.1-standalone.html).

## Specifications
### Sub command support
The configuration of command line parser is defined by `CBParserConfig` class. It supports sub command on the command line arguments.
This is syntax of command line which has sub command.
````
command sub-command [options] [arguments]
````

### Command line format
The command line arguments are classified:
  * --opt : *Long name option*. The "opt" matched with a word
  * -o    : *Short name option*. The "o" matched with an alphabet. If multiple characters follows the option, the string except the 1st character is recognized as a option parameter. (ex. "-abc" is treated as "-a" option and parameter "bc" for it.)
  * word  : *Normal argument*. It is not option, This will be option parameter or command line argument

## Required software
  This software depend on the following framework:
  * [Coconut Frameworks](https://github.com/steelwheels/Coconut/blob/master/README.md)

## Related Links
* [Steel Wheels Project](http://steelwheels.github.io): Main page of this project
* [GitHub Repository](https://github.com/steelwheels): Software repository.
