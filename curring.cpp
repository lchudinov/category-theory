#include <string>
#include <functional>
#include <iostream>

using namespace std::placeholders;

std::string catstr(std::string s1, std::string s2) {
  return s1 + s2;
}

int main() {
  auto greet = std::bind(catstr, "Hello ", _1);
  std::cout << greet("Haskell Curry");
}
