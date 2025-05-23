class Shape {
  public:
  virtual float area() const = 0;
  virtual float circ() const = 0;
  virtual ~Shape() = default;
};

class Circle : public Shape  {
  float _r;
  
  public:
    Circle(float r): _r(r) {};
    float area() const override {
      return 3.14 * _r * _r;
    }
    float circ() const override {
      return 3.14 * _r * 2.0;
    }
};

class Rect: public Shape {
  float _d, _h;
  
  public:
    Rect(float d, float h): _d(d), _h(h) {};
    float area() const override {
      return _d * _h;
    }
    float circ() const override {
      return _d + _h + _d + _h;
    }
};

class Square: public Shape {
  float _d;
  
  public:
    Square(float d): _d(d) {};
    float area() const override {
      return _d * _d;
    }
    float circ() const override {
      return _d + _d + _d + _d;
    }
};