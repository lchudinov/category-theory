type Store<S, A> = {
  peek: (s: S) => A; 
  pos: S;           
};

function extract<S, A>(store: Store<S, A>): A {
  console.log(`about to extract from`, store);
  return store.peek(store.pos);
}

function duplicate<S, A>(store: Store<S, A>): Store<S, Store<S, A>> {
  return {
    peek: (s) => ({ peek: store.peek, pos: s }),
    pos: store.pos,
  };
}

function extend<S, A, B>(store: Store<S, A>, f: (st: Store<S, A>) => B): Store<S, B> {
  const duplicated = duplicate(store);
  const result = {
    peek: (s: S) => f(duplicated.peek(s)),
    pos: store.pos,
  };
  console.log(`extended:`, result);
  return result;
}

type State = number;
type Cell = 0 | 1;

const world: Record<number, Cell> = {
  [-1]: 0,
  [0]: 1,
  [1]: 1,
  [2]: 0,
};

const store: Store<State, Cell> = {
  peek: (s) => world[s] ?? 0,
  pos: 0,
};

function rule(s: Store<State, Cell>): Cell {
  const left = s.peek(s.pos - 1);
  const center = s.peek(s.pos);
  const right = s.peek(s.pos + 1);
  const sum = left + right - center;
  return sum === 1 ? 1 : 0;
}

const nextGen = extend(store, rule);

console.log("Текущее значение:", extract(store));      // 1
console.log("Новое значение:", extract(nextGen));      // 0
