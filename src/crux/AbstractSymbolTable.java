package crux;

@SuppressWarnings("unchecked") 
public abstract class AbstractSymbolTable {

	public static final AbstractSymbolTable NULL = new AbstractSymbolTable(-1) {

		public Symbol lookup(String name) {
			return null;
		}

		public String toString() {
			return "";
		}

    	protected AbstractSymbolTable whoIsMyFather(AbstractSymbolTable child) {
    		return child;
    	}
	};

    /* The depth of this scope. */
	protected int depth;
	protected AbstractSymbolTable(int depth) {
		this.depth = depth;
	}

    abstract public Symbol lookup(String name) throws SymbolNotFoundError;

    public abstract String toString();

    protected abstract <T extends AbstractSymbolTable> T whoIsMyFather(AbstractSymbolTable child);
}
