package types;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import crux.Symbol;
import ast.*;

public class TypeChecker implements CommandVisitor {
    private Map<Command, Type> typeMap;
    private StringBuilder errorBuffer;
    private boolean needsReturn;
    private int nbrFoundReturns;
	private Symbol curFuncSym;
	private Type curFuncRetType;

	public TypeChecker() {
        typeMap = new HashMap<Command, Type>();
        errorBuffer = new StringBuilder();
    }

    private void reportError(int lineNum, int charPos, String message) {
        errorBuffer.append("TypeError(" + lineNum + "," + charPos + ")");
        errorBuffer.append("[" + message + "]" + "\n");
    }

	private void put(Command node, Type type) {
        if (type instanceof ErrorType) {
            reportError(node.lineNumber(), node.charPosition(), ((ErrorType)type).getMessage());
        }
        typeMap.put(node, type);
    }

    public Type getType(Command node) {
        return typeMap.get(node);
    }

    public boolean check(Command ast) {
        ast.accept(this);
        return !hasError();
    }

    public boolean hasError() {
        return errorBuffer.length() != 0;
    }

    public String errorReport() {
        return errorBuffer.toString();
    }

    private Type visitRetriveType(Visitable node) {
		node.accept(this);
		return getType((Command) node);
    }

	// Visitor methods ===================================
    @Override
    public void visit(ExpressionList node) {
		TypeList typeList = new TypeList();
        for(Expression expr : node) {
			typeList.append(visitRetriveType(expr));
        }
        put(node, typeList);
    }

    @Override
    public void visit(DeclarationList node) {
        for (Declaration decl : node) {
        	decl.accept(this);
        }
    }

    @Override
    public void visit(StatementList node) {
        needsReturn = true;
        boolean foundReturn = false;
        for (Statement stmt : node) {
        	stmt.accept(this);
        	if (!needsReturn) {
        		foundReturn = true;
        	}
        }
        needsReturn = !foundReturn;
    }

    @Override
    public void visit(AddressOf node) {
        Type type = node.symbol().type();
		put(node, new AddressType(type));
    }

    @Override
    public void visit(LiteralBool node) {
        put(node, new BoolType());
    }

    @Override
    public void visit(LiteralFloat node) {
        put(node, new FloatType());
    }

    @Override
    public void visit(LiteralInt node) {
        put(node, new IntType());
    }

    @Override
    public void visit(VariableDeclaration node) {
    	Symbol symbol = node.symbol();
    	Type varType = symbol.type();
        put(node, varType.declare(symbol));
    }

    @Override
    public void visit(ArrayDeclaration node) {
		Symbol symbol = node.symbol();
		Type type = symbol.type();
		put(node, type.baseType(symbol));
    }

    @Override
    public void visit(FunctionDefinition node) {
        Symbol func = node.function();
        List<Symbol> args = node.arguments();
        Type returnType = ((FuncType) func.type()).returnType();

        if (func.name().equals("main")) {
        	if (args.size() != 	0 || !(returnType instanceof VoidType)) {
				put(node, new ErrorType("Function main has invalid signature."));
				return;
			}
        } else {
        	int pos = 0;
        	for (Symbol arg : args) {
				Type argType = arg.type();
				if (argType instanceof ErrorType) {
					put(node, new ErrorType("Function " + func.name() + " has an error in argument in position " + pos + ": " + ((ErrorType) argType).getMessage()));
					return;
				} else if (argType instanceof VoidType) {
 	 	 	 		put(node, new ErrorType("Function " + func.name() + " has a void argument in position " + pos + "."));
					return;
				}
				++pos;
        	}
        }

		curFuncSym = func;
		curFuncRetType = returnType;
		nbrFoundReturns = 0;
        visit(node.body());
		if (!(returnType instanceof VoidType) && needsReturn) { 
        	put(node, new ErrorType("Not all paths in function " + func.name() + " have a return."));
		} else {
			put(node, returnType);
		}
    }

    @Override
    public void visit(Comparison node) {
    	Type lhs = visitRetriveType(node.leftSide());
    	Type rhs = visitRetriveType(node.rightSide());
        put(node, lhs.compare(rhs));
    }

    @Override
    public void visit(Addition node) {
        Type lhs = visitRetriveType(node.leftSide());
        Type rhs = visitRetriveType(node.rightSide());
        if (lhs != null && rhs != null) {
        	Type res = lhs.add(rhs);
			put(node, res);
        }
    }

    @Override
    public void visit(Subtraction node) {
        Type lhs = visitRetriveType(node.leftSide());
        Type rhs = visitRetriveType(node.rightSide());
		put(node, lhs.sub(rhs));
    }

    @Override
    public void visit(Multiplication node) {
        Type lhs = visitRetriveType(node.leftSide());
        Type rhs = visitRetriveType(node.rightSide());
		put(node, lhs.mul(rhs));
    }

    @Override
    public void visit(Division node) {
        Type lhs = visitRetriveType(node.leftSide());
        Type rhs = visitRetriveType(node.rightSide());
		put(node, lhs.div(rhs));
    }

    @Override
    public void visit(LogicalAnd node) {
        Type lhs = visitRetriveType(node.leftSide());
        Type rhs = visitRetriveType(node.rightSide());
		put(node, lhs.and(rhs));
    }

    @Override
    public void visit(LogicalOr node) {
        Type lhs = visitRetriveType(node.leftSide());
        Type rhs = visitRetriveType(node.rightSide());
		put(node, lhs.or(rhs));
    }

    @Override
    public void visit(LogicalNot node) {
		Type type = visitRetriveType(node.expression());
		if (type.equivalent(new BoolType())) {
			put(node, type);
		} else {
			put(node, new ErrorType("Cannot negate " + type + "."));
		}
    }

    @Override
    public void visit(Dereference node) {
        put(node, visitRetriveType(node.expression()).deref());
    }

    @Override
    public void visit(Index node) {
        Type amountType = visitRetriveType(node.amount());
        Type baseType = visitRetriveType(node.base());
		Type resType = baseType.index(amountType);
		put(node, resType);
    }

    @Override
    public void visit(Assignment node) {
        Type srcType = visitRetriveType(node.source());
		Type destType = visitRetriveType(node.destination());
        put(node, destType.assign(srcType));
    }

    @Override
    public void visit(Call node) {
    	Type funcType = node.function().type();
		Type callArgTypes = visitRetriveType(node.arguments());
		put(node, funcType.call(callArgTypes));
    }

    @Override
    public void visit(IfElseBranch node) {
        Type condType = visitRetriveType(node.condition());
        if (!condType.equivalent(new BoolType())) {
     	 	put(node, new ErrorType("IfElseBranch requires bool condition not " + condType + "."));
     	 	return;
        }

		needsReturn = true;
		visit(node.thenBlock());
		boolean thenNeedsReturn = needsReturn ;
		needsReturn = true;
		visit(node.elseBlock());
		boolean elseNeedsReturn = needsReturn ;

		needsReturn = (thenNeedsReturn ^ elseNeedsReturn) || (thenNeedsReturn && elseNeedsReturn);
    }

    @Override
    public void visit(WhileLoop node) {
        Type condType = visitRetriveType(node.condition());
        if (!condType.equivalent(new BoolType())) {
     	 	put(node, new ErrorType("WhileLoop requires bool condition not " + condType + "."));
     	 	return;
        }

		int prevNbrRets = nbrFoundReturns;
		needsReturn = true;
		visit(node.body());
		needsReturn = needsReturn || (nbrFoundReturns > prevNbrRets);
    }

    @Override
    public void visit(Return node) {
    	Type retType = visitRetriveType(node.argument());
		++nbrFoundReturns;
		if (!retType.equivalent(curFuncRetType)) {
			put(node, new ErrorType("Function " + curFuncSym.name() + " returns " + curFuncRetType + " not " + retType + "."));
		} else {
			put(node, retType);
		}
        needsReturn = false;
    }

    @Override
    public void visit(ast.Error node) {
        put(node, new ErrorType(node.message()));
    }

	@Override
	public void visit(ReadSymbol readSymbol) {
		// TODO Auto-generated method stub
		
	}
}
