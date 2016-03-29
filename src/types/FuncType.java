package types;

public class FuncType extends Type {
   	private TypeList args;
   	private Type ret;

   	public FuncType(TypeList args, Type returnType) {
      	this.args = args;
      	this.ret = returnType;
   	}

   	public Type returnType() {
      	return ret;
   	}

   	public TypeList arguments() {
      	return args;
   	}

   	@Override
   	public String toString() {
      	return "func(" + args + "):" + ret;
   	}

   	@Override
   	public boolean equivalent(Type that) {
      	if (that == null) {
         	return false;
      	} else if (!(that instanceof FuncType)) {
         	return false;
      	} else {
      	  	FuncType aType = (FuncType) that;
      	  	return this.ret.equivalent(aType.ret) && this.args.equivalent(aType.args);
      	}
   	}

   	@Override
   	public Type call(Type args) {
        if (!(args instanceof TypeList)) {
            return super.call(args);
        } else if (!((TypeList) args).equivalent(this.args)) {
        	return new ErrorType("Cannot call " + this + " using " + args + ".");
        } else {
			return ret;
        }
   	}

    @Override
	public int numBytes() {
        return ret.numBytes();
	}
}
