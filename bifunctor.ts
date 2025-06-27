type Pair<A, B> = [a: A, b: B];

function bimap<A, B, C, D>(f: (a: A) => C, g: (b: B) => D, p: Pair<A, B>): Pair<C, D> {
  const [a, b] = p;
  return [f(a), g(b)];
}

const p: Pair<number, string> = [2, 'hello'];

const result = bimap(n => n * 2, s => s.toUpperCase(), p);
console.log(result);