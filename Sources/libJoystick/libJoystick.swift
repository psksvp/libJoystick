import IOJoystick
import Foundation

open class Joystick
{
  public enum HatPosition: Int
  {
    case center = 0
    case up = 1
    case down = 2
    case right = 3
    case left = 4
    case rightUp = 5
    case rightDown = 6
    case leftUp = 7
    case leftDown = 8
  }
  public class var count: Int
  {
    Int(IOJoystickCount())
  }
  
  public class var list: [Joystick]
  {
    (0 ..< self.count).compactMap {Joystick($0)}
  }
  
  public let id: Int
  public let name: String
  
  public var axisCount: Int
  {
    Int(self.ioJoystick.pointee.numberOfAxis)
  }
  
  public var buttonCount: Int
  {
    Int(self.ioJoystick.pointee.numberOfButtons)
  }
  
  public var hatCount: Int
  {
    Int(self.ioJoystick.pointee.numberOfHats)
  }
  
  public var axisData: [Int]
  {
    (0 ..< self.axisCount).map {Int(self.ioJoystick.pointee.axisData[$0])}
  }
  
  public var buttonData: [Bool]
  {
    (0 ..< self.buttonCount).map {self.ioJoystick.pointee.buttonData[$0] >= 1}
  }
  
  public var hatData: [HatPosition]
  {
    (0 ..< self.hatCount).map {HatPosition(rawValue: Int(self.ioJoystick.pointee.hatData[$0])) ?? HatPosition.center}
  }
  
  private let ioJoystick: UnsafeMutablePointer<IOJoystick>
  
  public init?(_ deviceID: Int)
  {
    guard deviceID >= 0 && deviceID < IOJoystickCount(),
          let j = IOJoystickAttach(Int32(deviceID)) else
    {
      return nil
    }
    self.id = deviceID
    self.ioJoystick = j
    self.name = String(cString: j.pointee.name)
  }
  
  deinit
  {
    IOJoystickDetach(self.ioJoystick)
  }
  
  public func update()
  {
    IOJoystickUpdate(self.ioJoystick)
  }
  
}


//call c IOJoystick
//print(joystickCount())
//let j = joystickConnect(0);
//if let n = j?.pointee.name
//{
//  print(String(cString: n))
//}
//if let jy = j
//{
//  while(true)
//  {
//    joystickUpdate(j)
//    if let a = jy.pointee.axisData
//    {
//      for i in 0 ..< jy.pointee.numberOfAxis
//      {
//        print("\(a[Int(i)]),", terminator: "")
//      }
//    }
//    else
//    {
//      break
//    }
//    print("")
//  }
//}
//joystickDisconnect(j)
