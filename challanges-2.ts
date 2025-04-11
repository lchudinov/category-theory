// 1. Define a higher-order function (or a function object) memoize in
// your favorite language. This function takes a pure function f as
// an argument and returns a function that behaves almost exactly
// like f, except that it only calls the original function once for every
// argument, stores the result internally, and subsequently returns
// this stored result every time it’s called with the same argument.
// You can tell the memoized function from the original by watching
// its performance. For instance, try to memoize a function that
// takes a long time to evaluate. You’ll have to wait for the result
// the first time you call it, but on subsequent calls, with the same
// argument, you should get the result immediately.

function memoize<T extends (...args: any[]) => any>(fn: T): T {
  const cache = new Map<string, ReturnType<T>>();
  const memoized = (...args: Parameters<T>): ReturnType<T> => {
    const key = JSON.stringify(args);
    if (cache.has(key)) {
      return cache.get(key)!;
    }
    const result = fn(...args);
    cache.set(key, result);
    return result;
  };
  return memoized as T;
}

// 2. Try to memoize a function from your standard library that you
// normally use to produce random numbers. Does it work?

const random1 = memoize(Math.random);

console.log(random1(), random1());

// 3. Most random number generators can be initialized with a seed.
// Implement a function that takes a seed, calls the random number
// generator with that seed, and returns the result. Memoize that
// function. Does it work?

// In TypeScript, it's impossible to seed a random number generator.

// 4. Which of these C++ functions are pure? Try to memoize them
// and observe what happens when you call them multiple times:
// memoized and not.
// (a) The factorial function from the example in the text.
// (b) std::getchar()
// (c) bool f() {
// std::cout << "Hello!" << std::endl;
// return true;
// }
// (d) int f(int x) {
// static int y = 0;
// 25
// y += x;
// return y;
// }

function fact(n: number): number {
  let result = 1;
  for (let i = 2; i <= n; ++i) {
    result *= i;
  }
  return result;
}

const memfact = memoize(fact);

console.log(memfact(5), memfact(5));

const memprompt = memoize(prompt);
console.log(memprompt(`What's your age`), memprompt(`What's your age`));

let y = 0;
function f(x: number) {
  y += x;
  return y;
}

const memf = memoize(f);
console.log(memf(5), memf(5));

// 5. How many different functions are there from Bool to Bool? Can
// you implement them all?

const idBool = (x: boolean) => x;
const notBool = (x:boolean) => !x;
const alwaysTrue = (x: boolean) => true;
const alwaysFalse = (x: boolean) => false;

// 6. Draw a picture of a category whose only objects are the types
// Void, () (unit), and Bool; with arrows corresponding to all possible
// functions between these types. Label the arrows with the
// names of the functions.
