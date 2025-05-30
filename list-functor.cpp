#include <iostream>      // Для std::cout и std::ostream_iterator
#include <vector>
#include <functional>
#include <iterator>
#include <algorithm>     // Для std::transform

template<class A, class B>
std::vector<B> fmap(std::function<B(A)> f, std::vector<A> v) {
  std::vector<B> w;
  std::transform(std::begin(v), std::end(v), std::back_inserter(w), f);
  return w;
}

void example() {
  std::vector<int> v{1, 2, 3, 4, 5};
  auto w = fmap<int, int>([](int i) { return i*i; }, v);
  std::copy(std::begin(w), std::end(w), std::ostream_iterator<int>(std::cout, ", "));
}
