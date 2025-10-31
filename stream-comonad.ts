export class Stream<A> {
  constructor(
    public readonly head: A,
    public readonly tail: () => Stream<A>,
  ) { }

  map<B>(f: (a: A) => B): Stream<B> {
    return new Stream(f(this.head), () => this.tail().map(f));
  }

  extract(): A {
    return this.head;
  }

  duplicate(): Stream<Stream<A>> {
    return new Stream(this, () => this.tail().duplicate());
  }

  extend<B>(f: (wa: Stream<A>) => B): Stream<B> {
    return this.duplicate().map(f);
  }

  take(n: number): A[] {
    const result: A[] = [];
    let current: Stream<A> = this;
    for (let i = 0; i < n; i++) {
      result.push(current.head);
      current = current.tail();
    }
    return result;
  }
}

export const from = (n: number): Stream<number> =>
  new Stream(n, () => from(n + 1));

export const sumS = (n: number, s: Stream<number>): number => {
  let sum = 0;
  let current = s;
  for (let i = 0; i < n; i++) {
    sum += current.head;
    current = current.tail();
  }
  return sum;
};

export const average = (n: number, s: Stream<number>): number => {
  return sumS(n, s) / n;
};

export const movingAvg = (n: number, s: Stream<number>): Stream<number> =>
  s.extend((w) => average(n, w));

const s = from(1);
const avg = movingAvg(3, s);
console.log(avg.take(10));
