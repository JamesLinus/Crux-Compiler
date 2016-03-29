package crux;

import java.util.Map;
import java.util.LinkedHashMap;

public class SymbolTable extends AbstractSymbolTable {
    public static final String[] PREDEF_FUNCS = { 
        "readInt",
        "readFloat",
        "printBool",
        "printInt",
        "printFloat",
        "println"
    };

    private AbstractSymbolTable parent;
    private Map<String, Symbol> table;

    public SymbolTable() {
        this(AbstractSymbolTable.NULL);
    }

    public SymbolTable(AbstractSymbolTable parent) {
		super(parent.depth + 1);
        this.parent = parent;
        table = new LinkedHashMap<String, Symbol>();
    }

    public Symbol lookup(String name) throws SymbolNotFoundError {
		Symbol target = get(name);
		if (target != null) {
			return target;
		} else {
			throw new SymbolNotFoundError(name);
		}
    }

    private Symbol get(String name) {
        Symbol target = table.get(name);
        if (target == null) {
        	target = parent.lookup(name);
        } 
		return target;
    }

    public Symbol insert(String name) throws RedeclarationError {
        Symbol symbol = table.get(name);
        if (symbol != null ) {
        	throw new RedeclarationError(symbol);
        } 
		symbol = new Symbol(name);
		table.put(name, symbol);
		return symbol;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(parent.toString());

        String indent = new String();
        for (int i = 0; i < depth; i++) {
        	indent += "  ";
        }

        for (Symbol s : table.values()) {
            sb.append(indent + s.toString() + "\n");
        }
        return sb.toString();
    }

    public SymbolTable mutate() {
    	return new SymbolTable(this);
    }

    public SymbolTable getParent() {
		return parent.parents(this);
    }

    protected SymbolTable parents(AbstractSymbolTable child) {
    	return this; 
    }

}

class SymbolNotFoundError extends Error {
    private static final long serialVersionUID = 1L;
    private String name;
    SymbolNotFoundError(String name) {
        this.name = name;
    }
    public String name() {
        return name;
    }
}

class RedeclarationError extends Error {
    private static final long serialVersionUID = 1L;
    public RedeclarationError(Symbol sym) {
        super("Symbol " + sym + " being redeclared.");
    }
}
