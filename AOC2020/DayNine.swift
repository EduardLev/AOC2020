import Foundation
/////// DAY NINE

enum DayNine {
  static func partOne() -> Int {
    let integers = instructions.compactMap(Int.init)
    evaluate(integers: integers, preambleLength: 5)
    return -1
  }
  
  static func partTwo() -> Int {
    let answer = 70639851
    // find a contiguous set of at least two numbers which sum to 70639851
    let integers = instructions.compactMap(Int.init)
    let smallIntegers = integers.filter { $0 <= answer }
    
    outer: for i in 0..<smallIntegers.count {
      var sum = 0
      var numbers: [Int] = []
      for integer in smallIntegers[i...smallIntegers.count-1] {
        sum += integer
        numbers.append(integer)
        if sum == answer {
          print("Found it! Integers: \(numbers)")
          print(numbers.reduce(0, +))
          print(numbers.sorted().first! + numbers.sorted().last!)
        }
        else if sum > answer { continue outer }
      }
    }

    return -1
  }
}

func evaluate(integers: [Int], preambleLength: Int) {
  let preamble = Array(integers[0...preambleLength-1])
  let possibleSums = Set(pairs(preamble).map { $0.0 + $0.1 })
  let nextNumber = integers[preambleLength]

  if isPossibleNextNumber(sums: possibleSums, number: nextNumber) {
    print("good: \(nextNumber)")
    evaluate(integers: Array(integers.dropFirst()), preambleLength: preambleLength)
  } else {
    print("bad: \(nextNumber)")
  }
}

func isPossibleNextNumber(sums: Set<Int>, number: Int) -> Bool {
  return sums.contains(number)
}

func pairs(_ array: [Int]) -> [(Int, Int)] {
  if array == [] {
    return []
  }
  
  let head = array[0]
  let tail = Array(array.dropFirst())
  return tail.map{ (head, $0) } + pairs(tail)
}

