package mips;

import java.util.Map;
import java.util.HashMap;

import crux.Symbol;
import types.*;

public class ActivationRecord {
    private static final int fixedFrameSize = 2*4;
    private ast.FunctionDefinition func;
    private ActivationRecord parent;
    private int stackSize;
    private Map<Symbol, Integer> locals;
    private Map<Symbol, Integer> arguments;

    public static ActivationRecord newGlobalFrame() {
        return new GlobalFrame();
    }

    protected ActivationRecord() {
        this.func = null;
        this.parent = null;
        this.stackSize = 0;
        this.locals = null;
        this.arguments = null;
    }

    public ActivationRecord(ast.FunctionDefinition fd, ActivationRecord parent) {
        this.func = fd;
        this.parent = parent;
        this.stackSize = 0;
        this.locals = new HashMap<Symbol, Integer>();

        // Map this function's parameters.
        this.arguments = new HashMap<Symbol, Integer>();
		int fpOffset = 0;
		for (int i = (fd.arguments().size() - 1); i >= 0; --i) {
			Symbol symbol = fd.arguments().get(i);
			Type type = symbol.type();
			arguments.put(symbol, fpOffset);
			fpOffset += type.numBytes();
		}
	}

public String name() {
    return func.symbol().name();
}

public ActivationRecord parent() {
    return parent;
}

public int stackSize() {
    return stackSize;
}

public void add(Program prog, ast.VariableDeclaration var) {
    Symbol symbol = var.symbol();
    int varSize = symbol.type().numBytes();
	stackSize += varSize;
	locals.put(symbol, -stackSize);
}

public void add(Program prog, ast.ArrayDeclaration array) {
    throw new RuntimeException("Not possible, array can only be declared in global scope. Parser should have detected this.");
}

public void getAddress(Program prog, String reg, Symbol sym) {
    if (locals.containsKey(sym)) {
    	int offset = locals.get(sym);
        prog.debugComment("Calculating address to var from framepointer to symbol " + sym.name());
        prog.appendInstruction("addi " + reg + ", $fp, " + (offset - fixedFrameSize));
    } else if (arguments.containsKey(sym)) {
        prog.debugComment("Calculating address to funcargumnet from framepointer to symbol " + sym.name());
    	int offset = arguments.get(sym);
        prog.appendInstruction("addi " + reg + ", $fp, " + offset);
    } else if (parent != null) {
        prog.debugComment("Consulting parent scope for address to symbol" + sym.name());
		parent.getAddress(prog, reg, sym);
    } else {
        throw new RuntimeException("This error should not be possible here, can not find symbol you're looking for.");
    }
}
}

class GlobalFrame extends ActivationRecord {

    private String mangleDataname(String name) {
        return "cruxdata." + name;
    }

    @Override
    public void add(Program prog, ast.VariableDeclaration var) {
		Symbol symbol = var.symbol();
		prog.appendData(mangleDataname(symbol.name()) + ": .space " + symbol.type().numBytes());
    }    

    @Override
    public void add(Program prog, ast.ArrayDeclaration array) {
    	Symbol symbol = array.symbol();
        prog.appendData(mangleDataname(symbol.name()) +  ": .space " + symbol.type().numBytes());
    }

    @Override
    public void getAddress(Program prog, String reg, Symbol sym) {
        prog.appendInstruction("la " + reg + ", " + mangleDataname(sym.name()));
    }
}
