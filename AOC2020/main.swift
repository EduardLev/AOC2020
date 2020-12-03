import Foundation
////
////  main.swift
////  AOC2020

// Turn Input into readable format
let url = URL(fileURLWithPath: "/Users/eduardlev/repos/AOC2020/AOC2020/input.txt")
let input = try! String(contentsOf: url)
var instructions: [[Int]] = input
  .split(separator: "\n")
  .map { String($0) }
  .map { String.init(repeating: $0, count: 500) }
  .map(Array.init)
  .map { $0.map { string in
    switch string {
    case ".": return 0
    case "#": return 1
    default: return -1
    }
  }}

//DayOne.partOne() // .map { Int($0) } on input
//DayOne.partTwo() // .map { Int($0) } on input
// print(DayTwo.partOne()) // .map { String($0) }
// print(DayTwo.partTwo()) // .map { String($0) }
print(DayThree.partOne())
print(DayThree.partTwo())
