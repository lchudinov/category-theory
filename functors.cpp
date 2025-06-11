#include <functional>

template<class T>
struct Tree {
  virtual ~Tree() = default;
};

template<class T>
struct Leaf: public Tree<T> {
  T _label;
  Leaf(T l) : _label(l) {}
};

template<class T>
struct Node: public Tree<T> {
  Tree<T>* _left;
  Tree<T>* _right;
  Node(Tree<T>* l, Tree<T>* r) : _left(l), _right(r) {}
};

template<class A, class B>
Tree<B>* fmap(std::function<B(A)> f, Tree<A>* t) {
  Leaf<A>* pl = dynamic_cast<Leaf<A>*>(t);
  if (pl) {
    return new Leaf<B>(f(pl->_label));
  }

  Node<A>* pn = dynamic_cast<Node<A>*>(t);
  if (pn) {
    return new Node<B>(
      fmap<A, B>(f, pn->_left),
      fmap<A, B>(f, pn->_right)
    );
  }

  return nullptr;
}
