The CRUX compiler takes in CRUX files which follow CRUX grammar.

CRUX compiler scans, parses, and tokenizes the characters of the CRUX file. These tokens then are converted to symbols, which create an abstract syntax tree. By walking down the tree CRUX completes various type and error checks, and finishes by generating (MIPS) assembly code.

For an in-depth description go here: http://davidpynes.github.io/Crux-Compiler/
