//********************************* Enumerations **************************************
//Enumeration Syntax
enum CompassPoint {
    case north
    case south
    case east
    case west
}
//Unlike C and Objective-C, Swift enumeration cases are not assigned a default integer value when they are created. In the CompassPoint example above, north, south, east and west do not implicitly equal 0, 1, 2 and 3. Instead, the different enumeration cases are fully-fledged values in their own right, with an explicitly-defined type of CompassPoint.

//Multiple cases can appear on a single line, separated by commas:
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
//Each enumeration definition defines a brand new type. Like other types in Swift, their names (such as CompassPoint and Planet) should start with a capital letter.

var directionToHead = CompassPoint.west
//The type of directionToHead is inferred when it is initialized with one of the possible values of CompassPoint. Once directionToHead is declared as a CompassPoint, you can set it to a different CompassPoint value using a shorter dot syntax:
directionToHead = .east

//Matching Enumeration Values with a Switch Statement
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

//Associated Value
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
//At this point, the original Barcode.upc and its integer values are replaced by the new Barcode.qrCode and its string value. Constants and variables of type Barcode can store either a .upc or a .qrCode (together with their associated values), but they can only store one of them at any given time.

//The different barcode types can be checked using a switch statement, as before. This time, however, the associated values can be extracted as part of the switch statement. You extract each associated value as a constant (with the let prefix) or a variable (with the var prefix) for use within the switch case’s body:
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case .qrCode(let productCode):
    print("QR code: \(productCode)")
}
//If all of the associated values for an enumeration case are extracted as constants, or if all are extracted as variables, you can place a single var or let annotation before the case name, for brevity:
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case let .qrCode(productCode):
    print("QR code: \(productCode)")
}

//Raw Values
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
//Raw values can be strings, characters, or any of the integer or floating-point number types. Each raw value must be unique within its enumeration declaration.

//Implicitly Assigned Raw Values
//When you’re working with enumerations that store integer or string raw values, you don’t have to explicitly assign a raw value for each case. When you don’t, Swift will automatically assign the values for you.

//When integers are used for raw values, the implicit value for each case is one more than the previous case. If the first case doesn’t have a value set, its value is 0.
enum Planet1: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//When strings are used for raw values, the implicit value for each case is the text of that case’s name.
enum CompassPoint1: String {
    case north, south, east, west
}

//You access the raw value of an enumeration case with its rawValue property:
let earthOrder = Planet1.earth.rawValue
let sunsetDirection  = CompassPoint1.west.rawValue

//Initializing from a Raw Value
//If you define an enumeration with a raw-value type, the enumeration automatically receives an initializer that takes a value of the raw value’s type (as a parameter called rawValue) and returns either an enumeration case or nil. You can use this initializer to try to create a new instance of the enumeration.
let possiblePlanet = Planet1(rawValue: 7)
//possiblePlanet is of type Planet? and equals Planet.uranus

let possibleToFind = 11
if let somePlanet = Planet1(rawValue: possibleToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There is not a planet at position \(possibleToFind)")
}

//Recursive Enumerations
//A recursive enumeration is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases. You indicate that an enumeration case is recursive by writing indirect before it, which tells the compiler to insert the necessary layer of indirection.
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

//You can also write indirect before the beginning of the enumeration, to enable indirection for all of the enumeration’s cases that need it:
indirect enum ArithmeticExpression1 {
    case number(Int)
    case addition(ArithmeticExpression1, ArithmeticExpression1)
    case multiplication(ArithmeticExpression1, ArithmeticExpression1)
}
//The code below shows the ArithmeticExpression recursive enumeration being created for (5 + 4) * 2:
let five = ArithmeticExpression1.number(5)
let four = ArithmeticExpression1.number(4)
let sum = ArithmeticExpression1.addition(five, four)
let product = ArithmeticExpression1.multiplication(sum, ArithmeticExpression1.number(2))

//A recursive function is a straightforward way to work with data that has a recursive structure. For example, here’s a function that evaluates an arithmetic expression:
func evaluate(_ expression: ArithmeticExpression1) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))






















