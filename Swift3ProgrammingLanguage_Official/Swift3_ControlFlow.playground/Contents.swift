//****************************************** Control Flow **************************************************

//For-In Loops
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
//In the example above, index is a constant whose value is automatically set at the start of each iteration of the loop. As such, index does not have to be declared before it is used. It is implicitly declared simply by its inclusion in the loop declaration, without the need for a let declaration keyword.

//If you don’t need each value from a sequence, you can ignore the values by using an underscore in place of a variable name.
let base = 3
let power = 10
var answer = 1

for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")

let names = ["Anna", "Alex", "Brain", "Jack"]
for name in names {
    print("Hello, \(name)!")
}

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}

//While Loops
//A while loop performs a set of statements until a condition becomes false. These kinds of loops are best used when the number of iterations is not known before the first iteration begins. Swift provides two kinds of while loops:
//while evaluates its condition at the start of each pass through the loop.
//repeat-while evaluates its condition at the end of each pass through the loop.

//while condition {
//    statements
//}

//repeat {
//    statements
//} while condition


//****************************************** Conditional Statements **************************************************
//if

var temperatureFahrenheit = 30
if temperatureFahrenheit <= 32 {
    print("It is very cold. Consider wearing a scarf")
}

temperatureFahrenheit = 40
if temperatureFahrenheit <= 32 {
    print("It is very cold. Consider wearing a scarf")
} else {
    print("It is not that cold. Wear a t-shirt.")
}

temperatureFahrenheit = 90
if temperatureFahrenheit <= 32 {
    print("It is very cold. Consider wearing a scarf")
} else if temperatureFahrenheit >= 86 {
    print("It is really warm, Don't forget to wear sunscreen.")
} else {
    print("It is not that cold. Wear a t-shirt.")
}


//Switch

// switch some value to consider {
// case value 1:
//     respond to value 1
// case value 2,
//      value 3:
//     respond to value 2 or 3
// default:
//     otherwise, do something else
// }

let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}

//No Implicit Fallthrough
//Although break is not required in Swift, you can use a break statement to match and ignore a particular case or to break out of a matched case before that case has completed its execution. 

//The body of each case must contain at least one executable statement. It is not valid to write the following code, because the first case is empty
let anotherCharacter: Character = "a"
switch anotherCharacter {
//case "a":
    //Invalid, the case has an empty body
case "A":
    print("The letter A")
default:
    print("Not the letter A")
}

//To make a switch with a single case that matches both "a" and "A", combine the two values into a compound case, separating the values with commas.
let anotherCharacter1: Character = "a"
switch anotherCharacter1 {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
}
//To explicitly fall through at the end of a particular switch case, use the fallthrough keyword

//Interval Matching
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")

//Tuples
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}

//Value Bindings
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}

//Where
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

//Compound Cases
let someCharacter1: Character = "e"
switch someCharacter1 {
case "a", "e", "i", "o", "u":
    print("\(someCharacter1) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter1) is a consonant")
default:
    print("\(someCharacter1) is not a vowel or a consonant")
}

//Compound cases can also include value bindings. All of the patterns of a compound case have to include the same set of value bindings, and each binding has to get a value of the same type from all of the patterns in the compound case. 
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}
//Both patterns include a binding for distance and distance is an integer in both patterns—which means that the code in the body of the case can always access a value for distance.

//****************************************** Control Transfer Statements **************************************************
//Swift has five control transfer statements: continue, break, fallthrough, return, throw

//Continue
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let characterToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput.characters {
    if characterToRemove.contains(character){
        continue
    } else {
        puzzleOutput.append(character)
    }
}
print(puzzleOutput)

//Break
//Break in a Loop Statement
//When used inside a loop statement, break ends the loop’s execution immediately and transfers control to the first line of code after the loop’s closing brace (}).
//Break in a Switch Statement
//When used inside a switch statement, break causes the switch statement to end its execution immediately and to transfer control to the first line of code after the switch statement’s closing brace (}).
//This behavior can be used to match and ignore one or more cases in a switch statement. 

let numberSymbol: Character = "三"  // Chinese symbol for the number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}

//Fallthrough
//If you need C-style fallthrough behavior, you can opt in to this behavior on a case-by-case basis with the fallthrough keyword. 
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)
//The fallthrough keyword does not check the case conditions for the switch case that it causes execution to fall into. The fallthrough keyword simply causes code execution to move directly to the statements inside the next case (or default case) block, as in C’s standard switch statement behavior.


//Labeled Statements
//A labeled statement is indicated by placing a label on the same line as the statement’s introducer keyword, followed by a colon. Here’s an example of this syntax for a while loop, although the principle is the same for all loops and switch statements:
//
//label name: while condition {
//    statements
//}

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0

gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        // diceRoll will move us to the final square, so the game is over
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        // this is a valid move, so find out its effect
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")

//Early Exit
//A guard statement, like an if statement, executes statements depending on the Boolean value of an expression. You use a guard statement to require that a condition must be true in order for the code after the guard statement to be executed. Unlike an if statement, a guard statement always has an else clause—the code inside the else clause is executed if the condition is not true.

func greet(person: [String: String]){
    guard let name = person["name"] else {
        return
    }
    
    print("Hello \(name)!")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    
    print("I hope the weather is nice in \(location).")
}

greet(person: ["name": "John"])
greet(person: ["name": "Jane", "location": "Beijing"])
//If the guard statement’s condition is met, code execution continues after the guard statement’s closing brace. Any variables or constants that were assigned values using an optional binding as part of the condition are available for the rest of the code block that the guard statement appears in.
//If that condition is not met, the code inside the else branch is executed. That branch must transfer control to exit the code block in which the guard statement appears. It can do this with a control transfer statement such as return, break, continue, or throw, or it can call a function or method that doesn’t return, such as fatalError(_:file:line:).

//Checking API Availability
//You use an availability condition in an if or guard statement to conditionally execute a block of code, depending on whether the APIs you want to use are available at runtime. The compiler uses the information from the availability condition when it verifies that the APIs in that block of code are available.
if #available(iOS 10, macOS 10.12, *) {
    // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
} else {
    // Fall back to earlier iOS and macOS APIs
}
//In its general form, the availability condition takes a list of platform names and versions. You use platform names such as iOS, macOS, watchOS, and tvOS. In addition to specifying major version numbers like iOS 8, you can specify minor versions numbers like iOS 8.3 and macOS 10.10.3. The last argument, *, is required and specifies that on any other platform.
//if #available(platform name version, ..., *) {
//    statements to execute if the APIs are available
//} else {
//    fallback statements to execute if the APIs are unavailable
//}




















