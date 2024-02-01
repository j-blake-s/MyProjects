



class Nest {

  private ArrayMap<Mouse> mice;

  // Constructor
  Nest() {
    this.mice = new ArrayMap<Mouse>();
  }

  // Returns the size of the array map
  int size() {return this.mice.size();}

  // Add Mouse
  void add(Mouse m) {
    this.mice.add(m);
  }

  // Remove Mouse
  void remove(int idx) {
    this.mice.remove(idx);
  }

  // Remove Mouse
  void remove(Mouse m) {
    this.mice.remove(m);
  }

  // Remove Mouse
  Mouse get(int idx) {
    return this.mice.get(idx);
  }

  // Draw Mice
  void draw() {
    for (int i = 0; i < this.size(); i++) {
      Mouse m = this.get(i);
      m.draw();
      m.drawConsumptionZone();
    }
  }

  // Main function
  void main() {
    this.draw();
  }
}