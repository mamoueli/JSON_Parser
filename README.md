# JSON Parser
A custom JSON Parser created using flex & bison to compile JSON files from : https://www.opap.gr/web-services

# How to compile the program
In order to execute the program it is essential to have a compiler.
For Linux users type:

1 sudo apt install make

2 sudo apt install gcc

3 sudo apt-get install flex bison

For windows users cygwin is the best option without using virtual machine.

To download and use linux through windows follow these steps : https://code.visualstudio.com/docs/remote/wsl

# How to execute
For compiling flex & bison type these comands:

1 bison –d bisonparser.y

2 flex lexanalizer.l

3 gcc –o run lex.yy.c bisonparser.tab.c –lfl

4 ./run testFile

Where test file == the name of the file you want to compile

# Authors
Jogrkpl: https://github.com/Jogrkpl

mamoueli: https://github.com/mamoueli

Filipposgm: https://github.com/Filipposgm

# Known issues
nothing yet
