/*
TODO:
Practical:
- read from twitterstream, instead of keyboard
- how the heckfire do you then run this on a webserver? :/

Aesthetics: 
- make drops look like drops
- add a bit of randomness in brightness/hue of each color
- play with length/width

Eventually:
- drops randomly change and run into each other?
*/

import java.util.*;

float dropwidth = 1;
int droplength;
int speed = 2;
ArrayList<Drop> dlist = new ArrayList<Drop>();
int[] COLORARR = {0, 40, 60, 120, 240, 280};
int NUMCOLORS = 6;

void setup() {
  size(500,200);
  smooth();
  colorMode(HSB, 360, 100, 100);
  
  droplength = 3*height;
}



void draw() {
  background(0,0,0);
  
  // need to calculate colorcode, x location
  // can get x from colorcode
  int cc;
  if (keyPressed) {
    cc = getColorCode(key);
    if (cc != -1) {
      int x = getXLocation(cc);
      dlist.add(new Drop(COLORARR[cc], x, 0));
    }
  }
  

  Iterator<Drop> itr = dlist.iterator();  
  while(itr.hasNext()) {
    Drop d = itr.next();
    d.display();
    if (d.removeme) {
      itr.remove();
    }
  }
  println(dlist.size());
}

class Drop {
  float dcolor;
  int xloc;
  int ystart;
  int yend;
  boolean removeme = false;
  
  Drop(int c, int x, int y) {
    dcolor = c;
    xloc = x;
    ystart = -y;
    yend = -y - droplength;
  }
  
  void display() {
    strokeWeight(dropwidth);
    stroke(dcolor,100,100);
    line(xloc,ystart,xloc,yend);
    ystart+=speed;
    yend+=speed;
    
    if (yend > height) {
      removeme = true;
    }
  }
}

int getColorCode(char k) {
  if (k == 'q') {
    return 0;
  } else if (k == 'w') {
    return 1;
  } else if (k == 'e') {
    return 2;
  } else if (k == 'r') {
    return 3;
  } else if (k == 't') {
    return 4;
  } else if (k == 'y') {
    return 5;
  }
  return -1;
}

int getXLocation(int cc) {
  return (int) ( width/(2.0*NUMCOLORS) 
    + (cc*width)/NUMCOLORS 
    + (width/(3.0*NUMCOLORS))*randomGaussian() );
}

