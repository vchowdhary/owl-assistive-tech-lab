// versions used : processing 2.0b7, controlP5 2.0.4

import controlP5.*;
import processing.serial.*;

Serial port;
ControlP5 cp5;
PFont font;    //Creat Font 

void setup() {
  size(1000,900);             //size of the window
  printArray(Serial.list()); //prints all avaliable serial ports
  port=new Serial(this, "COM8",9600); //arduino connected to COMsth

  cp5 = new ControlP5(this);
  font = createFont("calibri light",40); //Change fount
  
  Button b1 = cp5.addButton("PanL").setPosition(150,350).setSize(200,170).setFont(font);
  b1.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): port.write('r');port.write('r');port.write('r');;break;
        case(ControlP5.ACTION_RELEASED): port.write('b');port.write('b');port.write('b');;break;
      }}});
      
  Button b2 = cp5.addButton("PanR").setPosition(650,350).setSize(200,170).setFont(font);
  b2.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): port.write('x');port.write('x');port.write('x');;break;
        case(ControlP5.ACTION_RELEASED): port.write('b');port.write('b');port.write('b');; break;
      }}});
      
  Button b3 = cp5.addButton("TiltDown").setPosition(400,150).setSize(200,170).setFont(font);
  b3.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): port.write('q');port.write('q');port.write('q');;break;
        case(ControlP5.ACTION_RELEASED): port.write('e');port.write('e');port.write('e');; break;
      }}});
      
   Button b4 = cp5.addButton("TiltUp").setPosition(400,550).setSize(200,170).setFont(font);
  b4.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): port.write('w');port.write('w');port.write('w');;break;
        case(ControlP5.ACTION_RELEASED): port.write('e');port.write('e');port.write('e');; break;
      }}});

       
  Button b5 = cp5.addButton("Both look back").setPosition(690,750).setSize(150,100).setFont(font);
  b5.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): port.write('h');port.write('h');port.write('h');;break;
        case(ControlP5.ACTION_RELEASED): port.write('b');port.write('b');port.write('b');; break;
      }}}); 

  Button b6 = cp5.addButton("Laser").setPosition(490,750).setSize(150,100).setFont(font);
  b6.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): port.write('L');port.write('L');;break;
        case(ControlP5.ACTION_RELEASED): port.write('l');port.write('l');; break;
      }}});
  
  //Button b7 = cp5.addButton("Laser Toggle").setPosition(290,750).setSize(150,100).setFont(font);
  //b7.addCallback(new CallbackListener() {
  //  public void controlEvent(CallbackEvent theEvent) {
  //    switch(theEvent.getAction()) {
  //      case(ControlP5.ACTION_PRESSED): port.write('L');port.write('L');;break;
  //      case(ControlP5.ACTION_RELEASED): port.write('l');port.write('l');; break;
  //    }}});

}

void draw() {
}