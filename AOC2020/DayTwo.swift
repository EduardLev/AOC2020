import Foundation
/////// DAY TWO

enum DayTwo {
  static func partOne() -> Int {
    struct PasswordRules {
      let range: ClosedRange<Int>
      let letter: Character
      let password: String
    }
    
    let rules: [PasswordRules] = instructions.map {
      let contents = $0.split(separator: " ") // 2-5 z: zzztvz
      let bounds = String(contents[0]).split(separator: "-").map(String.init).map(Int.init) // 2-5
      let range = bounds[0]!...bounds[1]! // 2...5
      let letter = Character(String(contents[1].dropLast())) // z:
      let password = String(contents[2]) // zzztvz
      
      return PasswordRules(range: range, letter: letter, password: password)
    }
    
    let correctPasswordCount = rules
      .map { rule in
        let predicate: (Character) -> Bool = { $0 == rule.letter }
        return rule.range.contains(rule.password.filter(predicate).count)
      }
      .filter { $0 }
      .count
    
    return correctPasswordCount
  }
  
  static func partTwo() -> Int {
    struct PasswordRules {
      let positions: (Int, Int)
      let letter: Character
      let password: String
    }
    
    let rules: [PasswordRules] = instructions.map {
      let contents = $0.split(separator: " ")
      let positionsArray = String(contents[0]).split(separator: "-").map(String.init).map(Int.init)
      let positions = (positionsArray[0]! - 1, positionsArray[1]! - 1)
      let letter = Character(String(contents[1].dropLast()))
      let password = String(contents[2])
      
      return PasswordRules(positions: positions, letter: letter, password: password)
    }
    
    let correctPasswordCount = rules
      .map { rule in
        print(rule)
        let firstLetter = rule.password[String.Index(utf16Offset: rule.positions.0, in: rule.password)]
        let secondLetter = rule.password[String.Index(utf16Offset: rule.positions.1, in: rule.password)]
        print(firstLetter, secondLetter)
        return (rule.letter == firstLetter) != (rule.letter == secondLetter)
      }
      .filter { $0 }
      .count
    
    return correctPasswordCount
    
  }
}

