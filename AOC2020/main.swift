import Foundation
////
////  main.swift
////  AOC2020

// Turn Input into readable format
let url = URL(fileURLWithPath: "/Users/elevshte/Desktop/AOC2020/AOC2020/input.txt")
let input = try! String(contentsOf: url)
var instructions = input
  .split(separator: "\n")
  .map { Int($0)! }

DayOne.partOne()
DayOne.partTwo()
