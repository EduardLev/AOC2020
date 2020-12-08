//import Foundation
///////// DAY SEVEN
//
//enum DaySeven {
//  class Bag: Hashable {
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(color)
//    }
//
//    static func == (lhs: DaySeven.Bag, rhs: DaySeven.Bag) -> Bool {
//      lhs.color == rhs.color
//    }
//    
//    let color: String
//    var children: [(Bag, Int)] = []
//    
//    init(color: String, children: [(Bag, Int)]) {
//      self.color = color
//      self.children = children
//    }
//  }
//
//  static func partOne() -> Int {
//    var dictionary: [String : Bag] = [:]
//    
//    let instructionsArray = instructions.map { $0.components(separatedBy: " contain ") }.dropLast()
//    instructionsArray.forEach { instruction in
//      let color = String(instruction[0].dropLast(5))
//      
//      // Calculate children
//      let childInstructions = instruction.dropFirst().first!
//      let children: [(Bag, Int)] = childInstructions
//          .components(separatedBy: CharacterSet(charactersIn: ",."))
//          .map { $0.split(separator: " ") }
//          .filter { !$0.isEmpty }
//          .compactMap {
//            guard let number = Int(String($0.first!)) else { return nil }
//            
//            let color = String($0[1]) + " " + String($0[2])
//            
//            if let existingBag = dictionary[String(color)] {
//              return (existingBag, number)
//            } else {
//              let childBag = Bag(color: color, children: [])
//              dictionary[color] = childBag
//              return (childBag, number)
//            }
//          }
//      
//      if let existingBag = dictionary[String(color)] {
//        existingBag.children = children
//      } else {
//        let newBag = Bag(color: color, children: children)
//        dictionary[color] = newBag
//      }
//    }
//    
//     let filteredDictionary = dictionary.filter { key, bag in containsShinyGold(bag: bag) }
//     return filteredDictionary.count - 1
//    }
//
//  static func partTwo() -> Int {
//   var dictionary: [String : Bag] = [:]
//   
//   let instructionsArray = instructions.map { $0.components(separatedBy: " contain ") }.dropLast()
//   instructionsArray.forEach { instruction in
//     let color = String(instruction[0].dropLast(5))
//     
//     // Calculate children
//     let childInstructions = instruction.dropFirst().first!
//     let children: [(Bag, Int)] = childInstructions
//         .components(separatedBy: CharacterSet(charactersIn: ",."))
//         .map { $0.split(separator: " ") }
//         .filter { !$0.isEmpty }
//         .compactMap {
//           guard let number = Int(String($0.first!)) else { return nil }
//           
//           let color = String($0[1]) + " " + String($0[2])
//           
//           if let existingBag = dictionary[String(color)] {
//             return (existingBag, number)
//           } else {
//             let childBag = Bag(color: color, children: [])
//             dictionary[color] = childBag
//             return (childBag, number)
//           }
//         }
//     
//     if let existingBag = dictionary[String(color)] {
//       existingBag.children = children
//     } else {
//       let newBag = Bag(color: color, children: children)
//       dictionary[color] = newBag
//     }
//   }
//
//    return containedBagsIn(bag: dictionary["shiny gold"]!)
//  }
//}
//
//func containedBagsIn(bag: DaySeven.Bag) -> Int {
//  if bag.children.isEmpty {
//    return 0
//  }
//  
//  return bag.children.map { bag, number in
//    number + number * containedBagsIn(bag: bag)
//  }.reduce(0, +)
//}
//
//func containsShinyGold(bag: DaySeven.Bag) -> Bool {
//  if bag.color == "shiny gold" {
//    return true
//  }
//  
//  if bag.children.isEmpty {
//    return false
//  }
//  
//  return bag.children.contains(where: { containsShinyGold(bag: $0.0) })
//}
//
