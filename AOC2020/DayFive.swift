import Foundation
/////// DAY FIVE

enum DayFive {
  static func partOne() -> Int {
    var maxSeatID = 0
    for boardingCode in instructions {
      let row = String(boardingCode.dropLast(3))
      let col = String(boardingCode.dropFirst(7))
      let seatID = (strtoul(row, nil, 2) * 8) + strtoul(col, nil, 2)
      maxSeatID = seatID > maxSeatID ? Int(seatID) : maxSeatID
    }
    return maxSeatID
  }

  static func partTwo() -> Int {
    var seats: [Int] = []
    
    for boardingCode in instructions {
       let rowString = String(boardingCode.dropLast(3))
       let columnString = String(boardingCode.dropFirst(7))
       let seatID = (strtoul(rowString, nil, 2) * 8) + strtoul(columnString, nil, 2)
       seats.append(Int(seatID))
    }
    // Cheated here and just skimmed the output array.
    print(seats.sorted())
    return -1
  }
}

