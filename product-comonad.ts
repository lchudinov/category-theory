class Product<E, A> {
  constructor(
    public readonly e: E,
    public readonly a: A,
  ) { }

  map<B>(f: (a: A) => B): Product<E, B> {
    return new Product(this.e, f(this.a));
  }
  
  extract(): A {
    return this.a;
  }
  
  duplicate(): Product<E, Product<E, A>> {
    return new Product(this.e, this);
  }
  
  extend<B>(f: (w: Product<E, A>) => B): Product<E, B> {
    return new Product(this.e, f(this));
  }
}

function composeW<E, A, B, C>(
  f: (wa: Product<E, A>) => B,
  g: (wb: Product<E, B>) => C,
) {
  return (wa: Product<E, A>) => g(wa.extend(f));
}

const p = new Product(10, 'hi');
const f = (w: Product<number, string>): number => w.a.length + w.e;
const g = (w: Product<number, number>): string => `sum=${w.a + w.e}`;
const h = composeW(f, g);
console.log(h(p));
