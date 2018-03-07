#include <Servo.h>
Servo mysservo;  // create servo object to control a servo
Servo myWservo;  // create servo object to control a servo
//Copy Data to here
int clock_wise_back=40;
int clock_wise_left=56;
int clock_wise_front=69;
int clock_wise_right=82;
int clock_wise_back_twin=96;
int counter_clock_wise_back=90;
int counter_clock_wise_right=77;
int counter_clock_wise_front=62;
int counter_clock_wise_left=48;
int counter_clock_wise_back_twin=34;
//
int mysservo_maximum=170;
int mysservo_minimum=90;
//Laser
const int ledPin = 7;  // the number of the LED pin
//sservo
int spos=mysservo_maximum-5;      //set the initial position to 0
int scpos=mysservo_maximum-5;     // current position
int sstep=0;     //no initial movement
int sstepspeed=2;//sensitivity 
int sreverse=mysservo_maximum;  //reverse position of s
int sdelay=50;
//Wservo
int wpos=clock_wise_front;      //set the initial position to 0
int wcpos=60;     // current position
int wstep=0;     //no initial movement
int wstepspeed=2;//sensitivity 
int wdelay=50;   //movement speed conrtol, Higher mean Slower
void setup() {
  mysservo.attach(8);  // attaches the TOP servo on pin 8 to the servo object
  myWservo.attach(9);  // attaches the Bottom servo on pin 9 to the servo object
  Serial.begin(9600);// initialize serial communication at 9600 bits per second:
  pinMode(ledPin, OUTPUT); //initialize the led pin
  scpos=mysservo.read();       //read the postion of top servo
//  mysservo.write(spos);        //give positional command to top servo motor   
//  wcpos=myWservo.read();       //read the postion of bottom servo
  // rotate the Wservo make it facing front
      myWservo.write(clock_wise_front-10); 
      delay(1000);
      myWservo.write(clock_wise_front); 
      delay(1000);
}
void loop() 
{
  char val = Serial.read();   //initial reading from serial monitor
  //Laser Control
  if(val=='L'){
    digitalWrite(ledPin, HIGH);   // turn LED on:
  } 
  if(val=='l'){
    digitalWrite(ledPin, LOW);    // turn LED off:
  }
  
  //Top servo control
  scpos=mysservo.read();       //read the postion of top servo
  mysservo.write(spos);        //give positional command to top servo motor   
  if(scpos<=mysservo_maximum && scpos>=mysservo_minimum)   //works only if its in the range
  { 
    spos=spos+sstep;            //change the positional command value
    delay(sdelay);              //Speed control
    if(val=='q'){               //if val is true, then it movesone way.
      sstep=sstepspeed;    
    }
    else if(val=='w'){               //if val is true, then it moves another way.
      sstep=-sstepspeed;              
    }  
    else if(val=='e'){               //if val is true, then it stops.
      sstep=0;
    }
    else if(val=='h'){              //YOU KNOW WHAT THIS IS BRO.
      spos=sreverse;
    }
   }  
  else if(scpos>mysservo_maximum or spos>mysservo_maximum){             //If position value is about to exceed the limit,bring it back to range
    spos=mysservo_maximum;
    scpos=mysservo_maximum;
  }  
  else if(scpos<mysservo_minimum or spos<mysservo_minimum){             //If position value is about to exceed the limit,bring it back to range
    spos=mysservo_minimum;
    scpos=mysservo_minimum;
  }
//  Serial.print(scpos);
//  Serial.println(spos);
 //Wservo control
  wcpos=myWservo.read();       //read the postion of servo
  myWservo.write(wpos);        //give positional command to servo motor    
  if(wcpos<=clock_wise_back_twin && wcpos>=counter_clock_wise_back_twin){ //works only if its in the range
    char val = Serial.read();   //initial reading from serial monitor
    wpos=wpos+wstep;            //change the positional command value
    delay(wdelay);              //Speed control
    if(val=='r'){               //if val is true, then it movesone way.
      wstep=wstepspeed;    
    }
    else if(val=='x'){               //if val is true, then it moves another way.
      wstep=-wstepspeed;              
    }  
    else if(val=='b'){               //if val is true, then it stops.
      wstep=0;
    }  
    else if(val=='h'){              //YOU KNOW WHAT THIS IS BRO.
      if(wcpos>clock_wise_front or wcpos==clock_wise_front){
      wpos=clock_wise_back_twin;}
      else if(wcpos<clock_wise_front){
      wpos=counter_clock_wise_back_twin;}
    }
  }
  if(wcpos>clock_wise_back_twin or wpos>clock_wise_back_twin){             //If position value is about to exceed the limit,bring it back to range
    wpos=clock_wise_back_twin;
    wcpos=clock_wise_back_twin;
  }  
  else if(wcpos<counter_clock_wise_back_twin or wpos<counter_clock_wise_back_twin){             //If position value is about to exceed the limit,bring it back to range
    wpos=counter_clock_wise_back_twin;
    wcpos=counter_clock_wise_back_twin;
  }
  Serial.print(wcpos);
  Serial.println(wpos);
//  
}
//

