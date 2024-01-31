class DNA {

  private float[] genes;

  private void init(int numGenes) {
    this.genes = new float[numGenes];
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
}  
// Sexual Reproduction
DNA reproduce(DNA mom, DNA dad) {
  if (mom.size() != dad.size()) return null;
  
  DNA child = new DNA(mom.size());

  // Inherit DNA from parents randomly
  for (int i = 0; i < child.size(); i++) {
    if (random(1) < 0.5) child.write(i, mutate(mom.read(i)));
    else child.write(i, mutate(dad.read(i)));
  }

  return child;
} 

// Random mutates a given number
float mutate(float val) {
  return (val+random(-0.01,0.01)) * random_norm();
}