//***************************** Generics ********************************
//Generic code enables you to write flexible, reusable functions and types that can work with any type, subject to requirements that you define. You can write code that avoids duplication and expresses its intent in a clear, abstracted manner.

//***************************** The Problem That Generics Solve ********************************
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//You may have noticed that the bodies of the swapTwoInts(_:_:), swapTwoStrings(_:_:), and swapTwoDoubles(_:_:) functions are identical. The only difference is the type of the values that they accept (Int, String, and Double).

//***************************** Generic Functions ********************************
//Generic functions can work with any type. Here’s a generic version of the swapTwoInts(_:_:) function from above, called swapTwoValues(_:_:):

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//The generic version of the function uses a placeholder type name (called T, in this case) instead of an actual type name (such as Int, String, or Double). The placeholder type name doesn’t say anything about what T must be, but it does say that both a and b must be of the same type T, whatever T represents. The actual type to use in place of T will be determined each time the swapTwoValues(_:_:) function is called.

//The other difference is that the generic function’s name (swapTwoValues(_:_:)) is followed by the placeholder type name (T) inside angle brackets (<T>). The brackets tell Swift that T is a placeholder type name within the swapTwoValues(_:_:) function definition. Because T is a placeholder, Swift does not look for an actual type called T.

//The swapTwoValues(_:_:) function can now be called in the same way as swapTwoInts, except that it can be passed two values of any type, as long as both of those values are of the same type as each other. Each time swapTwoValues(_:_:) is called, the type to use for T is inferred from the types of values passed to the function.

var someInt1 = 3
var anotherInt1 = 107
swapTwoValues(&someInt1, &anotherInt1)

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)

//***************************** Type Parameters ********************************
//In the swapTwoValues(_:_:) example above, the placeholder type T is an example of a type parameter. Type parameters specify and name a placeholder type, and are written immediately after the function’s name, between a pair of matching angle brackets (such as <T>).

//Once you specify a type parameter, you can use it to define the type of a function’s parameters, or as the function’s return type, or as a type annotation within the body of the function. In each case, the type parameter is replaced with an actual type whenever the function is called.

//You can provide more than one type parameter by writing multiple type parameter names within the angle brackets, separated by commas.

//***************************** Naming Type Parameters ********************************
//In most cases, type parameters have descriptive names, such as Key and Value in Dictionary<Key, Value> and Element in Array<Element>, which tells the reader about the relationship between the type parameter and the generic type or function it’s used in. However, when there isn’t a meaningful relationship between them, it’s traditional to name them using single letters such as T, U, and V, such as T in the swapTwoValues(_:_:) function above.

//Always give type parameters upper camel case names (such as T and MyTypeParameter) to indicate that they are a placeholder for a type, not a value.

//***************************** Generic Types ********************************
//In addition to generic functions, Swift enables you to define your own generic types. These are custom classes, structures, and enumerations that can work with any type, in a similar way to Array and Dictionary.

//Here’s how to write a non-generic version of a stack, in this case for a stack of Int values:
struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//Here’s a generic version of the same code:
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

//You create a new Stack instance by writing the type to be stored in the stack within angle brackets. For example, to create a new stack of strings, you write Stack<String>():
var stackOfString = Stack<String>()
stackOfString.push("uno")
stackOfString.push("dos")
stackOfString.push("tres")
stackOfString.push("cuatro")

let fromTheTop = stackOfString.pop()

//***************************** Entending a Generic Type ********************************
//When you extend a generic type, you do not provide a type parameter list as part of the extension’s definition. Instead, the type parameter list from the original type definition is available within the body of the extension, and the original type parameter names are used to refer to the type parameters from the original definition.

//The following example extends the generic Stack type to add a read-only computed property called topItem, which returns the top item on the stack without popping it from the stack:
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

//The topItem property returns an optional value of type Element. If the stack is empty, topItem returns nil; if the stack is not empty, topItem returns the final item in the items array.

if let topItem = stackOfString.topItem {
    print("The top item on the stack is \(topItem)")
}

//***************************** Type Constrains ********************************
//The swapTwoValues(_:_:) function and the Stack type can work with any type. However, it is sometimes useful to enforce certain type constraints on the types that can be used with generic functions and generic types. Type constraints specify that a type parameter must inherit from a specific class, or conform to a particular protocol or protocol composition.

//Type Constraint Syntax
//You write type constraints by placing a single class or protocol constraint after a type parameter’s name, separated by a colon, as part of the type parameter list. The basic syntax for type constraints on a generic function is shown below (although the syntax is the same for generic types):

//func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
//    // function body goes here
//}

//The hypothetical function above has two type parameters. The first type parameter, T, has a type constraint that requires T to be a subclass of SomeClass. The second type parameter, U, has a type constraint that requires U to conform to the protocol SomeProtocol.

//Type Constraints in Action
//Here’s a non-generic function called findIndex(ofString:in:), which is given a String value to find and an array of String values within which to find it. The findIndex(ofString:in:) function returns an optional Int value, which will be the index of the first matching string in the array if it is found, or nil if the string cannot be found:

func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
        return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

//Here’s how you might expect a generic version of findIndex(ofString:in:), called findIndex(of:in:), to be written. Note that the return type of this function is still Int?, because the function returns an optional index number, not an optional value from the array. Be warned, though—this function does not compile, for reasons explained after the example:

//func findIndex<T>(of valueToFind: T, in array: [T]) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind {
//            return index
//        }
//    }
//    return nil
//}

//This function does not compile as written above. The problem lies with the equality check, “if value == valueToFind”. Not every type in Swift can be compared with the equal to operator (==). If you create your own class or structure to represent a complex data model, for example, then the meaning of “equal to” for that class or structure is not something that Swift can guess for you. Because of this, it is not possible to guarantee that this code will work for every possible type T, and an appropriate error is reported when you try to compile the code.

//All is not lost, however. The Swift standard library defines a protocol called Equatable, which requires any conforming type to implement the equal to operator (==) and the not equal to operator (!=) to compare any two values of that type. All of Swift’s standard types automatically support the Equatable protocol.

//Any type that is Equatable can be used safely with the findIndex(of:in:) function, because it is guaranteed to support the equal to operator. To express this fact, you write a type constraint of Equatable as part of the type parameter’s definition when you define the function:

func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.23])
// doubleIndex is an optional Int with no value, because 9.3 is not in the array
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcom", "Andrea"])
// stringIndex is an optional Int containing a value of 2

//***************************** Associated Types ********************************
//When defining a protocol, it is sometimes useful to declare one or more associated types as part of the protocol’s definition. An associated type gives a placeholder name to a type that is used as part of the protocol. The actual type to use for that associated type is not specified until the protocol is adopted. Associated types are specified with the associatedtype keyword.

//Associated Types in Action
//Here’s an example of a protocol called Container, which declares an associated type called ItemType:

protocol Container {
    associatedtype ItemType
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

//The Container protocol defines three required capabilities that any container must provide:

//It must be possible to add a new item to the container with an append(_:) method.
//It must be possible to access a count of the items in the container through a count property that returns an Int value.
//It must be possible to retrieve each item in the container with a subscript that takes an Int index value.

//The Container protocol declares an associated type called ItemType, written as associatedtype ItemType. The protocol does not define what ItemType is—that information is left for any conforming type to provide. Nonetheless, the ItemType alias provides a way to refer to the type of the items in a Container, and to define a type for use with the append(_:) method and subscript, to ensure that the expected behavior of any Container is enforced.

//Here’s a version of the non-generic IntStack type from earlier, adapted to conform to the Container protocol:
struct IntStack1: Container {
    //original IntStack implementation
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    //conformance to the Container protocol
    typealias ItemType = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

//Moreover, IntStack specifies that for this implementation of Container, the appropriate ItemType to use is a type of Int. The definition of typealias ItemType = Int turns the abstract type of ItemType into a concrete type of Int for this implementation of the Container protocol.

//Thanks to Swift’s type inference, you don’t actually need to declare a concrete ItemType of Int as part of the definition of IntStack. Because IntStack conforms to all of the requirements of the Container protocol, Swift can infer the appropriate ItemType to use, simply by looking at the type of the append(_:) method’s item parameter and the return type of the subscript. Indeed, if you delete the typealias ItemType = Int line from the code above, everything still works, because it is clear what type should be used for ItemType.

//You can also make the generic Stack type conform to the Container protocol:
struct Stack1<Element>: Container {
    //original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    //conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

//This time, the type parameter Element is used as the type of the append(_:) method’s item parameter and the return type of the subscript. Swift can therefore infer that Element is the appropriate type to use as the ItemType for this particular container.

//Extending an Existing Type to Specify an Associated Type
//You can extend an existing type to add conformance to a protocol. This includes a protocol with an associated type.

//Swift’s Array type already provides an append(_:) method, a count property, and a subscript with an Int index to retrieve its elements. These three capabilities match the requirements of the Container protocol. This means that you can extend Array to conform to the Container protocol simply by declaring that Array adopts the protocol. You do this with an empty extension.

extension Array: Container {}

//Array’s existing append(_:) method and subscript enable Swift to infer the appropriate type to use for ItemType, just as for the generic Stack type above. After defining this extension, you can use any Array as a Container.

//***************************** Generic Where Clauses ********************************
//Type constraints enable you to define requirements on the type parameters associated with a generic function or type.

//It can also be useful to define requirements for associated types. You do this by defining a generic where clause. A generic where clause enables you to require that an associated type must conform to a certain protocol, or that certain type parameters and associated types must be the same. A generic where clause starts with the where keyword, followed by constraints for associated types or equality relationships between types and associated types. You write a generic where clause right before the opening curly brace of a type or function’s body.

//The example below defines a generic function called allItemsMatch, which checks to see if two Container instances contain the same items in the same order. The function returns a Boolean value of true if all items match and a value of false if they do not.

//The two containers to be checked do not have to be the same type of container (although they can be), but they do have to hold the same type of items. This requirement is expressed through a combination of type constraints and a generic where clause:

func allItemMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContain: C2) -> Bool
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
        //check that both containers contain the same number of items
        if someContainer.count != anotherContain.count {
            return false
        }
        //check each pair of items to see if they are equivalent.
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContain[i] {
                return false
            }
        }
        
        //All items match, so return true.
        return true
}

//This function takes two arguments called someContainer and anotherContainer. The someContainer argument is of type C1, and the anotherContainer argument is of type C2. Both C1 and C2 are type parameters for two container types to be determined when the function is called.
//
//The following requirements are placed on the function’s two type parameters:
//
//C1 must conform to the Container protocol (written as C1: Container).
//C2 must also conform to the Container protocol (written as C2: Container).
//The ItemType for C1 must be the same as the ItemType for C2 (written as C1.ItemType == C2.ItemType).
//The ItemType for C1 must conform to the Equatable protocol (written as C1.ItemType: Equatable).

//These requirements enable the allItemsMatch(_:_:) function to compare the two containers, even if they are of a different container type.

var stackOfStrings = Stack1<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemMatch(stackOfStrings, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}




























