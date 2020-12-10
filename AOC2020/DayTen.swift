import Foundation
/////// DAY TEN

enum DayTen {
  static func partOne() -> [Int] {
    let voltageRatings = instructions.compactMap(Int.init)
    let builtInAdapter = voltageRatings.max()! + 3
    
    var modifiedVoltageRatings = voltageRatings
    var initialVoltage = 0
    var usedAdapters: [Int] = [0]

    while(true) {
      if modifiedVoltageRatings.isEmpty { break }
  
      let possibleAdapters = modifiedVoltageRatings.filter { $0 <= (initialVoltage + 3 ) }.sorted()
      let usedAdapter = possibleAdapters.first!
      modifiedVoltageRatings.remove(at: modifiedVoltageRatings.firstIndex(of: usedAdapter)!)
      usedAdapters.append(usedAdapter)
      initialVoltage += usedAdapter
    }
    
    usedAdapters.append(builtInAdapter)
    var oneDifferences = 0
    var threeDifferences = 0
    for i in 0..<(usedAdapters.count-1) {
      let difference = usedAdapters[i+1] - usedAdapters[i]
      if difference == 1 {
        oneDifferences += 1
      } else if difference == 3 {
        threeDifferences += 1
      }
    }
    
    return usedAdapters
  }
  
  static func partTwo() -> Int {
    // dynamic programming solve of part two
    let usedAdapters = DayTen.partOne()
    var dictionary = [0:1]
    usedAdapters.dropFirst().forEach { adapter in
      dictionary[adapter] = [1,2,3].compactMap { dictionary[adapter - $0] }.reduce(0, +)
    }
    return dictionary[usedAdapters.last!]!
  }
}
  // First solve of part two:
//static func partTwo() -> Int {
//    let usedAdapters = DayTen.partOne()
//    print(usedAdapters)
//
//  var groups = [[Int]]()
//  var group:[Int] = [0]
//  for i in 1..<(usedAdapters.endIndex-1) {
//    if usedAdapters[i+1] == usedAdapters[i] + 1 {
//      group.append(usedAdapters[i])
//    } else {
//      group.append(usedAdapters[i])
//      groups.append(group)
//      group = []
//    }
//  }
//  print(groups)
//  let x: [Int] = groups.map { group in
//    if group.count == 1 { return 1 }
//    if group.count == 2 { return 1 }
//    if group.count == 3 { return choose(n: 1, k: 1) + choose(n: 1, k: 0) }
//    if group.count == 4 { return choose(n: 2, k: 2) + choose(n: 2, k: 1) + choose(n: 2, k: 0) }
//    if group.count == 5 { return choose(n: 3, k: 3) + choose(n: 3, k: 2) + choose(n: 3, k: 1)}
//    else { return 0 }
//  }
//  print(x.reduce(1, *))
//  // print(findArrangements(usedAdapters, startingIndex: 1))
//  //let count = Set(potentialArrangements.map { $0.sorted() }).count
//  //print(count)
//    return -1
//  }
//
//  static func choose(n: Int, k: Int) -> Int {
//    if k == 0 { return 1 }
//    if n == k { return 1 }
//    return DayTen.choose(n: n-1, k: k-1) + DayTen.choose(n: n-1, k: k)
//  }
////    print(findArrangements(usedAdapters))
////    let set = Set(potentialArrangements
////      .filter { $0.contains(0) }
////      .filter { $0.contains(22) }
////      .map { $0.sorted() })
////    print(set.count + 1)
////    return -1
////  }
//
////func allDifferencesOneTwoOrThree(_ input: [Int]) -> Bool {
////  for i in 0..<(input.count - 1) {
////    if (1...3).contains(input[i+1] - input[i]) {
////      continue
////    } else {
////      return false
////    }
////  }
////
////  return true
////}
//}
//var potentialArrangements: [[Int]] = [[]]
//
////func memoize<T: Hashable, U>(work: @escaping ((T) -> U, T) -> U) -> (T) -> U {
////  var memo = Dictionary<T, U>()
////
////  func wrap(x: T) -> U {
////    if let q = memo[x] { return q }
////    let r = work(wrap, x)
////    memo[x] = r
////    return r
////  }
////
////  return wrap
////}
//
//
////func findArrangements(_ adapters: [Int], startingIndex: Int) {
////  if adapters.isEmpty { return }
////
////  for i in startingIndex..<adapters.endIndex-1 {
////    if adapters[i+1] - adapters[i-1] <= 3 {
////      var adaptersCopy = adapters
////      adaptersCopy.remove(at: i)
////      potentialArrangements.append(adaptersCopy)
////
////      findArrangements(adaptersCopy, startingIndex: i)
////    }
////  }
////}
