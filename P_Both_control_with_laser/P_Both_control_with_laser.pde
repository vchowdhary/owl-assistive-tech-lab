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

void setup() {
  size(1000,900);             //size of the window
  printArray(Serial.list()); //prints all avaliable serial ports
  port=new Serial(this, "COM15",9600); //arduino connected to COMsth

  cp5 = new ControlP5(this);
  font = createFont("calibri light",40); //Change fount
  
  Button b1 = cp5.addButton("PanL").setPosition(150,350).setSize(200,170).setFont(font);
  b1.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): port.write('x');port.write('x');port.write('x');port.write('x');port.write('x');port.write('x');port.write('x');port.write('x');;break;
        case(ControlP5.ACTION_RELEASED): port.write('r');port.write('r');port.write('r');port.write('r');port.write('r');port.write('r');port.write('b');port.write('b');port.write('b');;break;
      }}});
      
  Button b2 = cp5.addButton("PanR").setPosition(650,350).setSize(200,170).setFont(font);
  b2.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): port.write('r');port.write('r');port.write('r');port.write('r');port.write('r');port.write('r');port.write('r');port.write('r');;break;
        case(ControlP5.ACTION_RELEASED): port.write('x');port.write('x');port.write('x');port.write('x');port.write('x');port.write('x');port.write('b');port.write('b');port.write('b');; break;
      }}});
      
  Button b3 = cp5.addButton("TiltDown").setPosition(400,550).setSize(200,170).setFont(font);
  b3.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): port.write('q');port.write('q');port.write('q');;break;
        case(ControlP5.ACTION_RELEASED): port.write('e');port.write('e');port.write('e');; break;
      }}});
      
   Button b4 = cp5.addButton("TiltUp").setPosition(400,150).setSize(200,170).setFont(font);
  b4.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): port.write('w');port.write('w');port.write('w');;break;
        case(ControlP5.ACTION_RELEASED): port.write('e');port.write('e');port.write('e');; break;
      }}});

       
  Button b5 = cp5.addButton("Back").setPosition(690,750).setSize(150,100).setFont(font);
  b5.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): port.write('h');port.write('h');port.write('h');;break;
        case(ControlP5.ACTION_RELEASED): port.write('b');port.write('b');port.write('b');; break;
      }}}); 

  Button b6 = cp5.addButton("Laser").setPosition(290,750).setSize(150,100).setFont(font);
  b6.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): port.write('L');port.write('L');;break;
        case(ControlP5.ACTION_RELEASED): port.write('l');port.write('l');; break;
      }}});
  
  Button b7 = cp5.addButton("Front").setPosition(490,750).setSize(150,100).setFont(font);
  b7.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): port.write('j');port.write('j');port.write('j');;break;
        case(ControlP5.ACTION_RELEASED): port.write('b');port.write('b');port.write('b');; break;
      }}});
      
      String[] cameras = Capture.list();
 
    println("Available cameras:");
    printArray(cameras);
    
    video = new Capture(this, cameras[103]);
   video.start();
   
   opencv = new OpenCV(this, 320, 240);
}

void draw() {
   if (millis() - time >= wait){
    time = millis();  
   frameRate(900);
    scale(1);
    image(video, 1920/2, 100, 320*2.5, 240*2.5);
    if(video.width > 0 && video.height > 0){//check if the cam instance has loaded pixels
     opencv.loadImage(video);//send the cam
     opencv.gray();
     opencv.threshold(70); 
   }
 }
void captureEvent(Capture c){
  c.read();
 }
