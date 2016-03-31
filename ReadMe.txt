The CRUX compiler takes in CRUX files which follow CRUX grammar.

The compiler scans, parses, and tokenizes the characters. Then these tokens are converted to symbols which are used to create a abstract syntax tree. By walking the tree the CRUX compiler does various type and error checks and generates (MIPS) assembly code.

For an in-depth description go here: http://davidpynes.github.io/Crux-Compiler/
