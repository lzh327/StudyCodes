//  Write some awesome Swift code, or import libraries like "Foundation",
//  "Dispatch", or "Glibc"

import Foundation

print("Hello world!")

//******************* Simple Value ***********************
//Constant and Variable
var myVariable = 42
myVariable = 50
let myConstant = 42

//implicit explicit type
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble : Double = 70
let explicitFloat : Float = 50.5

//Values are never implicitly converted to another type
let lable = "The width is "
let width = 94
let widthLable = lable + String(width)
print(widthLable)

//Write the value in parentheses, and write a backslash (\) before the parentheses.
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples!"
let orangeSummary = "I have \(apples + oranges) pieces of fruit."
print(appleSummary)
print(orangeSummary)


let times = 1
let name = "Li Zhen"
print("Hi \(name), it is the \(times) times you write swift code in sandbox!")

//Array and Dictionary
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"

for shoppingName in shoppingList {
    print(shoppingName)
}

var occupations = ["Malcolm" : "Captain",
                   "kaylee" : "Mechanic",
]

occupations["Jayne"] = "Public Relations"

for (occupationKey, occupationValue) in occupations {
    print("The \(occupationKey) is \(occupationValue)")
}

//Empty Array and Dictionary
let emptyArray = [String]()
let emptyDictionary = [String : Float]()

shoppingList = []
occupations = [:]

//******************* Control Flow ***********************
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)

//The combine of if let statement to work with optional value
var optionalString: String? = "Hello"
print(optionalString == nil)

var optionalName: String? = "John Appleseed"
//optionalName = nil
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
} else {
    greeting = "Hello, friend"
}

print(greeting)


//?? operator
let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"
print(informalGreeting)

//Switch statement
let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich")
case let x where x.hasSuffix("pepper"):
    print("It is a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}


//for in statement
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]

var largest = 0
var largestKind: String!
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            largestKind = kind
        }
    }
}

print(largest)
print(largestKind)

// while, repeat while statement
var n = 2
while n < 100 {
    n = n * 2
}
print(n)

var m = 2
repeat{
    m = m * 2
}while m < 100
print(m)

//range statement ..., ..<.  Use ..< to make a range that omits its upper value, and use ... to make a range that includes both values.
var total = 0
for i in 0..<4 {
    total += i
}
print(total)


//******************* Function and Closures ***********************
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}

print(greet(person: "Bob", day: "Tuesday"))

//Write a custom argument label before the parameter name, or write _ to use no argument label.
func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
print(greet("John", on: "Wednesday"))

//Use a tuple to make a compound value
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int){
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    
    return (min, max, sum)
}

let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)

//Functions can take a variable number of arguments, collecting them into an array.
func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
//sumOf()
var sumNumber = sumOf(numbers: 42, 597, 12)
print(sumNumber)

//Nested functions have access to variables that were declared in the outer function.
func returnFifteen() -> Int {
    var y = 10
    func add(){
        y += 5
    }
    add()
    return y
}

print(returnFifteen())

//Functions are a first-class type. This means that a function can return another function as its value.
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}

var increment = makeIncrementer()
print(increment(7))

//A function can take another function as one of its arguments.
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item){
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}

var numbers = [20, 19, 7, 12]
print(hasAnyMatches(list: numbers, condition: lessThanTen))

//Closures
numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})

//When a closure’s type is already known, such as the callback for a delegate,
//you can omit the type of its parameters, its return type, or both.
//Single statement closures implicitly return the value of their only statement.
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)

//You can refer to parameters by number instead of by name—this approach is especially useful in very short closures.
//A closure passed as the last argument to a function can appear immediately after the parentheses.
//When a closure is the only argument to a function, you can omit the parentheses entirely.
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)

//******************* Objects and Class ***********************
class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()

//init initializer

class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

//Subclasses include their superclass name after their class name, separated by a colon.
//Methods on a subclass that override the superclass’s implementation are marked with override
class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() ->  Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()

//In addition to simple properties that are stored, properties can have a getter and a setter.
//In the setter for perimeter, the new value has the implicit name newValue. You can provide an explicit name in parentheses after set.
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)
triangle.perimeter = 9.9
print(triangle.sideLength)

//Notice that the initializer for the EquilateralTriangle class has three different steps:
//1.Setting the value of properties that the subclass declares.
//2.Calling the superclass’s initializer.
//3.Changing the value of properties defined by the superclass.
//Any additional setup work that uses methods, getters, or setters can also be done at this point.


//If you don’t need to compute the property but still need to provide code that is run before and after setting a new value, use willSet and didSet.
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)

//When working with optional values, you can write ? before operations like methods, properties, and subscripting.
//If the value before the ? is nil, everything after the ? is ignored and the value of the whole expression is nil.
//Otherwise, the optional value is unwrapped, and everything after the ? acts on the unwrapped value.
//In both cases, the value of the whole expression is an optional value.

let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength


//******************* Enumerations and Structures ***********************

//By default, Swift assigns the raw values starting at zero and incrementing by one each time,
//but you can change this behavior by explicitly specifying values.
//You can also use strings or floating-point numbers as the raw type of an enumeration.
//Use the rawValue property to access the raw value of an enumeration case.

enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

let ace = Rank.ace
let aceRawValue = ace.rawValue

//Use the init?(rawValue:) initializer to make an instance of an enumeration from a raw value.
if let convertedRank = Rank(rawValue: 3){
    let threeDescription = convertedRank.simpleDescription()
    print(threeDescription)
}


//The case values of an enumeration are actual values, not just another way of writing their raw values.
// In fact, in cases where there isn’t a meaningful raw value, you don’t have to provide one.

enum Suit {
    case spades, hearts, diamonds, clubs
    
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
    
    func color() -> String {
        switch self {
        case .spades, .clubs:
            return "black color"
        case .hearts, .diamonds:
            return "red color"
        }
    }
}

let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()
print(heartsDescription)
let heartsColor = hearts.color()
print(heartsColor)


//Structures support many of the same behaviors as classes, including methods and initializers.
//One of the most important differences between structures and classes is that structures are always copied when they are passed around in your code,
//but classes are passed by reference.

struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription()) with \(suit.color())"
    }
}

let threeOfSpades = Card(rank: .three, suit: .spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()
print(threeOfSpadesDescription)

//An instance of an enumeration case can have values associated with the instance.
//Instances of the same enumeration case can have different values associated with them.
//You provide the associated values when you create the instance. Associated values and raw values are different:
//The raw value of an enumeration case is the same for all of its instances, and you provide the raw value when you define the enumeration.

enum ServerResponse {
    case result(String, String)
    case failure (String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese")

switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("failure... \(message)")
}


//******************* Protocols and Extensions ***********************

protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class"
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += " Now 100% adjusted."
    }
}

var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription


//Notice the use of the mutating keyword in the declaration of SimpleStructure to mark a method that modifies the structure.
struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}

var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription


//Use extension to add functionality to an existing type, such as new methods and computed properties.
//You can use an extension to add protocol conformance to a type that is declared elsewhere, or even to a type that you imported from a library or framework.

extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    
    mutating func adjust() {
        self += 42
    }
}

print(7.simpleDescription)

//You can use a protocol name just like any other named type—for example, to create a collection of objects that have different types but that all conform to a single protocol. When you work with values whose type is a protocol type, methods outside the protocol definition are not available.

let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
//print(protocolValue.anotherProperty)

//Even though the variable protocolValue has a runtime type of SimpleClass, the compiler treats it as the given type of ExampleProtocol.


//******************* Error Handling ***********************
//You represent errors using any type that adopts the Error protocol.
enum PrinterError: Error {
    case OutofPaper
    case noToner
    case onFire
}

//Use throw to throw an error and throws to mark a function that can throw an error. If you throw an error in a function, the function returns immediately and the code that called the function handles the error.

func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "Job sent"
}

//There are several ways to handle errors. One way is to use do-catch. Inside the do block, you mark code that can throw an error by writing try in front of it. Inside the catch block, the error is automatically given the name error unless you give it a different name.

do {
    let printerResponse = try send(job: 1040, toPrinter: "Never Has Toner")
    print(printerResponse)
} catch {
    print(error)
}

//You can provide multiple catch blocks that handle specific errors. You write a pattern after catch just as you do after case in a switch.

do {
    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
    print(printerResponse)
} catch PrinterError.onFire {
    print("I will just put this over here, with the rest of the fire")
} catch let printerError as PrinterError {//????? not understand
    print("Printer error: \(printerError).")
} catch {
    print(error)
}

//Another way to handle errors is to use try? to convert the result to an optional. If the function throws an error, the specific error is discarded and the result is nil. Otherwise, the result is an optional containing the value that the function returned.

let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")

//Use defer to write a block of code that is executed after all other code in the function, just before the function returns. The code is executed regardless of whether the function throws an error. You can use defer to write setup and cleanup code next to each other, even though they need to be executed at different times.

var fridgeIsOpen = false
let fridgeContent = ["Milk", "eggs", "leftovers"]

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }
    
    let result = fridgeContent.contains(food)
    return result
}

print(fridgeContains("banana"))
print(fridgeIsOpen)

//******************* Generics ***********************

//Write a name inside angle brackets to make a generic function or type.
func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item]{
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}

makeArray(repeating: "knock", numberOfTimes: 4)
makeArray(repeating: 5, numberOfTimes: 4)

//You can make generic forms of functions and methods, as well as classes, enumerations, and structures.
// Reimplement the Swift standard library's optional type
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}

var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)

//Use where right before the body to specify a list of requirements—for example, to require the type to implement a protocol, to require two types to be the same, or to require a class to have a particular superclass.

func anyCommonElements<T:Sequence, U:Sequence>(_ lhs: T, _ rhs: U) -> Bool
    where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
        for lhsItem in lhs {
            for rhsItem in rhs {
                if lhsItem == rhsItem {
                    return true
                }
            }
        }
        return false
}

anyCommonElements([1, 2, 3], [3])
//Writing <T: Equatable> is the same as writing <T> ... where T: Equatable>.






















































