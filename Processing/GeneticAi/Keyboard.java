import java.util.HashMap;
class Keyboard {
  static HashMap<Integer, Boolean> keys_pressed = new HashMap<Integer, Boolean>();
  static HashMap<Integer, Boolean> keys_toggled = new HashMap<Integer, Boolean>();

  // Update keys
  static void keyPressed_(int key_) {

    // Update pressed keys
    Keyboard.keys_pressed.put(key_, true);

    // Update toggled keys
    if (Keyboard.keys_toggled.get(key_) == null) keys_toggled.put(key_, true); 
    else Keyboard.keys_toggled.put(key_, !Keyboard.keys_toggled.get(key_));
  
  }

  // Update keys
  static void keyReleased_(int key_) {

    Keyboard.keys_pressed.put(key_, false);
  
  }

  // Check if key is pressed
  static boolean pressed(int key_) {
    
    if (keys_pressed.get(key_) == null) return false;
    else return keys_pressed.get(key_);
  }

  // Check if key is toggled
  static boolean toggled(int key_) {

    if (keys_toggled.get(key_) == null) return false;
    else return keys_toggled.get(key_);
  }
}


