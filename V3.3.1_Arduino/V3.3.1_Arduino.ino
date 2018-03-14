#include <Servo.h>
Servo mysservo;  // create servo object to control a servo
Servo myWservo;  // create servo object to control a servo

//Copy Data to here
int clock_wise_back=46;
int clock_wise_left=56;
int clock_wise_front=71;
int clock_wise_right=84;
int clock_wise_back_twin=97;

int counter_clock_wise_back=85;
int counter_clock_wise_right=71;
int counter_clock_wise_front=59;
int counter_clock_wise_left=44;
int counter_clock_wise_back_twin=33;
//
int mysservo_maximum=105;
int mysservo_minimum=8;

//Laser
const int ledPin = 7;  // the number of the LED pin
//sservo
int spos=90;      //set the initial position to 90
int scpos=mysservo_maximum-5;     // current position
int sstep=0;     //no initial movement
int sstepspeed=1;//sensitivity 
int sreverse=mysservo_maximum;  //reverse position of s
int sfront=90;                  //front position of s
int sdelay=50;
//Wservo
int wpos=clock_wise_front;      //set the initial position to 0
int wcpos=60;     // current position
int wstep=0;     //no initial movement
int wstepspeed=3;//sensitivity 
int wdelay=50;   //movement speed conrtol, Higher mean Slower
int overshoot_control= 0; //when releaseing the button, the wservo rotates slowlly to reach to desired position. by having the value -1 this can help to stop the wservo


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
      Serial.print((String) (millis()) +",Initialize Pan Servo,"+myWservo.read()+"\n");
      delay(1000);
      myWservo.write(clock_wise_front); 
      Serial.print((String) (millis()) +",Initialize Pan Servo" + myWservo.read()+"\n");
      delay(1000);
}



void loop() 
{
  char val = Serial.read();   //initial reading from serial monitor
  //Laser Control
  if(val=='L'){
    digitalWrite(ledPin, HIGH);   // turn LED on:
     Serial.print((String) (millis()) +",Laser On,"+" "+"\n");
  } 
  if(val=='l'){
    digitalWrite(ledPin, LOW);    // turn LED off:
     Serial.print((String) (millis()) +",Laser Off,"+" "+"\n");
  }
  
  //Top servo control
  scpos=mysservo.read();       //read the postion of top servo
  mysservo.write(spos);        //give positional command to top servo motor   
  if(scpos<=mysservo_maximum && scpos>=mysservo_minimum)   //works only if its in the range
  { 
    spos=spos+sstep;            //change the positional command value
    delay(sdelay);              //Speed control
    if(val=='q'){//if val is true, then it movesone way.
      sstep=sstepspeed; 
       Serial.print((String) (millis()) +",Tilt Servo Moving Down," + mysservo.read()+"\n");   
    }
    else if(val=='w'){               //if val is true, then it moves another way.
      sstep=-sstepspeed;   
      Serial.print((String) (millis()) +",Tilt Servo Moving Up," + mysservo.read()+"\n");              
    }  
    else if(val=='e'){               //if val is true, then it stops.
      sstep=0;
      Serial.print((String) (millis()) +",Tilt Servo Stop," + mysservo.read()+"\n");   
    }
    else if(val=='h'){              //Look back
      spos=sreverse;
      Serial.print((String) (millis()) +",Tilt Servo Back," + mysservo.read()+"\n");   
    }
    else if(val=='j'){              //Look front
     spos=sfront;
     Serial.print((String) (millis()) +",Tilt Servo Front," + mysservo.read()+"\n");   
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
      Serial.print((String) (millis()) +",Pan Servo Moving Right," + myWservo.read()+"\n");     
    }
    else if(val=='x'){               //if val is true, then it moves another way.
      wstep=-wstepspeed;     
      Serial.print((String) (millis()) +",Pan Servo Moving Left," + myWservo.read()+"\n");         
    }  
    else if(val=='b'){               //if val is true, then it stops.
      wstep=overshoot_control;       //apply overshoot value
      wstep=0; //make the change to 0
      Serial.print((String) (millis()) +",Pan Servo Stop," + myWservo.read()+"\n");
    }  
    else if(val=='h'){              //Look back based on current postion clockwise ot counter clock
      if(wcpos>clock_wise_front or wcpos==clock_wise_front){
      wpos=clock_wise_back_twin;}
      else if(wcpos<clock_wise_front){
      wpos=counter_clock_wise_back_twin;}
      Serial.print((String) (millis()) +",Pan Servo Moving Back," + myWservo.read()+"\n");
    }
        else if(val=='j'){              //Look front based on current postion clockwise ot counter clock
      if(wcpos>clock_wise_front or wcpos==clock_wise_front){
      wpos=counter_clock_wise_front;}
      else if(wcpos<clock_wise_front){
      wpos=clock_wise_front;}
      Serial.print((String) (millis()) +",Pan Servo Moving Front," + myWservo.read()+"\n");
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
//  Serial.print(wcpos);
//  Serial.println(wpos);

}



