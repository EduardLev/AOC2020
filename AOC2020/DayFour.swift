import Foundation
/////// DAY FOUR

extension Decodable {
  init(from: Any) throws {
    let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
    let decoder = JSONDecoder()
    self = try decoder.decode(Self.self, from: data)
  }
}

// byr (Birth Year) - four digits; at least 1920 and at most 2002.
// iyr (Issue Year) - four digits; at least 2010 and at most 2020.
// eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
// hgt (Height) - a number followed by either cm or in:
// If cm, the number must be at least 150 and at most 193.
// If in, the number must be at least 59 and at most 76.
// hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
// ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
// pid (Passport ID) - a nine-digit number, including leading zeroes.
// cid (Country ID) - ignored, missing or not.

struct PotentialPassport: Decodable {
  let byr: String
  let iyr: String
  let eyr: String
  let hgt: String
  let hcl: String
  let ecl: String
  let pid: String
  let cid: String?
}

struct PassportID {
  let value: String
  
  init?(_ value: String) {
    guard value.count == 9, value.unicodeScalars.filter(CharacterSet.decimalDigits.contains).count == 9 else { return nil }
    
    self.value = value
  }
}

struct HairColor {
  let hex: String

  init?(_ value: String) {
    guard value.first == "#" else { return nil }
    
    let hexDigit = String(value.dropFirst()).filter(\.isHexDigit)
    guard hexDigit.count == 6 else { return nil }
    
    self.hex = hexDigit
  }
}

enum EyeColor: String {
  case amber = "amb"
  case blue = "blu"
  case brn = "brn"
  case gry = "gry"
  case green = "grn"
  case hazel = "hzl"
  case other = "oth"
}

struct Height {
  let height: Int
  let dimension: Dimension
  
  enum Dimension: String {
    case centimeters = "cm"
    case inches = "in"
  }
  
  init?(_ value: String) {
    let heightValue = value.unicodeScalars.filter(CharacterSet.decimalDigits.contains)
    let dimensionValue = value.unicodeScalars.filter { !CharacterSet.decimalDigits.contains($0) }
    
    guard let dimension = Dimension(rawValue: String(dimensionValue)) else { return nil }
    guard let height = Int(String(heightValue)) else { return nil }
    
    switch dimension {
    case .centimeters:
      guard (150...193).contains(height) else { return nil }
    case .inches:
      guard (59...76).contains(height) else { return nil }
    }
    
    self.height = height
    self.dimension = dimension
  }
}

struct Year {
  let year: Int
  let type: YearType
  
  enum YearType {
    case birth
    case issue
    case expiration
  }
  
  init?(_ value: String, _ type: YearType) {
    guard (value.count == 4), let year = Int(value) else { return nil }
    switch type {
    case .birth: guard (1920...2002).contains(year) else { return nil }
    case .issue: guard (2010...2020).contains(year) else { return nil }
    case .expiration: guard (2020...2030).contains(year) else { return nil }
    }
    
    self.year = year
    self.type = type
  }
}

struct ValidPassport {
  let byr: Year
  let iyr: Year
  let eyr: Year
  let hgt: Height
  let hcl: HairColor
  let ecl: EyeColor
  let pid: PassportID
  let cid: String?
  
  init?(byr: Year?, iyr: Year?, eyr: Year?, hgt: Height?, hcl: HairColor?, ecl: EyeColor?, pid: PassportID?, cid: String?) {
    guard let byr = byr, let iyr = iyr, let eyr = eyr, let hgt = hgt, let hcl = hcl, let ecl = ecl, let pid = pid else { return nil }
    self.byr = byr
    self.iyr = iyr
    self.eyr = eyr
    self.hgt = hgt
    self.hcl = hcl
    self.ecl = ecl
    self.pid = pid
    self.cid = cid
    
  }
}

enum DayFour {
  static func partOne() -> Int {
    let passports: [PotentialPassport] = instructions.compactMap {
      do { return try PotentialPassport(from: $0) } catch { return nil }
    }
    return passports.count
  }
  
  static func partTwo() -> Int {
    let potentialPassports: [PotentialPassport] = instructions.compactMap {
      do { return try PotentialPassport(from: $0) } catch { return nil }
    }
    
    let validPassports: [ValidPassport] = potentialPassports.compactMap {
      return ValidPassport(
        byr: Year($0.byr, .birth),
        iyr: Year($0.iyr, .issue),
        eyr: Year($0.eyr, .expiration),
        hgt: Height($0.hgt),
        hcl: HairColor($0.hcl),
        ecl: EyeColor(rawValue: $0.ecl),
        pid: PassportID($0.pid),
        cid: $0.cid
      )
    }
    
    return validPassports.count
  }
}

