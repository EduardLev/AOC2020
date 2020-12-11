import Foundation
/////// DAY ELEVEN

enum DayEleven {
  static func partOne() -> Int {
    let inputSeatGrid = instructions.map(Array.init).map { $0.compactMap { Position(rawValue: String($0)) } }
    
    var startingSeatGrid = inputSeatGrid
    var mutatingSeatGrid = inputSeatGrid
    var loops = 0
    
    while(true) {
      loops += 1
      for row in 0..<startingSeatGrid.count {
        for col in 0..<startingSeatGrid[row].count {
          guard let seat = startingSeatGrid[safe: row]?[safe: col] else { continue }
          switch seat {
          case .floor: continue
          case .emptySeat:
            if numberOfAdjacentOccupiedSeats(in: startingSeatGrid, for: (row: row, col: col)) == 0 {
              mutatingSeatGrid[row][col] = .occupiedSeat
            }
          case .occupiedSeat:
            if numberOfAdjacentOccupiedSeats(in: startingSeatGrid, for: (row: row, col: col)) >= 4 {
              mutatingSeatGrid[row][col] = .emptySeat
            }
          }
        }
      }
      
      if startingSeatGrid == mutatingSeatGrid {
        break
      } else {
        startingSeatGrid = mutatingSeatGrid
      }
    }
    
    let numberOfOccupiedSeats = mutatingSeatGrid.map { $0.map { $0 == .occupiedSeat ? 1 : 0 }}.joined().reduce(0, +)
    return numberOfOccupiedSeats
  }
  
  static func partTwo() -> Int {
    let inputSeatGrid = instructions.map(Array.init).map { $0.compactMap { Position(rawValue: String($0)) } }
    
    var startingSeatGrid = inputSeatGrid
    var mutatingSeatGrid = inputSeatGrid
    var loops = 0
    
    while(true) {
      loops += 1
      for row in 0..<startingSeatGrid.count {
        for col in 0..<startingSeatGrid[row].count {
          guard let seat = startingSeatGrid[safe: row]?[safe: col] else { continue }
          switch seat {
          case .floor: continue
          case .emptySeat:
            if numberOfVisibleOccupiedSeats(in: startingSeatGrid, for: (row: row, col: col)) == 0 {
              mutatingSeatGrid[row][col] = .occupiedSeat
            }
          case .occupiedSeat:
            if numberOfVisibleOccupiedSeats(in: startingSeatGrid, for: (row: row, col: col)) >= 5 {
              mutatingSeatGrid[row][col] = .emptySeat
            }
          }
        }
      }
      
      if startingSeatGrid == mutatingSeatGrid {
        break
      } else {
        startingSeatGrid = mutatingSeatGrid
      }
    }
    
    let numberOfOccupiedSeats = mutatingSeatGrid.map { $0.map { $0 == .occupiedSeat ? 1 : 0 }}.joined().reduce(0, +)
    return numberOfOccupiedSeats
  }
}

func numberOfAdjacentOccupiedSeats(in input: [[Position]], for location: (row: Int, col: Int)) -> Int {
  var number = 0
  let (row, col) = (location.row, location.col)

  if let right = input[safe: row]?[safe: col+1] { if determineOccupied(right) { number += 1 } }
  if let topRight = input[safe: row-1]?[safe: col+1] { if determineOccupied(topRight) { number += 1 } }
  if let bottomRight = input[safe: row+1]?[safe: col+1] { if determineOccupied(bottomRight) { number += 1 } }
  if let top = input[safe: row-1]?[safe: col] { if determineOccupied(top) { number += 1 } }
  if let bottom = input[safe: row+1]?[safe: col] { if determineOccupied(bottom) { number += 1 } }
  if let left = input[safe: row]?[safe: col-1] { if determineOccupied(left) { number += 1 } }
  if let topLeft = input[safe: row-1]?[safe: col-1] { if determineOccupied(topLeft) { number += 1 } }
  if let bottomLeft = input[safe: row+1]?[safe: col-1] { if determineOccupied(bottomLeft) { number += 1 } }
  
  return number
}

func numberOfVisibleOccupiedSeats(in input: [[Position]], for location: (row: Int, col: Int)) -> Int {
  var number = 0
  let (row, col) = (location.row, location.col)
  
  if row == 0, col == 6 {
    print("here")
  }

  var rightCol = col
  while rightCol < input[row].count {
    if let right = input[safe: row]?[safe: rightCol+1] {
      if right == .occupiedSeat {
        number += 1; break
      } else if right == .emptySeat {
        break
      } else { rightCol += 1 }
    } else {
      break
    }
  }

  var topRightCol = col
  var topRightRow = row
  while topRightCol < input[row].count, topRightRow > 0 {
    if let topRight = input[safe: topRightRow-1]?[safe: topRightCol+1] {
      if topRight == .occupiedSeat {
        number += 1; break
      }
      else if topRight == .emptySeat { break }
      else { topRightCol += 1; topRightRow -= 1}
    } else { break }
  }

  var bottomRightCol = col
  var bottomRightRow = row
  while bottomRightCol < input[row].count, bottomRightRow < input.count {
    if let bottomRight = input[safe: bottomRightRow+1]?[safe: bottomRightCol+1] {
      if bottomRight == .occupiedSeat {
        number += 1; break
      }
      else if bottomRight == .emptySeat { break }
      else { bottomRightCol += 1; bottomRightRow += 1}
    } else { break }
  }

  var topRow = row
  while topRow > 0 {
    if let top = input[safe: topRow-1]?[safe: col] {
      if top == .occupiedSeat {
        number += 1; break
      }
      else if top == .emptySeat { break }
      else { topRow -= 1 }
    } else { break }
  }

  var bottomRow = row
  while bottomRow < input.count {
    if let bottom = input[safe: bottomRow+1]?[safe: col] {
      if bottom == .occupiedSeat { number += 1; break }
      else if bottom == .emptySeat { break }
      else {
        bottomRow += 1
      }
    } else { break }
  }

  var leftCol = col
  while leftCol > 0 {
    if let left = input[safe: row]?[safe: leftCol-1] {
      if left == .occupiedSeat{ number += 1; break }
      else if left == .emptySeat { break }
      else {
        leftCol -= 1
      }
    } else { break }
  }

  var topLeftRow = row
  var topLeftCol = col
  while topLeftRow > 0, topLeftCol > 0 {
    if let topLeft = input[safe: topLeftRow-1]?[safe: topLeftCol-1] {
      if topLeft == .occupiedSeat { number += 1; break }
      else if topLeft == .emptySeat { break }
      else {
        topLeftRow -= 1
        topLeftCol -= 1
      }
    } else { break }
  }

  var bottomLeftRow = row
  var bottomLeftCol = col
  while bottomLeftRow < input.count, bottomLeftCol > 0 {
    if let bottomLeft = input[safe: bottomLeftRow+1]?[safe: bottomLeftCol-1] {
      if bottomLeft == .occupiedSeat { number += 1; break }
      else if bottomLeft == .emptySeat { break }
      else {
        bottomLeftRow += 1
        bottomLeftCol -= 1
      }
    } else { break }
  }

  return number
}

func determineOccupied(_ position: Position) -> Bool {
  switch position {
  case .emptySeat, .floor: return false
  case .occupiedSeat: return true
  }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

enum Position: String, CustomStringConvertible {
  case floor = "."
  case emptySeat = "L"
  case occupiedSeat = "#"
  
  var description: String {
    return self.rawValue
  }
}
