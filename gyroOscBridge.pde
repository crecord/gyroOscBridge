/**
 * simple example for receiving from gyrosc
 * http://www.bitshapesoftware.com/instruments/gyrosc/
 * 
 */
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;

// create global variables to store the incoming variables
// to understand the difference between the gyroscope and accelerometer
// reference: http://www.livescience.com/40103-accelerometer-vs-gyroscope.html
PVector accel = new PVector(); 
PVector gyro = new PVector(); 
float compass;

void setup() {
  size(400,400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 8335 */
  oscP5 = new OscP5(this,8335);
  
  // set up event listeners for the various osc messages 
  oscP5.plug(this, "gyroReceived", "/gyrosc/gyro");
  oscP5.plug(this, "accelReceived", "/gyrosc/accel");
  oscP5.plug(this, "compassReceived", "/gyrosc/comp");
  
}


void draw() {
  
  // draw a rectangle that is affected by sensor data
  background(0); 
  
  float xOffset = map(accel.x,-1,1,-50,50); 
  float yOffset = map(accel.y,-1,1,-50,50); 
  
  translate(width/2 + xOffset, height/2 + yOffset); 
  rotate(gyro.x); 
  rectMode(CENTER);
  float scale = map(gyro.y, -1,1,20,70); 
  rect(0,0, scale,scale); 
}


// all the event listeners

public void gyroReceived(float pitch, float roll, float yaw) {
  println("pitch: " + pitch);
  println("roll: " + roll);
  println("yaw: " + yaw);
  gyro.set(pitch, roll, yaw);
}

public void accelReceived(float x, float y, float z) {
  println("x: " + x);
  println("y: " + y);
  println("z: " + z);
  accel.set(x,y,z);
}


public void compassReceived(float h) {
  println("compass: " + h);
  compass = h; 
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  /*
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  */
}