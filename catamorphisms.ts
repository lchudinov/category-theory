export type Fix<F> = { unfix: F };

export const Fix = <F>(unfix: F): Fix<F> => ({ unfix });

export const cata =
  <F, A>(alg: (fa: F) => A, fmap: (fn: (x: any) => A) => (fa: F) => F) =>
  (term: Fix<F>): A =>
    alg(fmap((x) => cata(alg, fmap)(x))(term.unfix));

type NatF<A> = { tag: "ZeroF" } | { tag: "SuccF"; value: A };

const fmapNatF =
  <A, B>(fn: (x: A) => B) =>
  (fa: NatF<A>): NatF<B> =>
    fa.tag === "ZeroF"
      ? { tag: "ZeroF" }
      : { tag: "SuccF", value: fn(fa.value) };
      
const zero = Fix<NatF<any>>({ tag: "ZeroF" });

const succ = (n: Fix<NatF<any>>): Fix<NatF<any>> =>
  Fix({ tag: "SuccF", value: n });

const fromNumber = (n: number): Fix<NatF<any>> =>
  n === 0 ? zero : succ(fromNumber(n - 1));

const fibAlg = (fa: NatF<[number, number]>): [number, number] =>
  fa.tag === "ZeroF"
    ? [1, 1]
    : [fa.value[1], fa.value[0] + fa.value[1]];

const fib = cata<NatF<[number, number]>, [number, number]>(
  fibAlg,
  fmapNatF
);

console.log(fib(fromNumber(0))); // [1,1]
console.log(fib(fromNumber(1))); // [1,1]
console.log(fib(fromNumber(2))); // [1,2]
console.log(fib(fromNumber(3))); // [2,3]
console.log(fib(fromNumber(4))); // [3,5]
console.log(fib(fromNumber(5))); // [5,8]
