class Optional<A> {
  private _isValid: boolean;
  private _value: A | undefined;

  constructor(value?: A) {
    this._isValid = typeof value !== 'undefined';
    this._value = value;
  }
  
  isValid(): boolean {
    return this._isValid;
  }
  
  value(): A {
    if (this._isValid) {
      return this._value as A;
    }
    throw new Error(`the Optional is none`);
  }
}

function composeOptional<A, B, C>(m1: (a: A) => Optional<B>, m2: (b: B) => Optional<C>): (c: A) => Optional<C> {
  return function (x: A) {
    const y = m1(x);
    if (!y.isValid()) {
      return new Optional<C>();
    }
    return m2(y.value());
  }
}

function safe_root(x: number): Optional<number> {
  if (x > 0) {
    return new Optional(Math.sqrt(x));
  } else {
    return new Optional();
  }
}

function safe_reciprocal(x: number): Optional<number> {
  if (x != 0.0) {
    return new Optional(1/x);
  } else {
    return new Optional();
  }
}

function safe_root_reciprocal(x: number): Optional<number> {
  return composeOptional(safe_reciprocal, safe_root)(x);
}

console.log(safe_root_reciprocal(2).value());