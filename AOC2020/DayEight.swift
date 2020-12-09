//import Foundation
///////// DAY EIGHT
//
//enum DayEight {
//  static func program(typedInstructions: [Instruction]) -> Int? {
//    print(typedInstructions)
//    
//    var accumulator = 0
//    var index = 0
//    var completedInstructions = Set<Instruction>()
//
//    while(true) {
//      guard (0...typedInstructions.count - 1).contains(index) else { break }
//      let instruction = typedInstructions[index]
//      
//      if completedInstructions.contains(instruction) {
//        print("Duplicate instruction identified. Instruction: \(instruction). Accumulated Value: \(accumulator)")
//        return nil
//      }
//      
//      let output = DayEight.executeInstruction(for: instruction, at: index, with: accumulator)
//      guard let (newIndex, newAccumulated) = output else { break }
//      accumulator = newAccumulated
//      index = newIndex
//      
//      completedInstructions.insert(instruction)
//    }
//    
//    print("Terminated program.")
//    return accumulator
//  }
//  
//  static func createInstructions() -> [Instruction] {
//    return instructions.map { $0.split(separator: " ") }.enumerated().compactMap{
//      guard let operation = Operation(rawValue: String($1.first!)) else { return nil }
//      guard let argument = Int($1.last!) else { return nil }
//      
//      return Instruction(operation: operation, argument: argument, index: $0)
//    }
//  }
//  
//  static func partOne() -> Int {
//    let typedInstructions = createInstructions()
//    DayEight.program(typedInstructions: typedInstructions)
//    
//    return -1
//  }
//  
//  static func changeNextOperation(_ typedInstructions: [Instruction], _ changedIndex: Int) -> ([Instruction], newIndex: Int)? {
//    guard (-1...typedInstructions.count - 1).contains(changedIndex) else { return nil }
//    var newIndex = changedIndex + 1
//    var typedInstructionsCopy = typedInstructions
//    
//    outer: while (0...typedInstructionsCopy.count - 1).contains(newIndex) {
//      let instruction = typedInstructionsCopy[newIndex]
//  
//      switch instruction.operation {
//      case .acc:
//        newIndex += 1
//        continue
//
//      case .nop:
//        typedInstructionsCopy[newIndex] = Instruction(operation: .jmp, argument: instruction.argument, index: instruction.index)
//        break outer
//  
//      case .jmp:
//        typedInstructionsCopy[newIndex] = Instruction(operation: .nop, argument: instruction.argument, index: instruction.index)
//        break outer
//      }
//    }
//    
//    return (typedInstructionsCopy, newIndex)
//  }
//  
//  static func partTwo() -> Int {
//    // jmp -> nop || nop -> jmp
//    let originalInstructions = createInstructions()
//    var modifiedInstructions = originalInstructions
//    var changedIndex = -1
//    
//    while(true) {
//      if let accumulatedValue = DayEight.program(typedInstructions: modifiedInstructions) {
//        print("Program terminated. Accumulated Value: \(accumulatedValue). Index Changed: \(changedIndex)")
//        return accumulatedValue
//      }
//      
//      guard let (newInstructions, newIndex) = changeNextOperation(originalInstructions, changedIndex) else {
//        break
//      }
//      
//      modifiedInstructions = newInstructions
//      changedIndex = newIndex
//    }
//    
//    print("Could not find any operation to change that would terminate the program.")
//    return -1
//  }
//  
//  private static func executeInstruction(for instruction: Instruction, at index: Int, with accumulator: Int) -> (index: Int, accumulated: Int)? {
//    print("Executing instruction \(instruction). Accumulated Value: \(accumulator)")
//    switch instruction.operation {
//    case .acc: return (index + 1, accumulator + instruction.argument)
//    case .jmp: return (index + instruction.argument, accumulator)
//    case .nop: return (index + 1, accumulator)
//    }
//  }
//}
//
//extension DayEight {
//  struct Instruction: Equatable, Hashable, CustomStringConvertible {
//    var description: String {
//      return "\(index) - \(operation): \(argument)"
//    }
//    
//    let operation: Operation
//    let argument: Int
//    let index: Int
//  }
//  
//  enum Operation: String, Equatable {
//    /// acc increases or decreases a single global value called the accumulator by the value given in the argument.
//    /// For example, acc +7 would increase the accumulator by 7. The accumulator starts at 0. After an acc instruction,
//    /// the instruction immediately below it is executed next.
//    case acc
//    
//    /// jmp jumps to a new instruction relative to itself. The next instruction to execute is found using the argument
//    /// as an offset from the jmp instruction; for example, jmp +2 would skip the next instruction, jmp +1 would continue
//    /// to the instruction immediately below it, and jmp -20 would cause the instruction 20 lines above to be executed next.
//    case jmp
//    
//    /// nop stands for No OPeration - it does nothing. The instruction immediately below it is executed next.
//    case nop
//  }
//}
