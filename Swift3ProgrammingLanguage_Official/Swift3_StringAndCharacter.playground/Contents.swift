//************************************** Strings and Characters **************************************

import Foundation

let someString = "Some string literal value"

//Initializing an Empty String
var emptyString = ""
var anotherEmptyString = String()

//Find out whether a String value is empty by checking its Boolean isEmpty property:
if emptyString.isEmpty {
    print("Nothing to see here")
}

//String Mutability
var varialbeString = "Horse"
varialbeString += " and carriage"
print(varialbeString)

let constantString = "Highlander"
//constantString += " and another Highlander"
// this reports a compile-time error - a constant string cannot be modified

//This approach is different from string mutation in Objective-C and Cocoa, where you choose between two classes (NSString and NSMutableString) to indicate whether a string can be mutated.

//Strings Are Value Types
//Swift’s String type is a value type. If you create a new String value, that String value is copied when it is passed to a function or method, or when it is assigned to a constant or variable. In each case, a new copy of the existing String value is created, and the new copy is passed or assigned, not the original version.

//Working with Characters
//You can access the individual Character values for a String by iterating over its characters property with a for-in loop
for character in "Student".characters {
    print(character)
}

//Alternatively, you can create a stand-alone Character constant or variable from a single-character string literal by providing a Character type annotation
let exclamationMask: Character = "!"

//String values can be constructed by passing an array of Character values as an argument to its initializer:
let catCharacters: [Character] = ["C", "A", "T", "!"]
let catString = String(catCharacters)
print(catString)

//Concatenating Strings and Characters
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

var instruction = "look over"
instruction += string2

//You can append a Character value to a String variable with the String type’s append() method:
welcome.append(exclamationMask)
print(welcome)
//You can’t append a String or Character to an existing Character variable, because a Character value must contain a single character only.

//String Interpolation
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
print(message)

//Counting Characters
//To retrieve a count of the Character values in a string, use the count property of the string’s characters property:
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")

//Accessing and Modifying a String
//Each String value has an associated index type, String.Index, which corresponds to the position of each Character in the string.
//different characters can require different amounts of memory to store, so in order to determine which Character is at a particular position, you must iterate over each Unicode scalar from the start or end of that String. For this reason, Swift strings cannot be indexed by integer values.
//Use the startIndex property to access the position of the first Character of a String. The endIndex property is the position after the last character in a String. As a result, the endIndex property isn’t a valid argument to a string’s subscript. If a String is empty, startIndex and endIndex are equal.
//You access the indices before and after a given index using the index(before:) and index(after:) methods of String. To access an index farther away from the given index, you can use the index(_:offsetBy:) method instead of calling one of these methods multiple times.
//You can use subscript syntax to access the Character at a particular String index.
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
//G
greeting[greeting.index(before: greeting.endIndex)]
//!
greeting[greeting.index(after: greeting.startIndex)]
//u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]
//a

//Attempting to access an index outside of a string’s range or a Character at an index outside of a string’s range will trigger a runtime error.
//greeting[greeting.endIndex]
//greeting.index(after: greeting.endIndex)

//Use the indices property of the characters property to access all of the indices of individual characters in a string.
for index in greeting.characters.indices {
    print("\(greeting[index])", terminator: "")
}
print("")

//You can use the startIndex and endIndex properties and the index(before:), index(after:), and index(_:offsetBy:) methods on any type that conforms to the Collection protocol. This includes String, as shown here, as well as collection types such as Array, Dictionary, and Set.

//Inserting and Removing
//To insert a single character into a string at a specified index, use the insert(_:at:) method, and to insert the contents of another string at a specified index, use the insert(contentsOf:at:) method.

var welcome1 = "hello"
welcome1.insert("!", at: welcome1.endIndex)
print(welcome1)

welcome1.insert(contentsOf: " there".characters, at: welcome1.index(before: welcome1.endIndex))
print(welcome1)

//To remove a single character from a string at a specified index, use the remove(at:) method, and to remove a substring at a specified range, use the removeSubrange(_:) method:
welcome1.remove(at: welcome1.index(before: welcome1.endIndex))
print(welcome1)

let range = welcome1.index(welcome1.endIndex, offsetBy: -6) ..< welcome1.endIndex
welcome1.removeSubrange(range)
print(welcome1)

//You can use the the insert(_:at:), insert(contentsOf:at:), remove(at:), and removeSubrange(_:) methods on any type that conforms to the RangeReplaceableCollection protocol. This includes String, as shown here, as well as collection types such as Array, Dictionary, and Set.


//Comparing Strings
//Swift provides three ways to compare textual values: string and character equality, prefix equality, and suffix equality.

let quotation = "We are a lot alike, you and I."
let someQuotation = "We are a lot alike, you and I."

if quotation == someQuotation {
    print("These two strings are considered equal")
}

//Prefix and Suffix Equality
//To check whether a string has a particular string prefix or suffix, call the string’s hasPrefix(_:) and hasSuffix(_:) methods, both of which take a single argument of type String and return a Boolean value.

let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1") {
        act1SceneCount += 1
    }
}

print("There are \(act1SceneCount) scenes in Act 1")


var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")















































