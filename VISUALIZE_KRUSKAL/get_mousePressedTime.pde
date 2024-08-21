float mousePressedTime = 0;

float getMousePressedTime() {
  if (mousePressed) {
    if (mousePressedTime == 0) {
      mousePressedTime = millis();
    }
    return millis() - mousePressedTime;
  } else {
    mousePressedTime = 0;
    return 0;
  }
}
