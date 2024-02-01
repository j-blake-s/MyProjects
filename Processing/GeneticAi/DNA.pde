


// Returns a random sample following a normal distribution around 1.01
float random_norm() {
  float u1 = random(1);
  float u2 = random(1);
  return (sqrt(-2 * log(u1)) * cos(2*PI*u2) / 10)+ 1.01;
}

// Random mutates a given number
float mutate(float val) {
  return (val+random(-0.01,0.01)) * random_norm();
}

class DNA {

  private float[] genes;

  private void init(int numGenes) {
    this.genes = new float[numGenes];
    for (int i = 0; i < numGenes; i++)
      this.genes[i] = random(1);
  }

  DNA(int numGenes) {
    init(numGenes);
  }

  int size() {return this.genes.length;}

  // Read Genome
  float read(int idx) {
    if (idx >= 0 && idx < this.size()) return this.genes[idx];
    else return -1;
  }

  // Write Genome
  void write(int idx, float val) {
    if (idx >= 0 && idx < this.size())
      this.genes[idx] = max(val, 0);
  }

  // Asexual Reproduction
  DNA clone(){
    DNA child = new DNA(this.size());
    for (int i = 0; i < this.size(); i++)
      child.write(i, mutate(this.read(i)));
    return child;
  }

  // Sexual Reproduction
  DNA reproduce(DNA that) {
    if (this.size() != that.size()) return null;
    
    DNA child = new DNA(this.size());

    // Inherit DNA from parents randomly
    for (int i = 0; i < child.size(); i++) {
      if (random(1) < 0.5) child.write(i, mutate(this.read(i)));
      else child.write(i, mutate(that.read(i)));
    }

    return child;
  } 

}  

