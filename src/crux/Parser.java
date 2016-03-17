package crux;

import java.util.List;
import java.util.LinkedList;
import java.util.Stack;

import ast.Command;
import types.*;

public class Parser {
	 public static String studentName = "David Pynes";
	public static String studentID = "45557742";
	public static String uciNetID = "dpynes";
	   
	private int parseTreeRecursionDepth = 0;
	private StringBuilder parseTreeBuffer = new StringBuilder();
    private SymbolTable symbolTable;
	private StringBuilder errorBuffer = new StringBuilder();
	private Scanner scanner;
	private Token currentToken;

	// Parser ==========================================
	public Parser(Scanner scanner) {
		this.scanner = scanner;
		symbolTable = new SymbolTable();
	}

	public ast.Command parse() {
        initSymbolTable();
		currentToken = scanner.next();
		try {
			return program();
		} catch (QuitParseException qpe) {
			errorBuffer.append("SyntaxError(" + lineNumber() + "," + charPosition() + ")");
			errorBuffer.append("[Could not complete parsing.]");
            return new ast.Error(lineNumber(), charPosition(), "Could not complete parsing.");
		}
	}

	private int lineNumber() {
		return currentToken.lineNumber();
	}

	private int charPosition() {
		return currentToken.charPosition();
	}

	private String reportSyntaxError(NonTerminal nt) {
		String message = "SyntaxError(" + lineNumber() + "," + charPosition() + ")[Expected a token from " + nt.name() + " but got " + currentToken.kind() + ".]";
		errorBuffer.append(message + "\n");
		return message;
	}

	private String reportSyntaxError(Token.Kind kind) {
		String message = "SyntaxError(" + lineNumber() + "," + charPosition() + ")[Expected " + kind + " but got " + currentToken.kind() + ".]";
		errorBuffer.append(message + "\n");
		return message;
	}

	public String errorReport() {
		return errorBuffer.toString();
	}

	public boolean hasError() {
		return errorBuffer.length() > 0;
	}

	public String parseTreeReport() {
		return parseTreeBuffer.toString();
	}

	public void enterRule(NonTerminal nonTerminal) {
		String lineData = new String();
		for (int i = 0; i < parseTreeRecursionDepth; i++) {
			lineData += "  ";
		}
		lineData += nonTerminal.name();
		parseTreeBuffer.append(lineData + "\n");
		parseTreeRecursionDepth++;
	}

	private void exitRule(NonTerminal nonTerminal) {
		parseTreeRecursionDepth--;
	}

	private boolean have(Token.Kind kind) {
		return currentToken.is(kind);
	}

	private boolean have(NonTerminal nt)
	{
		return nt.firstSet().contains(currentToken.kind());
	}

	private boolean accept(Token.Kind kind) {
		if (have(kind)) {
			currentToken = scanner.next();
			return true;
		}
		return false;
	}	 

	private boolean accept(NonTerminal nt) {
		if (have(nt)) {
			currentToken = scanner.next();
			return true;
		}
		return false;
	}

	private boolean expect(Token.Kind kind) {
		if (accept(kind)) {
			return true;
		}
		String errorMessage = reportSyntaxError(kind);
		throw new QuitParseException(errorMessage);
	}

	private boolean expect(NonTerminal nt) {
		if (accept(nt)) {
			return true;
		}
		String errorMessage = reportSyntaxError(nt);
		throw new QuitParseException(errorMessage);
	}

	private Integer expectInteger() {
		String num = currentToken.lexeme();
		expect(Token.Kind.INTEGER);
		return Integer.valueOf(num);
	}

	// SymbolTable Management ==========================
    private void initSymbolTable() {
        Symbol symbol;
        TypeList args;

        symbol= symbolTable.insert("readInt");
        symbol.setType(new FuncType(new TypeList(), new IntType()));

        symbol= symbolTable.insert("readFloat");
        symbol.setType(new FuncType(new TypeList(), new FloatType()));

        symbol= symbolTable.insert("printBool");
        args = new TypeList();
        args.append(new BoolType());
        symbol.setType(new FuncType(args, new VoidType()));

        symbol= symbolTable.insert("printInt");
        args = new TypeList();
        args.append(new IntType());
        symbol.setType(new FuncType(args, new VoidType()));

        symbol= symbolTable.insert("printFloat");
        args = new TypeList();
        args.append(new FloatType());
        symbol.setType(new FuncType(args, new VoidType()));

        symbol= symbolTable.insert("println");
        symbol.setType(new FuncType(new TypeList(), new VoidType()));
    }

    private Symbol tryResolveSymbol(Token ident) {
        assert(ident.is(Token.Kind.IDENTIFIER));
        String name = ident.lexeme();
        try {
            return symbolTable.lookup(name);
        } catch (SymbolNotFoundError snfe) {
            String message = reportResolveSymbolError(name, ident.lineNumber(), ident.charPosition());
            return new ErrorSymbol(message);
        }
    }

    private void enterScope() {
        symbolTable = symbolTable.mutate();
    }

    private void exitScope() {
    	symbolTable = symbolTable.getParent();
    }

    private String reportResolveSymbolError(String name, int lineNum, int charPos) {
        String message = "ResolveSymbolError(" + lineNum + "," + charPos + ")[Could not find " + name + ".]";
        return message;
    }

    private Symbol tryDeclareSymbol(Token ident) {
        assert(ident.is(Token.Kind.IDENTIFIER));
        String name = ident.lexeme();
        try {
            return symbolTable.insert(name);
        } catch (RedeclarationError re) {
            String message = reportDeclareSymbolError(name, ident.lineNumber(), ident.charPosition());
            return new ErrorSymbol(message);
        }
    }

    private String reportDeclareSymbolError(String name, int lineNum, int charPos) {
        String message = "DeclareSymbolError(" + lineNum + "," + charPos + ")[" + name + " already exists.]";
        return message;
    }    

    private Token acceptRetrieve(Token.Kind kind) {
        Token tok = currentToken;
        if (have(kind)) {
			currentToken = scanner.next();
            return tok;
        } else {
        	return null;
        }
    }

    private Token acceptRetrieve(NonTerminal nt) {
        Token tok = currentToken;
        if (have(nt)) {
			currentToken = scanner.next();
            return tok;
        } else {
        	return null;
        }
    }

    private Token expectRetrieve(Token.Kind kind) {
        Token tok = currentToken;
        if (accept(kind)) {
            return tok;
        }
        String errorMessage = reportSyntaxError(kind);
        throw new QuitParseException(errorMessage);
    }

    private Token expectRetrieve(NonTerminal nt) {
        Token tok = currentToken;
        if (accept(nt)) {
            return tok;
        }
        String errorMessage = reportSyntaxError(nt);
        throw new QuitParseException(errorMessage);
    }

	private class QuitParseException extends RuntimeException {
		private static final long serialVersionUID = 1L;
		public QuitParseException(String errorMessage) {
			super(errorMessage);
		}
	}

	//  Grammar rules ==========================
	//literal := INTEGER | FLOAT | TRUE | FALSE .
	public ast.Expression literal() {
		enterRule(NonTerminal.LITERAL);
        Token tok = expectRetrieve(NonTerminal.LITERAL);
		ast.Expression expr = Command.newLiteral(tok);
		exitRule(NonTerminal.LITERAL);
		return expr;
	}

	// designator := IDENTIFIER { "[" expression0 "]" } .
	public ast.Expression designator() {
		enterRule(NonTerminal.DESIGNATOR);
		Token identifier = expectRetrieve(Token.Kind.IDENTIFIER);
		Symbol symbol = tryResolveSymbol(identifier);
		ast.Expression expr = new ast.AddressOf(identifier.lineNumber(), identifier.charPosition(), symbol);
		while (accept(Token.Kind.OPEN_BRACKET)) {
			ast.Expression amount = expression0();
			expr = new ast.Index(amount.lineNumber(), amount.charPosition(), expr, amount);
			expect(Token.Kind.CLOSE_BRACKET);
		}
		exitRule(NonTerminal.DESIGNATOR);
		return expr;
	}

	// type := IDENTIFIER .
	public Type type() {
		enterRule(NonTerminal.TYPE);
		Token typeToken = expectRetrieve(Token.Kind.IDENTIFIER);
		Type type = tryResolveType(typeToken.lexeme());
		exitRule(NonTerminal.TYPE);
		return type;
	}

	//op0 := ">=" | "<=" | "!=" | "==" | ">" | "<" .
	public Token op0() {
		enterRule(NonTerminal.OP0);
		Token token = expectRetrieve(NonTerminal.OP0);
		exitRule(NonTerminal.OP0);
		return token;
	}

	//op1 := "+" | "-" | "or" .
	public Token op1() {
		enterRule(NonTerminal.OP1);
		Token token = expectRetrieve(NonTerminal.OP1);
		exitRule(NonTerminal.OP1);
		return token;
	}

	//op2 := "*" | "/" | "and" .
	public Token op2() {
		enterRule(NonTerminal.OP2);
		Token token = expectRetrieve(NonTerminal.OP2);
		exitRule(NonTerminal.OP2);
		return token;
	}

	//expression0 := expression1 [ op0 expression1 ] .
	public ast.Expression expression0() {
		enterRule(NonTerminal.EXPRESSION0);
		ast.Expression expr = expression1();
		if (have(NonTerminal.OP0)) {
			ast.Expression lhs = expr;
			Token op = op0();
			ast.Expression rhs = expression1();
			expr = Command.newExpression(lhs, op, rhs);
		}
		exitRule(NonTerminal.EXPRESSION0);
		return expr;
	}

	//expression1 := expression2 { op1  expression2 } .
	public ast.Expression expression1() {
		enterRule(NonTerminal.EXPRESSION1);
		ast.Expression expr = expression2();
		while (have(NonTerminal.OP1)) {
			ast.Expression lhs = expr;
			Token op = op1();
			ast.Expression rhs = expression2();
			expr = Command.newExpression(lhs, op, rhs);
		}
		exitRule(NonTerminal.EXPRESSION1);
		return expr;
	}

	//expression2 := expression3 { op2 expression3 } .
	public ast.Expression expression2() {
		enterRule(NonTerminal.EXPRESSION2);
		ast.Expression expr = expression3();
		while (have(NonTerminal.OP2)) {
			ast.Expression lhs = expr;
			Token op = op2();
			ast.Expression rhs = expression3();
			expr = Command.newExpression(lhs, op, rhs);
		}
		exitRule(NonTerminal.EXPRESSION2);
		return expr;
	}

	//expression3 := "not" expression3 | "(" expression0 ")" | designator |
	public ast.Expression expression3() {
		enterRule(NonTerminal.EXPRESSION3);
		ast.Expression expr;
		Token not;
		if ((not = acceptRetrieve(Token.Kind.NOT)) != null) {
			ast.Expression rhs = expression3();
			expr = Command.newExpression(rhs, not, null);
		} else if (accept(Token.Kind.OPEN_PAREN)) {
			expr = expression0();
			expect(Token.Kind.CLOSE_PAREN);
		} else if (have(NonTerminal.DESIGNATOR)) {
			int lineNumber = currentToken.lineNumber();
			int charPos = currentToken.charPosition();
			ast.Expression designator = designator();
			expr = new ast.Dereference(lineNumber, charPos, designator);
		} else if (have(NonTerminal.CALL_EXPRESSION)) {
			expr = call_expression();
		} else if (have(NonTerminal.LITERAL)) {
			expr = literal();
		} else {
			throw new QuitParseException(reportSyntaxError(NonTerminal.EXPRESSION3));
		}
		exitRule(NonTerminal.EXPRESSION3);
		return expr;
	}

	//call-expression := "::" IDENTIFIER "(" expression-list ")" .
	public ast.Call call_expression() {
		enterRule(NonTerminal.CALL_EXPRESSION);
		Token callToken = expectRetrieve(Token.Kind.CALL);
		Token identifier = expectRetrieve(Token.Kind.IDENTIFIER);
		Symbol symbol = tryResolveSymbol(identifier);
		expect(Token.Kind.OPEN_PAREN);
		ast.ExpressionList args = expression_list();
		expect(Token.Kind.CLOSE_PAREN);
		ast.Call call = new ast.Call(callToken.lineNumber(), callToken.charPosition(), symbol, args);
		exitRule(NonTerminal.CALL_EXPRESSION);
		return call;
	}

	//expression-list := [ expression0 { "," expression0 } ] .
	public ast.ExpressionList expression_list() {
		enterRule(NonTerminal.EXPRESSION_LIST);
		ast.ExpressionList exprList = new ast.ExpressionList(currentToken.lineNumber(), currentToken.charPosition());
		if (have(NonTerminal.EXPRESSION0)) {
			do {
				ast.Expression expr = expression0();
				exprList.add(expr);
			} while (accept(Token.Kind.COMMA));
		}
		exitRule(NonTerminal.EXPRESSION_LIST);
		return exprList;
	}

	//parameter := IDENTIFIER ":" type .
	public Symbol paramter() {
		enterRule(NonTerminal.PARAMETER);
		Token identifier = expectRetrieve(Token.Kind.IDENTIFIER);
		Symbol symbol = tryDeclareSymbol(identifier);
		expect(Token.Kind.COLON);
		Type type = type();
		symbol.setType(type);
		exitRule(NonTerminal.PARAMETER);
		return symbol;
	}

	//parameter-list := [ parameter { "," parameter } ] .
	public List<Symbol> parameter_list() {
		enterRule(NonTerminal.PARAMETER_LIST);
		List<Symbol> list = new LinkedList<Symbol>();
		if (have(NonTerminal.PARAMETER)) {
			do {
				Symbol symbol = paramter();
				list.add(symbol);
			} while (accept(Token.Kind.COMMA));
		}
		exitRule(NonTerminal.PARAMETER_LIST);
		return list;
	}

	//variable-declaration := "var" IDENTIFIER ":" type ";" .
	public ast.VariableDeclaration variable_declaration() {
		enterRule(NonTerminal.VARIABLE_DECLARATION);
		Token var = expectRetrieve(Token.Kind.VAR);
		Token identifier = expectRetrieve(Token.Kind.IDENTIFIER);
		Symbol symbol = tryDeclareSymbol(identifier);
		ast.VariableDeclaration varDecl = new ast.VariableDeclaration(var.lineNumber(), var.charPosition(), symbol);
		expect(Token.Kind.COLON);
		Type type = type();
		symbol.setType(type);
		expect(Token.Kind.SEMICOLON);
		exitRule(NonTerminal.VARIABLE_DECLARATION);
		return varDecl;
	}

	//array-declaration := "array" IDENTIFIER ":" type "[" INTEGER "]" { "[" INTEGER "]" } ";" .
	public ast.ArrayDeclaration array_declaration() {
		enterRule(NonTerminal.ARRAY_DECLARATION);
		Token array = expectRetrieve(Token.Kind.ARRAY);
		Token identifier = expectRetrieve(Token.Kind.IDENTIFIER);
		Symbol symbol = tryDeclareSymbol(identifier);
		ast.ArrayDeclaration arrayDecl = new ast.ArrayDeclaration(array.lineNumber(), array.charPosition(), symbol);
		expect(Token.Kind.COLON);
		Type type = type();
		expect(Token.Kind.OPEN_BRACKET);

		Stack<Integer> dimensions = new Stack<Integer>();
		do {	
			Integer dimension = expectInteger();
			dimensions.push(dimension);
			expect(Token.Kind.CLOSE_BRACKET);
		} while (accept(Token.Kind.OPEN_BRACKET));
		expect(Token.Kind.SEMICOLON);
		// Create array in correct order.
		while(!dimensions.empty()) {
			type = new ArrayType(dimensions.pop(), type);
			symbol.setType(type);
		}

		exitRule(NonTerminal.ARRAY_DECLARATION);
		return arrayDecl;
	}

	//function-definition := "func" IDENTIFIER "(" parameter-list ")" ":" type statement-block .
	public ast.FunctionDefinition function_definition() {
		enterRule(NonTerminal.FUNCTION_DEFINITION);
		Token func = expectRetrieve(Token.Kind.FUNC);
		Token identifier = expectRetrieve(Token.Kind.IDENTIFIER);
		Symbol symbol = tryDeclareSymbol(identifier);
		expect(Token.Kind.OPEN_PAREN);
		enterScope();
		List<Symbol> args = parameter_list();
		TypeList argTypes = new TypeList(collectTypes(args));
		expect(Token.Kind.CLOSE_PAREN);
		expect(Token.Kind.COLON);
		Type returnType = type();
		symbol.setType(new FuncType(argTypes, returnType));
		ast.StatementList body = statement_block();
		ast.FunctionDefinition funcDecl = new ast.FunctionDefinition(func.lineNumber(), func.charPosition(), symbol, args, body);
		exitScope();
		exitRule(NonTerminal.FUNCTION_DEFINITION);
		return funcDecl;
	}

	//declaration := variable-declaration | array-declaration | function-definition .
	public ast.Declaration declaration() {
		enterRule(NonTerminal.DECLARATION);
		ast.Declaration declaration;
		if (have(NonTerminal.VARIABLE_DECLARATION)) {
			declaration = variable_declaration();
		} else if (have(NonTerminal.ARRAY_DECLARATION)) {
			declaration = array_declaration();
		} else if (have(NonTerminal.FUNCTION_DEFINITION)) {
			declaration = function_definition();
		} else {
			throw new QuitParseException(reportSyntaxError(NonTerminal.DECLARATION));
		}
		exitRule(NonTerminal.DECLARATION);
		return declaration;
	}

	//declaration-list := { declaration } .
	public ast.DeclarationList declaration_list() {
		ast.DeclarationList declarationList = new ast.DeclarationList(currentToken.lineNumber(), currentToken.charPosition());
		enterRule(NonTerminal.DECLARATION_LIST);
		while (have(NonTerminal.DECLARATION)) {
			ast.Declaration declaration = declaration();
			declarationList.add(declaration);
		}
		exitRule(NonTerminal.DECLARATION_LIST);
		return declarationList;
	}

	//assignment-statement := "let" designator "=" expression0 ";" .
	public ast.Assignment assignment_statement() {
		enterRule(NonTerminal.ASSIGNMENT_STATEMENT);
		Token let = expectRetrieve(Token.Kind.LET);
		ast.Expression destination = designator();
		expect(Token.Kind.ASSIGN);
		ast.Expression source = expression0();
		expect(Token.Kind.SEMICOLON);
		ast.Assignment assignment = new ast.Assignment(let.lineNumber(), let.charPosition(), destination, source);
		exitRule(NonTerminal.ASSIGNMENT_STATEMENT);
		return assignment;
	}

	//call-statement := call-expression ";" .
	public ast.Call call_statement() {
		enterRule(NonTerminal.CALL_STATEMENT);
		ast.Call call = call_expression();
		expect(Token.Kind.SEMICOLON);
		exitRule(NonTerminal.CALL_STATEMENT);
		return call;
	}

	//if-statement := "if" expression0 statement-block [ "else" statement-block ] .
	public ast.IfElseBranch if_statement() {
		enterRule(NonTerminal.IF_STATEMENT);
		Token ifToken = expectRetrieve(Token.Kind.IF);
		ast.Expression condition = expression0();
		enterScope();
		ast.StatementList thenBlock = statement_block();
		exitScope();
		ast.StatementList elseBlock;
		if (accept(Token.Kind.ELSE)) {
			enterScope();
			elseBlock = statement_block();
			exitScope();
		} else {
			elseBlock = new ast.StatementList(currentToken.lineNumber(), currentToken.charPosition());
		}
		exitRule(NonTerminal.IF_STATEMENT);
		ast.IfElseBranch ifElseBranch = new ast.IfElseBranch(ifToken.lineNumber(), ifToken.charPosition(), condition, thenBlock, elseBlock);
		return ifElseBranch;
	}

	//while-statement := "while" expression0 statement-block .
	public ast.WhileLoop while_statement() {
		enterRule(NonTerminal.WHILE_STATEMENT);
		Token whileToken = expectRetrieve(Token.Kind.WHILE);
		ast.Expression condition = expression0();
		enterScope();
		ast.StatementList body = statement_block();
		exitScope();
		ast.WhileLoop whileLoop = new ast.WhileLoop(whileToken.lineNumber(), whileToken.charPosition(), condition, body);
		exitRule(NonTerminal.WHILE_STATEMENT);
		return whileLoop;
	}

	//return-statement := "return" expression0 ";" .
	public ast.Return return_statement() {
		enterRule(NonTerminal.RETURN_STATEMENT);
		Token returnToken = expectRetrieve(Token.Kind.RETURN);
		ast.Expression arg = expression0();
		expect(Token.Kind.SEMICOLON);
		ast.Return returnStmt = new ast.Return(returnToken.lineNumber(), returnToken.charPosition(), arg);
		exitRule(NonTerminal.RETURN_STATEMENT);
		return returnStmt;
	}

	//statement := variable-declaration | call-statement | assignment-statement 
	// | if-statement | while-statement | return-statement .
	public ast.Statement statement() {
		enterRule(NonTerminal.STATEMENT);
		ast.Statement stmt;
		if (have(NonTerminal.VARIABLE_DECLARATION)) {
			stmt = variable_declaration();
		} else if (have(NonTerminal.CALL_STATEMENT)) {
			stmt = call_statement();
		} else if (have(NonTerminal.ASSIGNMENT_STATEMENT)) {
			stmt = assignment_statement();
		} else if (have(NonTerminal.IF_STATEMENT)) {
			stmt = if_statement();
		} else if (have(NonTerminal.WHILE_STATEMENT)) {
			stmt = while_statement();
		} else if (have(NonTerminal.RETURN_STATEMENT)) {
			stmt = return_statement();
		} else {
			throw new QuitParseException(reportSyntaxError(NonTerminal.STATEMENT));
		}
		exitRule(NonTerminal.STATEMENT);
		return stmt;
	}

	//statement-list := { statement } .
	public ast.StatementList statement_list() {
		enterRule(NonTerminal.STATEMENT_LIST);
		ast.StatementList stmtList = new ast.StatementList(currentToken.lineNumber(), currentToken.charPosition());
		while (have(NonTerminal.STATEMENT)) {
			ast.Statement stmt = statement();
			stmtList.add(stmt);
		}
		exitRule(NonTerminal.STATEMENT_LIST);
		return stmtList;
	}

	//statement-block := "{" statement-list "}" .
	public ast.StatementList statement_block() {
		enterRule(NonTerminal.STATEMENT_BLOCK);
		expect(Token.Kind.OPEN_BRACE);
		ast.StatementList stmtList = statement_list();
		expect(Token.Kind.CLOSE_BRACE);
		exitRule(NonTerminal.STATEMENT_BLOCK);
		return stmtList;
	}

	//program := declaration-list EOF .
	public ast.DeclarationList program() {
		enterRule(NonTerminal.PROGRAM);
		ast.DeclarationList declarationList = declaration_list();
		expect(Token.Kind.EOF);
		exitRule(NonTerminal.PROGRAM);
		return declarationList;
	}

	// Typing System ===================================
    private Type tryResolveType(String typeStr) {
        return Type.getBaseType(typeStr);
    }

	private List<Type> collectTypes(List<Symbol> symbols) {
		List<Type> types = new LinkedList<Type>();
		for (Symbol symbol : symbols) {
			types.add(symbol.type());
		}
    	return types;
    }
}
