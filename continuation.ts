type ContFunc<R, A> = (k: (a: A) => R) => R;

class Cont<R, A> {
  constructor(public readonly runCont: ContFunc<R, A>) {}

  bind<B>(f: (a: A) => Cont<R, B>): Cont<R, B> {
    return new Cont((k) => this.runCont((a) => f(a).runCont(k)));
  }

  flatMap<B>(f: (a: A) => Cont<R, B>): Cont<R, B> {
    return new Cont((k) => this.runCont((a) => f(a).runCont(k)));
  }

  static of<R, A>(a: A): Cont<R, A> {
    return new Cont((k) => k(a));
  }

  map<B>(f: (a: A) => B): Cont<R, B> {
    return this.bind((a) => Cont.of<R, B>(f(a)));
  }

  ap<B>(fab: Cont<R, (a: A) => B>): Cont<R, B> {
    return fab.bind((f) => this.map(f));
  }
}

const example = Cont.of<string, string>("Hello").bind((x) =>
  Cont.of<string, string>("World").map((y) => `${x} ${y}`)
);

const result = example.runCont((s) => s);
console.log("Result:", result);

function callCC<R, A, B>(
  f: (exit: (a: A) => Cont<R, B>) => Cont<R, A>
): Cont<R, A> {
  return new Cont<R, A>((k: (a: A) => R) =>
    f((a: A) => new Cont<R, B>((_ignore: (b: B) => R) => k(a))).runCont(k)
  );
}

const computation = Cont.of<number, number>(10)
  .flatMap((x) => Cont.of<number, number>(x * 2))
  .flatMap((x) => Cont.of<number, number>(x + 5));

const computationWithExit = callCC<number, number, number>((exit) =>
  Cont.of<number, number>(10).flatMap((x) =>
    x > 5 ? exit(999) : Cont.of<number, number>(x * 2)
  )
).flatMap((x) => Cont.of<number, number>(x + 1));

const result3 = computationWithExit.runCont((x) => x);
console.log(result3);
