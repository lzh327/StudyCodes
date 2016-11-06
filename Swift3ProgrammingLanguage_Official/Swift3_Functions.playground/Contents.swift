//*********************************** Functions ******************************************
//Defining and Calling Functions
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}
print(greet(person: "Anna"))
print(greet(person: "Brain"))

func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))

//********************* Function Parameters and Return Values *****************************
//Functions Without Parameters
func sayHelloWorld() -> String {
    return "Hello World!"
}
print(sayHelloWorld())

//Functions With Multiple Parameters
func greet1(person: String, alreadyGreeted: Bool) -> String{
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet1(person: "Tim", alreadyGreeted: true))

//Functions Without Return Values
func greet2(person: String) {
    print("Hello, \(person)!")
}
greet2(person: "Dave")
//Strictly speaking, this version of the greet(person:) function does still return a value, even though no return value is defined. Functions without a defined return type return a special value of type Void. This is simply an empty tuple, which is written as ().

//The return value of a function can be ignored when it is called:
func printAndCount(string: String) -> Int {
    print(string)
    return string.characters.count
}

func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
printWithoutCounting(string: "hello, world")
//Return values can be ignored, but a function that says it will return a value must always do so. A function with a defined return type cannot allow control to fall out of the bottom of the function without returning a value, and attempting to do so will result in a compile-time error.

//Functions with Multiple Return Values
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [9, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")

//Optional Tuple Return Types
//If the tuple type to be returned from a function has the potential to have “no value” for the entire tuple, you can use an optional tuple return type to reflect the fact that the entire tuple can be nil. You write an optional tuple return type by placing a question mark after the tuple type’s closing parenthesis, such as (Int, Int)? or (String, Int, Bool)?.
//An optional tuple type such as (Int, Int)? is different from a tuple that contains optional types such as (Int?, Int?). With an optional tuple type, the entire tuple is optional, not just each individual value within the tuple.
func minMaxSafe(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty {
        return nil
    }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let bounds = minMaxSafe(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}

//********************* Function Argument Labels and Parameter Names *****************************
//Each function parameter has both an argument label and a parameter name. The argument label is used when calling the function; each argument is written in the function call with its argument label before it. The parameter name is used in the implementation of the function. By default, parameters use their parameter name as their argument label.
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(firstParameterName: 1, secondParameterName: 2)

//Specifying Argument Labels
//You write an argument label before the parameter name, separated by a space:
func someFunction1(argumentLabel parameterName: Int){
    //In the function body, parameterName refers to the argument value
    //for that parameter
}

//Here’s a variation of the greet(person:) function that takes a person’s name and hometown and returns a greeting:
func greet1(person:String, from hometown: String) -> String {
    return "Hello \(person)! Glad you could visit from \(hometown)."
}
print(greet1(person: "Bill", from: "Cupertino"))

//Omitting Argument Labels
//If a parameter has an argument label, the argument must be labeled when you call the function.
//If you don’t want an argument label for a parameter, write an underscore (_) instead of an explicit argument label for that parameter.
func someFunction2(_ firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction2(1, secondParameterName: 2)

//Default Parameter Values
//You can define a default value for any parameter in a function by assigning a value to the parameter after that parameter’s type. If a default value is defined, you can omit that parameter when calling the function.
func someFunction3(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // If you omit the second argument when calling this function, then
    // the value of parameterWithDefault is 12 inside the function body.
}
someFunction3(parameterWithoutDefault: 3, parameterWithDefault: 6)
someFunction3(parameterWithoutDefault: 4)
//Place parameters that have don’t default values at the beginning of a function’s parameter list, before the parameters that have default values.

//Variadic Parameters
//A variadic parameter accepts zero or more values of a specified type. You use a variadic parameter to specify that the parameter can be passed a varying number of input values when the function is called. Write variadic parameters by inserting three period characters (...) after the parameter’s type name.
//The values passed to a variadic parameter are made available within the function’s body as an array of the appropriate type. For example, a variadic parameter with a name of numbers and a type of Double... is made available within the function’s body as a constant array called numbers of type [Double].
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4)
arithmeticMean(3, 8.25, 18.75)
//A function may have at most one variadic parameter.

//In-Out Parameters
//Function parameters are constants by default. Trying to change the value of a function parameter from within the body of that function results in a compile-time error. This means that you can’t change the value of a parameter by mistake. If you want a function to modify a parameter’s value, and you want those changes to persist after the function call has ended, define that parameter as an in-out parameter instead.
//You write an in-out parameter by placing the inout keyword right before a parameter’s type. An in-out parameter has a value that is passed in to the function, is modified by the function, and is passed back out of the function to replace the original value.
//You can only pass a variable as the argument for an in-out parameter. You cannot pass a constant or a literal value as the argument, because constants and literals cannot be modified. You place an ampersand (&) directly before a variable’s name when you pass it as an argument to an in-out parameter, to indicate that it can be modified by the function.
//In-out parameters cannot have default values, and variadic parameters cannot be marked as inout.
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107

swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

//***************************************** Function Types ************************************************
//Every function has a specific function type, made up of the parameter types and the return type of the function.
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
//The type of both of these functions is (Int, Int) -> Int.

func printHelloWorld() {
    print("hello, world")
}
//The type of this function is () -> Void, or “a function that has no parameters, and returns Void.”

//Using Function Types
//You use function types just like any other types in Swift. For example, you can define a constant or variable to be of a function type and assign an appropriate function to that variable:
var mathFunction : (Int, Int) -> Int = addTwoInts
//The addTwoInts(_:_:) function has the same type as the mathFunction variable, and so this assignment is allowed by Swift’s type-checker.
//You can now call the assigned function with the name mathFunction:
print(mathFunction(2, 3))

//A different function with the same matching type can be assigned to the same variable, in the same way as for non-function types:
mathFunction = multiplyTwoInts
print(mathFunction(2, 3))

//As with any other type, you can leave it to Swift to infer the function type when you assign a function to a constant or variable:
let anotherMathFunction = addTwoInts

//Function Types as Parameter Types
func printMathFunction(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathFunction(addTwoInts, 3, 5)

//Function Types as Return Types
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackword(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backword: Bool) -> (Int) -> Int {
    return backword ? stepBackword : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backword: currentValue > 0)
// moveNearerToZero now refers to the stepBackward() function

print("Counting to zero:")
while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}
print("Zero!")

//Nested Functions
//Nested functions are hidden from the outside world by default, but can still be called and used by their enclosing function. An enclosing function can also return one of its nested functions to allow the nested function to be used in another scope.
func chooseStepFunction1(backword: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
    return backword ? stepBackward : stepForward
}

var currentValue1 = -4
let moveNearerToZero1 = chooseStepFunction1(backword: currentValue1 > 0)

while currentValue1 != 0 {
    print("\(currentValue1)...")
    currentValue1 = moveNearerToZero1(currentValue1)
}
print("zero!")


















