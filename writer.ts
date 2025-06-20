type Writer<A> = [A, string];

function composeWriter<A, B, C>(m1: (a: A) => Writer<B>, m2: (b: B) => Writer<C>): (c: A) => Writer<C> {
  return function (x: A) {
    const [y, s1] = m1(x);
    const [z, s2] = m2(y);
    return [z, s1 + s2];
  }
}

const ret = <A>(x: A): Writer<A> => [x, ''];

const upCase = (s: string): Writer<string> => [s.toUpperCase(), 'upCase '];
const toWords = (s:string): Writer<string[]> => [s.split(''), 'toWords '];

const process = (s:string): Writer<string[]> => composeWriter(upCase, toWords)(s);

function bind<A, B>(
  ma: Writer<A>,
  f: (a: A) => Writer<B>
): Writer<B> {
  const [a, log1] = ma;
  const [b, log2] = f(a);
  return [b, log1 + log2];
}

function fmap<A, B>(f: (a: A) => B): (ma: Writer<A>) => Writer<B> {
  return (ma: Writer<A>) =>
    bind(ma, (x) => ret(f(x)));
}

function fmapViaCompose<A, B>(f: (a: A) => B): (ma: Writer<A>) => Writer<B> {
  const id = (x: Writer<A>) => x;
  const lifted = (a: A) => ret(f(a));
  return (ma: Writer<A>) => composeWriter(id, lifted)(ma);
}
