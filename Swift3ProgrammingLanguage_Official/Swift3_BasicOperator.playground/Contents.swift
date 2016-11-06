//*********************************** Basic Operators ********************************************

//Assignment Operator
let b = 10
var a = 5
a = b

//If the right side of the assignment is a tuple with multiple values, its elements can be decomposed into multiple constants or variables at once:

var (x, y) = (1, 2)
// x is equal to 1, and y is equal to 2

//Unlike the assignment operator in C and Objective-C, the assignment operator in Swift does not itself return a value. The following statement is not valid:

//if x = y {
//This is not valid, because x = y does not return a value
//}

//Arithmetic Operators

1 + 2       // equals 3
5 - 3       // equals 2
2 * 3       // equals 6
10.0 / 2.5  // equals 4.0

//Unlike the arithmetic operators in C and Objective-C, the Swift arithmetic operators do not allow values to overflow by default. You can opt in to value overflow behavior by using Swift’s overflow operators (such as a &+ b).

//The addition operator is also supported for String concatenation:
"hello, " + "world"  // equals "hello, world"

//Remainder Operator

9 % 4    // equals 1
-9 % 4   // equals -1
// a % b and a % -b always give the same answer.


//*********************************** Compound Assignment Operators ********************************************

var c = 1
c += 2
print(c)

//*********************************** Comparison Operators ********************************************

//Each of the comparison operators returns a Bool value to indicate whether or not the statement is true:
1 == 1
2 != 1
2 > 1
1 < 2
1 >= 1
2 <= 1

//Swift also provides two identity operators (=== and !==), which you use to test whether two object references both refer to the same object instance.

let name = "world"
if name == "world" {
    print("Hello world")
} else {
    print("I am sorry \(name), but I don't recognize you.")
}


//You can also compare tuples that have the same number of values, as long as each of the values in the tuple can be compared. For example, both Int and String can be compared, which means tuples of the type (Int, String) can be compared. In contrast, Bool can’t be compared, which means tuples that contain a Boolean value can’t be compared.

//Tuples are compared from left to right, one value at a time, until the comparison finds two values that aren’t equal. If all the elements are equal, then the tuples themselves are equal.

(1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" are not compared
(3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
(4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"

//The Swift standard library includes tuple comparison operators for tuples with fewer than seven elements. To compare tuples with seven or more elements, you must implement the comparison operators yourself.

//*********************************** Ternary Conditional Operator ********************************************

//The ternary conditional operator is a special operator with three parts, which takes the form question ? answer1 : answer2.

let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)

//*********************************** Nil-Coalescing Operator ********************************************

//The nil-coalescing operator (a ?? b) unwraps an optional a if it contains a value, or returns a default value b if a is nil. The expression a is always of an optional type. The expression b must match the type that is stored inside a.

//The nil-coalescing operator is shorthand for the code below:
//a != nil ? a! : b

//If the value of a is non-nil, the value of b is not evaluated. This is known as short-circuit evaluation.

let defaultColorName = "red"
var userDefineColorName: String?

var colorNameToUse = userDefineColorName ?? defaultColorName
print(colorNameToUse)

userDefineColorName = "green"
colorNameToUse = userDefineColorName ?? defaultColorName
print(colorNameToUse)

//*********************************** Range Operators ********************************************

for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

let names = ["Anna", "Alex", "Brain", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}

//*********************************** Logical Operators ********************************************

let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}


//If either value is false, the overall expression will also be false. In fact, if the first value is false, the second value won’t even be evaluated, because it can’t possibly make the overall expression equate to true. This is known as short-circuit evaluation.
let enteredDoorCode = true
let passRetinaScan = false
if enteredDoorCode && passRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

//Like the Logical AND operator above, the Logical OR operator uses short-circuit evaluation to consider its expressions. If the left side of a Logical OR expression is true, the right side is not evaluated, because it cannot change the outcome of the overall expression.
let hasDoorkey = false
let knowsOverridePassword = true
if hasDoorkey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

if (enteredDoorCode && passRetinaScan) || hasDoorkey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}









