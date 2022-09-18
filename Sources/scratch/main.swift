import libJoystick
import Foundation



print(Joystick.list)

if let j = Joystick.list.last
{
  var keepLooping = true
  while keepLooping
  {
    j.update()
    print(j.axisData)
    print(j.buttonData)
    print(j.hatData)
    keepLooping = !j.buttonData[0]
  }
}
