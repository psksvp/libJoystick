//
//  IOJoystick.h
//  
//
//  Created by psksvp on 16/9/2022.
//
#ifndef __LIB_MACOS_JOYSTICK__
#define __LIB_MACOS_JOYSTICK__


typedef struct
{
  unsigned long iD;
  char* name;
  int numberOfAxis;
  int numberOfHats;
  int numberOfBalls;
  int numberOfButtons;
  
  int* axisData;
  int* buttonData;
  int* hatData;
} IOJoystick;

int IOJoystickCount();
IOJoystick* IOJoystickAttach(int index);
void IOJoystickDetach(IOJoystick* j);
void IOJoystickUpdate(IOJoystick* j);
#endif


