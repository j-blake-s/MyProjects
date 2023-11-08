import java.util.HashMap;
class Keyboard {
  static HashMap<Integer, Boolean> keys_ = new HashMap<Integer, Boolean>();

  static void keyPressed_(int key_) {
    Keyboard.keys_.put(key_, true);
  }

  static void keyReleased_(int key_) {
    Keyboard.keys_.put(key_, false);
  }

  static boolean get(int key_) {
    if (keys_.get(key_) == null) return false;
    else return keys_.get(key_);
  }
}


