/////// DAY ONE
let desiredValue = 2020

enum DayOne {
  static func partOne() -> Int? {
    var dictionary: [Int : Int] = [:]
    for number in instructions {
      guard !dictionary.isEmpty else { dictionary[number] = number; continue }

      let difference = desiredValue - number
      if let existingNumber = dictionary[difference] {
        print(existingNumber, number)
        return existingNumber * number
      } else {
        dictionary[number] = number
      }
    }

    return nil
  }

  static func partTwo() -> Int? {
    var dictionary: [Int : Int] = [:]
    for number in instructions {
      dictionary[number] = number
    }
    
    for i in 0..<instructions.count {
      for j in 1..<instructions.count {
        let (first, second) = (dictionary[instructions[i]]!, dictionary[instructions[j]]!)
        if let existingNumber = dictionary[desiredValue - first - second] {
          print(existingNumber, first, second)
          return existingNumber * first * second
        } else {
          continue
        }
      }
    }

    return nil
  }
}

