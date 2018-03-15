// versions used : processing 2.0b7, controlP5 2.0.4

import controlP5.*;
import processing.serial.*;
import processing.video.*;
import gab.opencv.*;

Serial port;
ControlP5 cp5;
PFont font;    //Creat Font 
int time = millis();
int wait = 1;
Capture video; 
OpenCV opencv; 
Button b2;
String[] ports;
Table data;
int windowLength; 
int windowWidth; 

void setup() {
  size(1280, 800);
  //size of the window
  ports = Serial.list(); 
  printArray(ports);//prints all avaliable serial ports
 // port=new Serial(this, ports[ports.length - 1],9600); //arduino connected to COMsth
  
  data = new Table();
  data.addColumn("Timestamp");
  data.addColumn("Action");
  data.addColumn("Angle");
  
  cp5 = new ControlP5(this);
  font = createFont("calibri light",20); //Change fount
  // pan left button
  Button b1 = cp5.addButton("PanL").setPosition(30, 175).setSize(150, 80).setFont(font);
  b1.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_ENTER): port.write('x');port.write('x');port.write('x');port.write('x');port.write('x');port.write('x');port.write('x');port.write('x');;break;
        case(ControlP5.ACTION_LEAVE): port.write('r');port.write('r');port.write('r');port.write('r');port.write('r');port.write('r');port.write('b');port.write('b');port.write('b');;break;
      }}});
      
      
  b2 = cp5.addButton("PanR").setPosition(350, 175).setSize(150, 80).setFont(font);
  b2.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_ENTER): port.write('r');port.write('r');port.write('r');port.write('r');port.write('r');port.write('r');port.write('r');port.write('r');;break;
        case(ControlP5.ACTION_LEAVE): port.write('x');port.write('x');port.write('x');port.write('x');port.write('x');port.write('x');port.write('b');port.write('b');port.write('b');;break;
      }}});
 
  Button b3 = cp5.addButton("TiltDown").setPosition(200,325).setSize(150, 80).setFont(font);
  b3.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_ENTER): port.write('q');port.write('q');port.write('q');;break;
        case(ControlP5.ACTION_LEAVE): port.write('e');port.write('e');port.write('e');; break;
      }}});
  
   Button b4 = cp5.addButton("TiltUp").setPosition(200,50).setSize(150, 80).setFont(font);
  b4.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_ENTER): port.write('w');port.write('w');port.write('w');;break;
        case(ControlP5.ACTION_LEAVE): port.write('e');port.write('e');port.write('e');; break;
      }}});

       
  Button b5 = cp5.addButton("Back").setPosition(35,500).setSize(125, 75).setFont(font);
  b5.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_ENTER): port.write('h');port.write('h');port.write('h');;break;
        case(ControlP5.ACTION_LEAVE): port.write('b');port.write('b');port.write('b');; break;
      }}}); 

  Button b6 = cp5.addButton("Laser").setPosition(200,500).setSize(125, 75).setFont(font);
  b6.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_ENTER): port.write('L');port.write('L');;break;
        case(ControlP5.ACTION_LEAVE): port.write('l');port.write('l');; break;
      }}});
  
  Button b7 = cp5.addButton("Front").setPosition(375,500).setSize(125, 75).setFont(font);
  b7.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_ENTER): port.write('j');port.write('j');port.write('j');;break;
        case(ControlP5.ACTION_LEAVE): port.write('b');port.write('b');port.write('b');; break;
      }}});
      
      String[] cameras = Capture.list();
 
    println("Available cameras:");
    printArray(cameras);
    
    video = new Capture(this, cameras[1]);
   video.start();
   
   opencv = new OpenCV(this, 320, 240);
}

void draw() {
   if (millis() - time >= wait){
    time = millis();  
   frameRate(900);
    scale(1);
    image(video, 1280/2 - 100, 125, 1920*0.35, 1080*0.35);
    if(video.width > 0 && video.height > 0){//check if the cam instance has loaded pixels
     opencv.loadImage(video);//send the cam
     opencv.gray();
     opencv.threshold(70); 
   }
 }
  
}
void captureEvent(Capture c){
  c.read();
 }
 
 void serialEvent(Serial port)
 {
    String val = port.readStringUntil('\n');
    if(val != null)
    {
       val = trim(val);
       println(val);
       String sensorVals[] = split(val, ',');
       
       if(sensorVals.length == 3)
       {
       
         TableRow newRow = data.addRow();
         newRow.setString("Timestamp", sensorVals[0]);
         newRow.setString("Action", sensorVals[1]);
         newRow.setString("Angle", sensorVals[2]);
         saveTable(data, "data.csv");
       }
    } 
 }