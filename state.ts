type State<S, A> = (s: S) => [A, S];

const runState = <S, A>(state: State<S, A>, s: S): [A, S] => state(s);

const pureState = <S, A>(a: A): State<S, A> => (s: S) => [a, s];

const bindState = <S, A, B>(
  sa: State<S, A>,
  k: (a: A) => State<S, B>
): State<S, B> => (s: S) => {
  const [a, s1] = sa(s);
  return k(a)(s1);
}

const getState = <S>(): State<S, S> => (s: S) => [s, s];

const putState = <S>(s2: S): State<S, void> => (_: S) => [undefined, s2];

const increment: State<number, number> = bindState(getState<number>(), (x) =>
  bindState(putState<number>(x + 1), () => getState<number>())
);

const decrement: State<number, number> = bindState(getState<number>(), (x) =>
  bindState(putState<number>(x - 1), () => getState<number>())
);

const noop: State<number, number> = bindState(increment, (x) =>
  bindState(decrement, () => getState<number>())
);

const incTwice: State<number, number> = bindState(increment, (x) =>
  bindState(increment, () => getState<number>())
);

const [curResult, finalState] = runState(incTwice, 5);

console.log("curResult:", curResult);
console.log("Final state:", finalState);
