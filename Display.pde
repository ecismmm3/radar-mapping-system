import processing.serial.*;

Serial myPort;
float distance;
float pos = 0;
PFont font;

ArrayList<Float> x = new ArrayList<>();
ArrayList<Float> y = new ArrayList<>();

float multiplier = 7.0;

void setup() {
  size(800, 400);
  background(0);
  
  println(Serial.list());
  
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
}

void serialEvent(Serial myPort) {
  String line = myPort.readStringUntil('\n');
  
  if (line != null) {
    line = trim(line);       
    String[] parts = split(line, ',');  
    
    if (parts.length == 2) {   
      pos = float(parts[0]);
      distance = float(parts[1]);
        if (distance > 41.0) {
        distance = 41.0;
        }
      }
  }
}

void draw() {
 
  float maxdistance = 41.0;
  
  stroke(255, 0, 0, 100);
  strokeWeight(4);
  line(width/2 - cos(pos * PI / 180) * distance * multiplier, height - sin(pos * PI / 180) * distance * multiplier, width/2 - cos(pos * PI / 180) * maxdistance * multiplier, height - sin(pos * PI / 180) * maxdistance * multiplier);
  stroke(0, 255, 0, 50);
  strokeWeight(4);
  line(width/2, height, width/2 - cos(pos * PI / 180) * distance * multiplier, height - sin(pos * PI / 180) * distance * multiplier);
  x.add(pos*PI/180);
  if (x.size() > 350) {
    stroke(0, 0, 0);
    strokeWeight(4);
    line(width/2 - cos(x.get(0)) * maxdistance * multiplier, height - sin(x.get(0)) * maxdistance * multiplier,width/2, height);
    x.remove(0);
    
  }

 
}
