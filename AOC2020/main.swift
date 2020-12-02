import Foundation
////
////  main.swift
////  AOC2020

// Turn Input into readable format
let url = URL(fileURLWithPath: "/Users/elevshte/repos/AOC2020/AOC2020/input.txt")
let input = try! String(contentsOf: url)
var instructions = input
  .split(separator: "\n")
  .map { String($0) }

//DayOne.partOne() // .map { Int($0) } on input
//DayOne.partTwo() // .map { Int($0) } on input
print(DayTwo.partOne())
print(DayTwo.partTwo())
