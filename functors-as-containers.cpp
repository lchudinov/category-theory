#include <functional>

template <class C, class A>
struct Const
{
  Const(C v) : _v(v) {};
  C _v;
};

template <class C, class A, class B>
Const<C, B> fmap(std::function<B(A)> f, Const<C, A> c)
{
  return Const<C, B>{c._v};
};

