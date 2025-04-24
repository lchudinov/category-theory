#include <string>
#include <cctype>
#include <algorithm>
#include <vector>
#include <functional>
#include <utility>
#include <iterator>

using namespace std;

string logger;

bool negateNotPure(bool b) {
  logger += "Not so! ";
  return !b; 
}

pair<bool, string> negatePure(bool b, string logger) {
  return std::make_pair(!b, logger + "Not so! ");
}

pair<bool, string> negate2(bool b) {
  return std::make_pair(!b, "Not so! ");
}

string toUpper_first_try(string s) {
  string result;
  int (*toupperp)(int) = &toupper;
  transform(begin(s), end(s), back_inserter(result), toupperp);
  return result;
}

vector<string> words(string s) {
  vector<string> result{""};
  for (auto i = begin(s); i != end(s); ++i) {
    if (isspace(*i)) {
      result.push_back("");
    } else {
      result.back() += *i;
    }
  }
  return result;
}

vector<string> toWords_first_try(string s) {
  return words(s);
}

template<class A>
using Writer = pair<A, string>;

Writer<string> toUpper(string s) {
  string result;
  int (*toupperp)(int) = &toupper;
  transform(begin(s), end(s), back_inserter(result), toupperp);
  return make_pair(result, "toUpper ");
}

Writer<vector<string>> toWords(string s) {
  return make_pair(words(s), "toWords ");
}

pair<bool, string> isEven(int n) {
  return make_pair(n % 2 == 0, "isEven ");
}

pair<bool, string> isOdd(int n) {
  pair<bool, string> p1 = isEven(n);
  pair<bool, string> p2 = negate2(p1.first);
  return make_pair(p2.first, p1.second + p1.second);
}

template<class A, class B, class C>
function<Writer<C>(A)> compose_first_try(function<Writer<B>(A)> m1, function<Writer<C>(B)> m2) {
  return [m1, m2](A x) {
    auto p1 = m1(x);
    auto p2 = m2(p1.first);
    return make_pair(p2.first, p1.second + p2.second);
  };
}

Writer<vector<string>> process_first_try(string s) {
  return compose_first_try<string, string, vector<string>>(toUpper, toWords)(s);
}

auto const compose = [](auto m1, auto m2) {
  return [m1, m2](auto x) {
    auto p1 = m1(x);
    auto p2 = m2(p1.first);
    return make_pair(p2.first, p1.second + p2.second);
  };
};

Writer<vector<string>> process(string s) {
  return compose(toUpper, toWords)(s);
}

template<class A> Writer<A> identity(A x) {
  return make_pair(x, "");
}
