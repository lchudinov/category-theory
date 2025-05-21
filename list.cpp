template<class T> 
class Node {
  T _a;
  public:
    Node(T a): _a(a) {};
};

template <class A>
class List {
  Node<A> *_head;
  public:
    List() : _head(nullptr) {}
    List(A a, List<A> l): _head(new Node<A>(a, l)) {}
};
