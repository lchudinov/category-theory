#include <concepts>
#include <string>

template<class T>
  T mempty() = delete;
  
template<class T>
  T mappend(T, T) = delete;
  
template<class M>
  concept Monoid = requires (M m) {
    { mempty } -> std::same_as<M>;
    { mappend(m, m) } -> std::same_as<M>;
  };

std::string mempty() { return ""; }

std::string mappend(std::string s1, std::string s2) {
  return s1 + s2;
}