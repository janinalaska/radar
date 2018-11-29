import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;

PGraphics vizMask;

float water = 0;
float wind = 0;
float solar = 0;

float t = 0;

int pointerAngle = 180;
int position = 0;

UnfoldingMap map;

void setup() {
  //fullScreen();
  size(1050, 1050, P3D);
  frameRate(60);
  smooth();

  // prepare mask  
  vizMask = createGraphics(width, height);
  vizMask.beginDraw();
  vizMask.background(0);
  vizMask.ellipse(width/2, height/2, height, height);
  vizMask.endDraw();
  
  loadWater();
  loadSolar();
  //loadWind();
} 

void draw() {
  // increment time
  t += 1.0 / 60.0 / 15.0;
  pointerAngle = pointerAngle - 5;
  if(pointerAngle < 0) {
    pointerAngle = 380;
  }

  // draw viz
  vizWater();
  vizSolar();
  //vizWind();
  
  // get image
  PImage i = get();

  // mask image
  i.mask(vizMask);

  // draw image
  background(255);
  image(i, 0, 0, width, height);

  // reset time
  if (t > 1) {
    t = 0;
  }
}

void keyPressed() {
  float delta = 0.1;

  switch(key) {
  case 'q':
    water = constrain(water + delta, 0, 1);
    break;
  case 'w':
    wind = constrain(wind + delta, 0, 1);
    break;
  case 'e':
    solar = constrain(solar + delta, 0, 1);
    break;
  case 'a':
    water = constrain(water - delta, 0, 1);
    break;
  case 's':
    wind = constrain(wind - delta, 0, 1);
    break;
  case 'd':
    solar = constrain(solar - delta, 0, 1);
    break;
  }
  
  println("water: " + water + ", wind: " + wind + ", solar:", + solar);  
}
