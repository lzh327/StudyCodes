//********************************* Closures **********************************
//Closures take one of three forms:
//Global functions are closures that have a name and do not capture any values.
//Nested functions are closures that have a name and can capture values from their enclosing function.
//Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.

//********************************* Closure Expressions **********************************
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backword(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backword)

//Closure Expression Syntax
//Closure expression syntax has the following general form:
//{ (parameters) -> return type in
//    statements
//}
//The parameters in closure expression syntax can be in-out parameters, but they can’t have a default value. Variadic parameters can be used if you name the variadic parameter. Tuples can also be used as parameter types and return types.
reversedNames = names.sorted(by: {(s1: String, s2: String) -> Bool in
    return s1 > s2
})

//Infering Type From Context
reversedNames = names.sorted(by: {s1, s2 in return s1 > s2})
//It is always possible to infer the parameter types and return type when passing a closure to a function or method as an inline closure expression. As a result, you never need to write an inline closure in its fullest form when the closure is used as a function or method argument.

//Implicit Returns from Single-Expression Closures
reversedNames = names.sorted(by: {s1, s2 in s1 > s2})

//Shorthand Argument Names
reversedNames = names.sorted(by: {$0 > $1})

//Operator Methods
reversedNames = names.sorted(by: >)

//********************************* Trailing Closures **********************************
//If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a trailing closure instead. A trailing closure is written after the function call’s parentheses, even though it is still an argument to the function. When you use the trailing closure syntax, you don’t write the argument label for the closure as part of the function call.
func someFunctionThatTakesAClosure(closure: () -> Void) {
    //function body goes here
}
// Here's how you call this function without using a trailing closure:
someFunctionThatTakesAClosure(closure: {
    //closure's body goes here
})
// Here's how you call this function with a trailing closure instead:
someFunctionThatTakesAClosure(){
    // trailing closure's body goes here
}

reversedNames = names.sorted(){$0 > $1}

//If a closure expression is provided as the function or method’s only argument and you provide that expression as a trailing closure, you do not need to write a pair of parentheses () after the function or method’s name when you call the function:
reversedNames = names.sorted {$0 > $1}

let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [16, 58, 510]

let strings = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
// strings is inferred to be of type [String]
// its value is ["OneSix", "FiveEight", "FiveOneZero"]

//********************************* Capturing Values **********************************
//A closure can capture constants and variables from the surrounding context in which it is defined. The closure can then refer to and modify the values of those constants and variables from within its body, even if the original scope that defined the constants and variables no longer exists.

//In Swift, the simplest form of a closure that can capture values is a nested function, written within the body of another function. A nested function can capture any of its outer function’s arguments and can also capture any constants and variables defined within the outer function.
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
//The incrementer() function doesn’t have any parameters, and yet it refers to runningTotal and amount from within its function body. It does this by capturing a reference to runningTotal and amount from the surrounding function and using them within its own function body. Capturing by reference ensures that runningTotal and amount do not disappear when the call to makeIncrementer ends, and also ensures that runningTotal is available the next time the incrementer function is called.

let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()
incrementByTen()
incrementByTen()

let incrementBySeven = makeIncrementer(forIncrement: 7)

incrementBySeven()
incrementBySeven()

incrementByTen()

//If you assign a closure to a property of a class instance, and the closure captures that instance by referring to the instance or its members, you will create a strong reference cycle between the closure and the instance. Swift uses capture lists to break these strong reference cycles.

//********************************* Closures Are Reference Types **********************************
//In the example above, incrementBySeven and incrementByTen are constants, but the closures these constants refer to are still able to increment the runningTotal variables that they have captured. This is because functions and closures are reference types.
//Whenever you assign a function or a closure to a constant or a variable, you are actually setting that constant or variable to be a reference to the function or closure. In the example above, it is the choice of closure that incrementByTen refers to that is constant, and not the contents of the closure itself.
//This also means that if you assign a closure to two different constants or variables, both of those constants or variables will refer to the same closure:
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()

//********************************* Escaping Closures **********************************
//A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. When you declare a function that takes a closure as one of its parameters, you can write @escaping before the parameter’s type to indicate that the closure is allowed to escape.

//One way that a closure can escape is by being stored in a variable that is defined outside the function. As an example, many functions that start an asynchronous operation take a closure argument as a completion handler. The function returns after it starts the operation, but the closure isn’t called until the operation is completed—the closure needs to escape, to be called later. For example:
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
//The someFunctionWithEscapingClosure(_:) function takes a closure as its argument and adds it to an array that’s declared outside the function. If you didn’t mark the parameter of this function with @escaping, you would get a compiler error.

//Marking a closure with @escaping means you have to refer to self explicitly within the closure. For example, in the code below, the closure passed to someFunctionWithEscapingClosure(_:) is an escaping closure, which means it needs to refer to self explicitly. In contrast, the closure passed to someFunctionWithNonescapingClosure(_:) is a nonescaping closure, which means it can refer to self implicitly.

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure{ self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)

//completionHandlers[0]()
//print(instance.x)

//********************************* Autoclosures **********************************
//An autoclosure is a closure that is automatically created to wrap an expression that’s being passed as an argument to a function. It doesn’t take any arguments, and when it’s called, it returns the value of the expression that’s wrapped inside of it. This syntactic convenience lets you omit braces around a function’s parameter by writing a normal expression instead of an explicit closure.
//It’s common to call functions that take autoclosures, but it’s not common to implement that kind of function. For example, the assert(condition:message:file:line:) function takes an autoclosure for its condition and message parameters; its condition parameter is evaluated only in debug builds and its message parameter is evaluated only if condition is false.
//An autoclosure lets you delay evaluation, because the code inside isn’t run until you call the closure. Delaying evaluation is useful for code that has side effects or is computationally expensive, because it lets you control when that code is evaluated. The code below shows how a closure delays evaluation.
var customsInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customsInLine.count)

let customerProvider = {customsInLine.remove(at: 0)}
print(customsInLine.count)

print("Now serving \(customerProvider())!")
print(customsInLine.count)

//Even though the first element of the customersInLine array is removed by the code inside the closure, the array element isn’t removed until the closure is actually called. If the closure is never called, the expression inside the closure is never evaluated, which means the array element is never removed. Note that the type of customerProvider is not String but () -> String—a function with no parameters that returns a string.

//You get the same behavior of delayed evaluation when you pass a closure as an argument to a function.

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: {customsInLine.remove(at: 0)})
//The serve(customer:) function in the listing above takes an explicit closure that returns a customer’s name. The version of serve(customer:) below performs the same operation but, instead of taking an explicit closure, it takes an autoclosure by marking its parameter’s type with the @autoclosure attribute. Now you can call the function as if it took a String argument instead of a closure. The argument is automatically converted to a closure, because the customerProvider parameter’s type is marked with the @autoclosure attribute.

func serve1(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve1(customer: customsInLine.remove(at: 0))
//Overusing autoclosures can make your code hard to understand. The context and function name should make it clear that evaluation is being deferred.

//If you want an autoclosure that is allowed to escape, use both the @autoclosure and @escaping attributes. 
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}

collectCustomerProviders(customsInLine.remove(at: 0))
collectCustomerProviders(customsInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")

for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}































