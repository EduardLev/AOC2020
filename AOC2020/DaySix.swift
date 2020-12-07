//import Foundation
///////// DAY SIX
//
//enum DaySix {
//  static func partOne() -> Int {
//    return instructions
//      .map { $0.filter { !$0.isWhitespace }}
//      .map { Set($0) }
//      .map { $0.count }
//      .reduce(0, +)
//  }
//
//  static func partTwo() -> Int {
//    return instructions.map { instruction in
//      var questions = instruction.components(separatedBy: "\n").count
//      if (instruction.components(separatedBy: "\n").last == "") { questions -= 1 }
//      var filteredInstruction = instruction.filter { !$0.isWhitespace }
//      var characters: [Character : Int] = [:]
//      filteredInstruction.forEach { characters[$0] = (characters[$0] ?? 0) + 1 }
//      return characters.values.filter { $0 == questions }.count
//      }
//    .reduce(0, +)
//  }
//}
//
