type Writer<A> = [A, string];

function compose<A, B, C>(m1: (a: A) => Writer<B>, m2: (b: B) => Writer<C>): (c: A) => Writer<C> {
  return function (x: A) {
    const [y, s1] = m1(x);
    const [z, s2] = m2(y);
    return [z, s1 + s2];
  }
}

const ret = <A>(x: A): Writer<A> => [x, ''];

const upCase = (s: string): Writer<string> => [s.toUpperCase(), 'upCase '];
const toWords = (s:string): Writer<string[]> => [s.split(''), 'toWords '];

const process = (s:string): Writer<string[]> => compose(upCase, toWords)(s);