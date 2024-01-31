




// Returns a random sample following a normal distribution around 1
float random_norm() {
  float u1 = random(1);
  float u2 = random(1);
  return (sqrt(-2 * log(u1)) * cos(2*PI*u2) / 10)+1;
}