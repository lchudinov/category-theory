// 1. Implement, as best as you can, the identity function in your favorite
// language (or the second favorite, if your favorite language
// happens to be Haskell).

function id<T>(x: T): T {
  return x;
}

// 2. Implement the composition function in your favorite language. It
// takes two functions as arguments and returns a function that is
// their composition.

function compose<A,B,C>(f: (x: A) => B, g: (x: B) => C): (x: A) => C {
  return (x: A) => g(f(x));
}

// 3. Write a program that tries to test that your composition function
// respects identity.

function double(x: number) { return x * x};
const double2 = compose(double, id);
const double3 = compose<number, number, number>(id, double);

console.assert(double2(5) === double(5));
console.assert(double3(5) === double(5));

// 4. Is the world-wide web a category in any sense? Are links morphisms?
// If web-sites are objects and links are morphisms, then not every site has a link to itself, and
// if site A has link to site B, and site B has a link to site C, not necessary site A has a link to site C.

// 5. Is Facebook a category, with people as objects and friendships as morphisms?
// No. Am I a friend of myself? No. The composition also doesn't hold. 

// 6. When is a directed graph a category?
// When each node is connected to every other node and itself.