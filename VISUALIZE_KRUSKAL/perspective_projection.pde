float[] perspectiveProjection(float X, float Y, float Z) {
  float x = X*cos(RY)+Z*sin(RY);
  float y = X*sin(RX)*sin(RY)+Y*cos(RX)-Z*sin(RX)*cos(RY);
  float z = X*cos(RX)*sin(RY)-Z*cos(RX)*cos(RY);
  
  // Define camera parameters
  float fov = PI / 3.0;         // Field of view in radians
  float viewDist = (height / 2.0) / tan(fov / 2.0); // Distance from the camera to the projection plane
  
  // Perform perspective projection
  float projectedX = x* viewDist / (z + viewDist);
  float projectedY = y * viewDist / (z + viewDist);
  
  // Return the projected coordinates
  return new float[] { projectedX, -projectedY };
}
