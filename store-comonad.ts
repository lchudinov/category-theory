class Store<S, A> {
  constructor(
    public readonly peek: (s: S) => A,
    public readonly pos: S
  ) {}

  extract(): A {
    return this.peek(this.pos);
  }

  map<B>(f: (a: A) => B): Store<S, B> {
    return new Store((s) => f(this.peek(s)), this.pos);
  }

  extend<B>(f: (store: Store<S, A>) => B): Store<S, B> {
    return new Store((s) => f(new Store(this.peek, s)), this.pos);
  }
}


const tape = (x: number) => x * x;
const store = new Store<number, number>(tape, 2);

console.log(store.extract());

const sumOfNeighbors = (st: Store<number, number>) =>
  st.peek(st.pos - 1) + st.peek(st.pos) + st.peek(st.pos + 1);

const bracket = (st: Store<number, number>) =>
  '[' + st.peek(st.pos) + ']';

const extended = store.extend(sumOfNeighbors);
const extended2 = extended.extend(bracket);

console.log(extended2.extract());

type Point = { x: number; y: number };
const map = ({ x, y }: Point) => x + y;

const world = new Store(map, { x: 1, y: 2 });
console.log(world.extract()); // 3

const neighborhoodSum = (st: Store<Point, number>) => {
  const { x, y } = st.pos;
  const deltas = [
    { dx: -1, dy: 0 },
    { dx: 1, dy: 0 },
    { dx: 0, dy: -1 },
    { dx: 0, dy: 1 },
  ];
  return deltas.reduce(
    (sum, { dx, dy }) => sum + st.peek({ x: x + dx, y: y + dy }),
    st.peek(st.pos)
  );
};

const extendedWorld = world.extend(neighborhoodSum);
console.log(extendedWorld.extract()); // 15 — (3 + 2 + 4 + 1 + 5)

