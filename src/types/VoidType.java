package types;

public class VoidType extends Type {

    public VoidType() {
    }

    @Override
    public String toString() {
        return "void";
    }

    @Override
    public boolean equivalent(Type that) {
        if (that == null) {
            return false;
        } else if (!(that instanceof VoidType)) {
            return false;
        } else {
            return true;
        }
    }

	@Override
    public Type deref() {
        return this;
    }

    @Override
	public int numBytes() {
        return 0;
	}
}
