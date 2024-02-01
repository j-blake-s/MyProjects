import java.util.ArrayList;
import java.util.HashMap;

class ArrayMap<T> {
  ArrayList<Integer> freeIdx;
  ArrayList<T> mice; 
  HashMap<T, Integer> miceMap;

  // Constructor
  ArrayMap() {
    this.freeIdx = new ArrayList<Integer>();
    this.mice = new ArrayList<T>();
    this.miceMap = new HashMap<T, Integer>();
  }

  int size() {return this.mice.size();}
  // Check if index is valid for arraylist
  boolean isValid(int idx) {
    if (idx >= 0 && idx < this.mice.size()) return true;
    else return false;
  }

  void add(T m) {
    if (this.freeIdx.size() == 0) {
      this.miceMap.put(m, this.mice.size());
      this.mice.add(m);
    } else {
      int idx = this.freeIdx.remove(0);
      this.mice.set(idx, m);
      this.miceMap.put(m, idx);
    }
  }

  void remove(int idx) {
    if (!this.isValid(idx) || this.mice.get(idx) == null) return;
    else {
      T m = this.mice.get(idx);
      this.mice.set(idx, null);
      this.freeIdx.add(idx);
      this.miceMap.put(m, -1);
    }
  }

  void remove(T m) {

    // Get index of T from map
    Integer idx = this.miceMap.get(m);

    // If index is null or negative, already deleted
    if (idx == null || idx < 0) return;
    else {
      this.mice.set(idx, null);
      this.miceMap.put(m, -1);
      this.freeIdx.add(idx);
    }
  }

  T get(int idx) {
    if (!this.isValid(idx) || this.mice.get(idx) == null) return null;
    else return this.mice.get(idx);
  }
}