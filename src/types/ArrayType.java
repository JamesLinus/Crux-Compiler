package types;

import crux.Symbol;

public class ArrayType extends Type {

    private Type base;
    private int extent;

    public ArrayType(int extent, Type base) {
        this.extent = extent;
        this.base = base;
    }

    public int extent() {
        return extent;
    }

    public Type base() {
        return base;
    }

    @Override
    public String toString() {
        return "array[" + extent + "," + base + "]";
    }

    @Override
    public boolean equivalent(Type that) {
        if (that == null) {
            return false;
        } else if (!(that instanceof ArrayType)) {
            return false;
        } else {
        	ArrayType aType = (ArrayType) that;
        	return this.extent == aType.extent && base.equivalent(aType.base);
        }
    }

    @Override
    public Type index(Type amountType) {
        if (!amountType.equivalent(new IntType())) {
			return super.index(amountType);
        } else {
        	return base;
        }
    }

	@Override
	public Type assign(Type source) {
		return base.assign(source);
	}

	@Override
	public Type baseType(Symbol symbol) {
		return base.baseType(symbol);
	}

	@Override
	public int numBytes() {
		return extent * base.numBytes(); 
	}
}
