import Foundation
/////// DAY THREE

enum DayThree {
  static func partOne() -> Int {
    DayThree.treesEncountered(input: instructions, slope: Slope(right: 3, down: 1), encountered: 0)
  }
  
  struct Slope {
    let right: Int
    let down: Int
  }

  static func treesEncountered(input: [[Int]], slope: Slope, encountered: Int) -> Int {
    if input.filter({ !$0.isEmpty }) == [] {
      return encountered
    }
    
    var encounteredCopy = encountered
    encounteredCopy += input[0][0]

    if (input.count >= slope.down - 1) && (input[0].count >= slope.right - 1) {
      let newInput =
        input
          .dropFirst(slope.down)
          .map(Array.init)
          .map { $0.dropFirst(slope.right) }
          .map(Array.init)
  
      return treesEncountered(input: newInput, slope: slope, encountered: encounteredCopy)
    } else {
      return treesEncountered(input: [[]], slope: slope, encountered: encounteredCopy)
    }
  }
  
  static func partTwo() -> Int {
    let slopes = [
      Slope(right: 1, down: 1),
      Slope(right: 3, down: 1),
      Slope(right: 5, down: 1),
      Slope(right: 7, down: 1),
      Slope(right: 1, down: 2)
    ]
    return slopes
      .map { DayThree.treesEncountered(input: instructions, slope: $0, encountered: 0) }
      .reduce(1, *)
  }
}

