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

const w = 10;
const h = 10;

const game: number[][] = Array.from({ length: h }, () =>
  Array.from({ length: w }, () => Math.random() < 0.5 ? 1 : 0)
);

type Pair = [number, number];

function getCell([x, y]: Pair): number {
  const maybeValue : number | undefined = game[x]?.[y];
  return maybeValue ?? 0;
}

const life = new Store<Pair, number>(getCell, [3, 3]);

const lifeRules = (st: Store<Pair, number>) => {
  const [x, y ] = st.pos;
  const deltas = [
    { dx: -1, dy: 0 },
    { dx: 1, dy: 0 },
    { dx: 0, dy: -1 },
    { dx: 0, dy: 1 },
    { dx: -1, dy: -1 },
    { dx: 1, dy: 1 },
    { dx: -1, dy: 1 },
    { dx: 1, dy: -1 },
  ];
  const neighborsAlive = deltas.reduce(
    (sum, { dx, dy }) => sum + st.peek([x + dx, y + dy]), 0
  );
  const currentAlive = st.peek(st.pos);
  if (currentAlive) {
    return (neighborsAlive != 2 && neighborsAlive != 3) ? 1 : 0;
  } else {
    return neighborsAlive === 3 ? 1 : 0;
  }
};

function arrayFromStore(store: Store<Pair, number>, grid: number[][]): number[][] {
  const out: number[][] = [];
  for (let y = 0; y < h; y++) {
    out[y] = [];
    for (let x = 0; x < w; x++) {
      out[y][x] = store.peek([ x, y ]);
    }
  }
  return out;
}

function printGrid(arr: number[][]): void {
  console.log('\n' + arr.map(row => row.map(c => (c === 1 ? "█" : " ")).join('')).join('\n') + '\n');
}

function runSteps(n: number): void {
  let currentLife = life;
  let currentGame = game;
  printGrid(currentGame);
  for (let i = 0; i < n; i++) {
    currentLife = currentLife.extend(lifeRules);
    currentGame = arrayFromStore(currentLife, currentGame);
    printGrid(currentGame);
  }
}

runSteps(10);

