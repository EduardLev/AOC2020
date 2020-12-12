import Foundation
/////// DAY TWELVE

enum DayTwelve {
  static func partOne() -> Int {
    let shipInstructions: [ShipInstruction] = instructions.compactMap { input in
      guard let direction = ShipInstruction.Direction(rawValue: String(input.first!)) else { return nil }
      return ShipInstruction(value: Int(String(input.dropFirst()))!, direction: direction)
    }
    
    var currentDirection: ShipInstruction.Direction = .east
    var finalInstructions: [ShipInstruction] = []
    
    for instruction in shipInstructions {
      switch instruction.direction {
      case .north, .east, .south, .west:
        finalInstructions.append(instruction)
      case .forward:
        finalInstructions.append(.init(value: instruction.value, direction: currentDirection))
      case .left:
        currentDirection.left(degrees: instruction.value)
      case .right:
        currentDirection.right(degrees: instruction.value)
      }
    }
    
    var eastPosition: Int = 0
    var southPosition: Int = 0
    for instruction in finalInstructions {
      switch instruction.direction {
      case .north: southPosition -= instruction.value
      case .south: southPosition += instruction.value
      case .east: eastPosition += instruction.value
      case .west: eastPosition -= instruction.value
      default: continue
      }
    }
    
    print(abs(eastPosition) + abs(southPosition))
    
    return -1
  }
  
  static func partTwo() -> Int {
    let shipInstructions: [ShipInstruction] = instructions.compactMap { input in
      guard let direction = ShipInstruction.Direction(rawValue: String(input.first!)) else { return nil }
      return ShipInstruction(value: Int(String(input.dropFirst()))!, direction: direction)
    }
    var wayPoint: WaypointPosition = WaypointPosition(north: 1, east: 10)
    var shipPosition = ShipPosition(north: 0, east: 0)
    
    for instruction in shipInstructions {
      switch instruction.direction {
      case .north, .east, .west, .south, .left, .right: wayPoint.move(instruction: instruction)
      case .forward:
        shipPosition.north += instruction.value * wayPoint.north
        shipPosition.east += instruction.value * wayPoint.east
      }
    }

    print(abs(shipPosition.north) + abs(shipPosition.east))
    return -1
  }
}

struct ShipPosition {
  var north: Int
  var east: Int
}

struct WaypointPosition {
  var north: Int
  var east: Int
  
  mutating func move(instruction: ShipInstruction) {
    switch instruction.direction {
    case .forward: break
    case .left:
      self.left(degrees: instruction.value)
    case .right:
      self.right(degrees: instruction.value)
    case .east:
      east += instruction.value
    case .west:
      east -= instruction.value
    case .north:
      north += instruction.value
    case .south:
      north -= instruction.value
    }
  }
  
  mutating func left(degrees: Int) {
    if degrees <= 0 { return }
    let northCopy = north
    north = east
    east = -northCopy
    
    self.left(degrees: degrees - 90)
  }
  
  mutating func right(degrees: Int) {
    if degrees <= 0 { return }
    let eastCopy = east
    east = north
    north = -eastCopy
    
    self.right(degrees: degrees - 90)
  }
}

struct ShipInstruction: CustomStringConvertible {
  var description: String {
    return "\(direction): \(value)"
  }

  let value: Int
  let direction: Direction
  
  enum Direction: String, CustomStringConvertible {
    case north = "N"
    case south = "S"
    case east = "E"
    case west = "W"
    case left = "L"
    case right = "R"
    case forward = "F"
    
    mutating func right(degrees: Int) {
      if degrees <= 0 { return }

      switch self {
      case .left, .right, .forward: return
      case .east: self = .south
      case .west: self = .north
      case .north: self = .east
      case .south: self = .west
      }
      
      self.right(degrees: degrees - 90)
    }
    
    mutating func left(degrees: Int) {
      if degrees <= 0 { return }
      
       switch self {
       case .left, .right, .forward: return
       case .east: self = .north
       case .west: self = .south
       case .north: self = .west
       case .south: self = .east
       }
      
      self.left(degrees: degrees - 90)
     }

    var description: String {
      return rawValue
    }
  }
}
