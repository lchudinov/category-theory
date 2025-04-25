#include <cmath>

using namespace std;

template<class A> class optional {
  bool _isValid;
  A _value;
  public:
    optional() : _isValid(false) {}
    optional(A v) : _isValid(true), _value(v) {}
    bool isValid() const { return _isValid; }
    A value() const { return _value; }
};

auto const compose = [](auto m1, auto m2) {
  return [m1, m2](auto x) {
    auto p1 = m1(x);
    if (p1.isValid()) {
      return m2(p1.value());
    } else {
      return p1;  
    }
  };
};

template<class A> optional<A> identity(A x) {
  return optional<A>{x};
}

optional<double> safe_root(double x) {
  if (x > 0) {
    return optional<double>{sqrt(x)};
  } else {
    return optional<double>{};
  }
}

optional<double> safe_reciprocal(double x) {
  if (x != 0.0) {
    return optional<double>{1/x};
  } else {
    return optional<double>{};
  }
}

optional<double> safe_root_reciprocal(double x) {
  return compose(safe_reciprocal, safe_root)(x);
}
