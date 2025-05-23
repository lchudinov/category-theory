interface Shape {
  area(): number;
  circ(): number;
}

class Circle implements Shape {
  constructor(private r: number) {}
  
  area(): number {
    return this.r * this.r * Math.PI;
  };
  circ(): number {
    return 2.0 * this.r * Math.PI;
  };
}

class Rect implements Shape {
  constructor(
    private d: number,
    private h: number,
  ) {
      
  }
  
  area(): number {
    return this.d * this.h;
  }
  circ(): number {
    return (this.d + this.h) * 2;
  }
}