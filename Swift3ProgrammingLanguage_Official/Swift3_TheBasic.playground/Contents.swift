//********************** Constants and Variables ***************************

//Declaring Constants and Variables
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0

var x = 0.0, y = 0.0, z = 0.0

//Type Annotations
var welcomeMessage: String

welcomeMessage = "Hello"

var red, green, blue: Double

//Naming Constants and Variables
//Constant and variable names cannot contain whitespace characters, mathematical symbols, arrows, private-use (or invalid) Unicode code points, or line- and box-drawing characters. Nor can they begin with a number, although numbers may be included elsewhere within the name.

let pai = 3.1415926
let 你好 = "你好世界"

var friendlyWelcome = "Hello"
friendlyWelcome = "Bonjour"

let languageName = "Swift"
//languageName = "Swift++"

//Printing Constants and Variables
print(friendlyWelcome)
print("The current value of friendlyWelcome is \(friendlyWelcome)")


//Comments

//This is a comment.
/*This is also a comment
 but is writen over multiple lines */

/* This is the start of the first multiline comment.
 /* This is the second, nested multiline comment. */
 This is the end of the first multiline comment. */

//Semicolons
//semicolons are required if you want to write multiple separate statements on a single line
let cat = "cat"; print(cat)

//Integers
let minValue = UInt8.min
let maxValue = UInt8.max

//Floating-Point Numbers
//In situations where either type would be appropriate, Double is preferred.


//Type Safety and Type Inference
let meaningOfLife = 42
// meaningOfLife is inferred to be of type Int
let pi = 3.1415926
// pi is inferred to be of type Double
//Swift always chooses Double (rather than Float) when inferring the type of floating-point numbers.

let anotherPi = 3 + 0.14159
// anotherPi is also inferred to be of type Double

//Numeric Literals
//All of these integer literals have a decimal value of 17:
let decimalInteger = 17
let binaryInteger = 0b10001
let octalInteger = 0o21
let hexadecimalInteger = 0x11

//All of these floating-point literals have a decimal value of 12.1875:
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0


let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

//Numeric Type Conversion
//let cannotBeNegative: UInt8 = -1
// UInt8 cannot store negative numbers, and so this will report an error
//let tooBig: Int8 = Int8.max + 1
// Int8 cannot store a number larger than its maximum value,
// and so this will also report an error

//To convert one specific number type to another, you initialize a new number of the desired type with the existing value.

let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)

//Conversions between integer and floating-point numeric types must be made explicit:
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pii = Double(three) + pointOneFourOneFiveNine
// pii equals 3.14159, and is inferred to be of type Double

let integerPi = Int(pii)
// integerPi equals 3, and is inferred to be of type Int
//Floating-point values are always truncated when used to initialize a new integer value in this way. This means that 4.75 becomes 4, and -3.9 becomes -3.

//********************** Type Aliases ***************************

typealias AudioSample = UInt16

var maxAmplitudeFound = AudioSample.min

//********************** Bool ***************************

let orangesAreOrange = true
let turnipsAreDelicious = false

if turnipsAreDelicious{
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}

let i = 1
if i == 1 {
    //this example will compile successfully
}

//********************** Tuples ***************************
let http404Error = (404, "Not Found")
// http404Error is of type (Int, String), and equals (404, "Not Found")

//You can decompose a tuple’s contents into separate constants or variables, which you then access as usual:
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")

//If you only need some of the tuple’s values, ignore parts of the tuple with an underscore (_) when you decompose the tuple:
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")

//Alternatively, access the individual element values in a tuple using index numbers starting at zero:
print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)")

//You can name the individual elements in a tuple when the tuple is defined:
let http200Status = (statusCode: 200, descroption: "OK")

print("The status code is \(http200Status.statusCode)")
print("The status message is \(http200Status.descroption)")

//********************** Optionals ***************************

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber is inferred to be of type "Int?", or "optional Int"

var serverResponseCode: Int? = 404
serverResponseCode = nil

var surveyAnswer: String?
// surveyAnswer is automatically set to nil

//If Statements and Forced Unwrapping
if convertedNumber != nil {
    print("convertedNumber contains some integer value")
}
//Once you’re sure that the optional does contain a value, you can access its underlying value by adding an exclamation mark (!) to the end of the optional’s name.
if convertedNumber != nil {
    print("convertedNumber has an integet value of \(convertedNumber!).")
}

//Optional Binding

//Write an optional binding for an if statement as follows:
//if let constantName = someOptional {
//    statements
//}

if let actualNumber = Int(possibleNumber) {
    print("\"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("\"\(possibleNumber)\" could not be converted to an integer")
}

//You can use both constants and variables with optional binding. If you wanted to manipulate the value of actualNumber within the first branch of the if statement, you could write if var actualNumber instead, and the value contained within the optional would be made available as a variable rather than a constant.

//You can include as many optional bindings and Boolean conditions in a single if statement as you need to, separated by commas. If any of the values in the optional bindings are nil or any Boolean condition evaluates to false, the whole if statement’s condition is considered to be false. The following if statements are equivalent:
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}

//Constants and variables created with optional binding in an if statement are available only within the body of the if statement. In contrast, the constants and variables created with a guard statement are available in the lines of code that follow the guard statement

//Implicitly Unwrapped Optionals
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation mark

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation mark

//You can still treat an implicitly unwrapped optional like a normal optional, to check if it contains a value:
if assumedString != nil {
    print(assumedString)
}

//You can also use an implicitly unwrapped optional with optional binding, to check and unwrap its value in a single statement:
if let definiteString = assumedString {
    print(definiteString)
}

//Do not use an implicitly unwrapped optional when there is a possibility of a variable becoming nil at a later point. Always use a normal optional type if you need to check for a nil value during the lifetime of a variable.


//********************** Error Handling ***************************

//When a function encounters an error condition, it throws an error. That function’s caller can then catch the error and respond appropriately.
func canThrowAnError() throws {
    // this function may or may not throw an error
}

//A function indicates that it can throw an error by including the throws keyword in its declaration. When you call a function that can throw an error, you prepend the try keyword to the expression.

//Swift automatically propagates errors out of their current scope until they are handled by a catch clause.

do {
    try canThrowAnError()
    // no error was thrown
} catch {
    // an error was thrown
}

//********************** Assertions ***************************

//An assertion is a runtime check that a Boolean condition definitely evaluates to true. Literally put, an assertion “asserts” that a condition is true. You use an assertion to make sure that an essential condition is satisfied before executing any further code. If the condition evaluates to true, code execution continues as usual; if the condition evaluates to false, code execution ends, and your app is terminated.

//You write an assertion by calling the Swift standard library global assert(_:_:file:line:) function. You pass this function an expression that evaluates to true or false and a message that should be displayed if the result of the condition is false:

let age = 4
assert(age >= 0, "A person's age cannot be less than zero")

//In this example, code execution will continue only if age >= 0 evaluates to true, that is, if the value of age is non-negative. If the value of age is negative, as in the code above, then age >= 0 evaluates to false, and the assertion is triggered, terminating the application.

//Assertions are disabled when your code is compiled with optimizations, such as when building with an app target’s default Release configuration in Xcode.



















































































