type Reader<E, A> = (e: E) => A;

function runReader<E, A>(f: Reader<E, A>, e: E): A {
  return f(e);
}

const runReaderDup: <E, A>(f: Reader<E, A>, e: E)=> A  = (f, e) => f(e);

// pure / return — создает Reader, игнорирующий окружение
export const of = <E, A>(value: A): Reader<E, A> => (_env: E) => value;

// fmap
export const map = <E, A, B>(f: (a: A) => B) =>
  (ra: Reader<E, A>): Reader<E, B> =>
    (env: E) => f(ra(env));

// ap — для Applicative
export const ap = <E, A, B>(rf: Reader<E, (a: A) => B>) =>
  (ra: Reader<E, A>): Reader<E, B> =>
    (env: E) => rf(env)(ra(env));

// flatMap / bind / >>=
export const flatMap = <E, A, B>(f: (a: A) => Reader<E, B>) =>
  (ra: Reader<E, A>): Reader<E, B> =>
    (env: E) => f(ra(env))(env);

// ask — возвращает окружение как есть
export const ask = <E>(): Reader<E, E> =>
  (env: E) => env;

// -------------------- Пример --------------------

const example: Reader<string, string> =
  flatMap<string, string, string>((env) => of(`Hello, ${env}!`))(ask());

// Проверка
console.log(runReader(example, "Leonty")); // → Hello, Leonty!
