package types;

import crux.Symbol;

public abstract class Type {

    public static Type getBaseType(String typeStr) {
        if (typeStr.equals("int")) {
			return new IntType();
        } else if (typeStr.equals("float")) {
			return new FloatType();
        } else if (typeStr.equals("bool")) {
			return new BoolType();
        } else if (typeStr.equals("void")) {
			return new VoidType();
        } else {
        	return new ErrorType("Unknown type: " + typeStr);
        }
    }

    public Type add(Type that) {
        return new ErrorType("Cannot add " + this + " with " + that + ".");
    }

    public Type sub(Type that) {
        return new ErrorType("Cannot subtract " + that + " from " + this + ".");
    }

    public Type mul(Type that) {
        return new ErrorType("Cannot multiply " + this + " with " + that + ".");
    }

    public Type div(Type that) {
        return new ErrorType("Cannot divide " + this + " by " + that + ".");
    }

    public Type and(Type that) {
        return new ErrorType("Cannot compute " + this + " and " + that + ".");
    }

    public Type or(Type that) {
        return new ErrorType("Cannot compute " + this + " or " + that + ".");
    }

    public Type not() {
        return new ErrorType("Cannot negate " + this + ".");
    }

    public Type compare(Type that) {
        return new ErrorType("Cannot compare " + this + " with " + that + ".");
    }

    public Type deref() {
        return new ErrorType("Cannot dereference " + this);
    }

    public Type index(Type that) {
        return new ErrorType("Cannot index " + this + " with " + that + ".");
    }

    public Type call(Type args) {
        return new ErrorType("Cannot call " + this + " using " + args + ".");
    }

    public Type assign(Type source) {
        return new ErrorType("Cannot assign " + source + " to " + this + ".");
    }

    public abstract boolean equivalent(Type that);

    public Type declare(Symbol symbol) {
       	return new ErrorType("Variable " + symbol.name() + " has invalid type " + this + ".");
    }

	public Type baseType(Symbol symbol) {
		return new ErrorType("Array " + symbol.name() + " has invalid base type " + this + ".");
	}

	public int numBytes() {
        throw new RuntimeException("No size known for " + this);
	}
}
