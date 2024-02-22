


float[][] image;
float[][] filtered_image;
int image_size = 250;
boolean b = true;



float arithmetic_mean_filter(float[][] image, int i, int j) {
  
  int filter_size = 4;
  float sum  = 0;
  for (int l = -filter_size; l <= filter_size; l++) {
    for (int r = -filter_size; r <= filter_size; r++) {
      sum += (image[i+l][j+r] / 81.0);
    }
  }
  return sum;
}

float geometric_mean_filter(float[][] image, int i, int j) {
  
  int filter_size = 4;

  float sum  = 1;
  for (int l = -filter_size; l <= filter_size; l++) {
    for (int r = -filter_size; r <= filter_size; r++) {
      sum =  sum * image[i+l][j+r];
    }
  }

  return pow(sum, 1/81.0);
}

float harmonic_mean_filter(float[][] image, int i, int j) {
  
  int filter_size = 4;

  float sum  = 0;
  for (int l = -filter_size; l <= filter_size; l++) {
    for (int r = -filter_size; r <= filter_size; r++) {
      if (image[i+l][j+r] == 0)
        return 0;
      sum =  sum + (1.0 / image[i+l][j+r]);
    }
  }

  return 81.0 / sum;
}

float contraharmonic_mean_filter(float[][] image, int i, int j, int Q) {
  

  int filter_size = 4;

  float top = 0;
  float bottom = 0;
  for (int l = -filter_size; l <= filter_size; l++) {
    for (int r = -filter_size; r <= filter_size; r++) {
      top += pow(image[i+l][j+r], Q+1);
      bottom += pow(image[i+l][j+r], Q);
    }
  }

  return top / bottom;
}

float median_filter(float[][] image, int i, int j) {
  int filter_size = 4;
  float[] vals = new float[81];
  for (int n = 0; n < 81; n++) {
    int l = n % 9;
    int r = n / 9;
    vals[n] = image[i+l-4][j+r-4];
  }

  vals = sort(vals);

  return vals[40];
}

float max_filter(float[][] image, int i, int j) {
  int filter_size = 4;
  float[] vals = new float[81];
  for (int n = 0; n < 81; n++) {
    int l = n % 9;
    int r = n / 9;
    vals[n] = image[i+l-4][j+r-4];
  }

  vals = sort(vals);

  return vals[80];
}


float min_filter(float[][] image, int i, int j) {
  int filter_size = 4;
  float[] vals = new float[81];
  for (int n = 0; n < 81; n++) {
    int l = n % 9;
    int r = n / 9;
    vals[n] = image[i+l-4][j+r-4];
  }

  vals = sort(vals);

  return vals[0];
}

float midpoint_filter(float[][] image, int i, int j) {
  int filter_size = 4;
  float[] vals = new float[81];
  for (int n = 0; n < 81; n++) {
    int l = n % 9;
    int r = n / 9;
    vals[n] = image[i+l-4][j+r-4];
  }

  vals = sort(vals);

  return (vals[0] + vals[80])/2;
}


void setup() {
  size(500, 500);
  background(0);
  image = new float[image_size][image_size];

  for (int i = 0; i < image_size; i++) {
    for (int j = 0; j < image_size; j++) {
      image[i][j] = 0;
    }
  }

  int left = 25;
  int top = 20;
  for (int i = 0; i < 9; i++) {
    image = fillBar(left + ((7+17)*i), top, image);
  }

  filtered_image = applyFilter(image);
  background(0);
  drawScreen(image);

}

void draw() {
  // background(0);
  // drawScreen(filtered_image);
}


void keyPressed() {
  if (keyCode == 32) {
    if (b) {
      background(0);
      drawScreen(filtered_image);
      b = false;
    } else {
      background(0);
      drawScreen(image);
      b = true;
    } 
  }
}



float[][] applyFilter(float[][] img) {

  float[][] filt_img = new float[image_size][image_size];

  for (int i = 0; i < image_size; i++) {
    for (int j = 0; j < image_size; j++) {
      filt_img[i][j] = 0;
    }
  }

  for (int i = 4; i < image_size-4; i++) {
    for (int j = 4; j < image_size-4; j++) {
      filt_img[i][j] = arithmetic_mean_filter(img, i, j);
      // filt_img[i][j] = geometric_mean_filter(img, i, j);
      // filt_img[i][j] = harmonic_mean_filter(img, i, j);
      // filt_img[i][j] = contraharmonic_mean_filter(img, i, j, 1);
      // filt_img[i][j] = contraharmonic_mean_filter(img, i, j, 0);
      // filt_img[i][j] = contraharmonic_mean_filter(img, i, j, -1);
      // filt_img[i][j] = median_filter(img, i, j);
      // filt_img[i][j] = max_filter(img, i, j);
      // filt_img[i][j] = min_filter(img, i, j);
      // filt_img[i][j] = midpoint_filter(img, i, j);
    }
  }

  return filt_img;
}


float[][] fillBar(int i, int j, float[][] ps){

  for (int ix = i; ix < i+7; ix++) {
    for (int jx = j; jx < j+210; jx++) {
      ps[ix][jx] = 255;
    }
  }

  return ps;
}
void drawScreen(float[][] ps) {

  for (int i = 0; i < 250; i++) {
    for (int j = 0; j < 250; j++) {
      // print(ps[i][j] + " ");
      fill(ps[i][j]);
      noStroke();
      rect(2*i, 2*j, 2, 2);
    }
    // println();
  }
}