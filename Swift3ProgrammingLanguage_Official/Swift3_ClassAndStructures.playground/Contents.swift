//*********************************** Classes and Structures *****************************************
//Comparing Classes and Structures
//Classes and structures in Swift have many things in common. Both can:
//Define properties to store values
//Define methods to provide functionality
//Define subscripts to provide access to their values using subscript syntax
//Define initializers to set up their initial state
//Be extended to expand their functionality beyond a default implementation
//Conform to protocols to provide standard functionality of a certain kind

//Classes have additional capabilities that structures do not:
//Inheritance enables one class to inherit the characteristics of another.
//Type casting enables you to check and interpret the type of a class instance at runtime.
//Deinitializers enable an instance of a class to free up any resources it has assigned.
//Reference counting allows more than one reference to a class instance.

//Structures are always copied when they are passed around in your code, and do not use reference counting.

//Definition Syntax
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

//Class and Structure Instances
let someResolution = Resolution()
let someVideoMode = VideoMode()

//Accessing Properties
print("The width of someResolution is \(someResolution.width)")

//You can drill down into sub-properties, such as the width property in the resolution property of a VideoMode:
print("The width of someVideoMode is \(someVideoMode.resolution.width)")

someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")

//Memberwise Initializers for Structure Types
//All structures have an automatically-generated memberwise initializer, which you can use to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name:
let vga = Resolution(width: 640, height: 480)
//Unlike structures, class instances do not receive a default memberwise initializer.

//*********************************** Structures and Enumerations Are Value Types *****************************************
//A value type is a type whose value is copied when it is assigned to a variable or constant, or when it is passed to a function.
//All of the basic types in Swift—integers, floating-point numbers, Booleans, strings, arrays and dictionaries—are value types, and are implemented as structures behind the scenes.
//All structures and enumerations are value types in Swift. This means that any structure and enumeration instances you create—and any value types they have as properties—are always copied when they are passed around in your code.
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
//It then declares a variable called cinema and sets it to the current value of hd. Because Resolution is a structure, a copy of the existing instance is made, and this new copy is assigned to cinema. Even though hd and cinema now have the same width and height, they are two completely different instances behind the scenes.
cinema.width = 2048

print("cinema is now \(cinema.width) pixels wide")
print("hd is still \(hd.width) pixels wide")

enum CompassPoint {
    case north, south, west, east
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection = .east
if rememberedDirection == .west {
    print("The remembered direction is still .west")
}

//*********************************** Classes Are Reference Types *****************************************
//Unlike value types, reference types are not copied when they are assigned to a variable or constant, or when they are passed to a function. Rather than a copy, a reference to the same existing instance is used instead.
let tenEight = VideoMode()
tenEight.resolution = hd
tenEight.interlaced = true
tenEight.name = "1080i"
tenEight.frameRate = 25.0

let alsoTenEight = tenEight
alsoTenEight.frameRate = 30.0
//Because classes are reference types, tenEighty and alsoTenEighty actually both refer to the same VideoMode instance. Effectively, they are just two different names for the same single instance.
print("The frameRate property of tenEight is now \(tenEight.frameRate)")

//Note that tenEight and alsoTenEight are declared as constants, rather than variables. However, you can still change tenEight.frameRate and alsoTenEighty.frmeRate because the values of the tenEighty and alsoTenEighty constants themselves do not actually change. tenEighty and alsoTenEighty themselves do not “store” the VideoMode instance—instead, they both refer to a VideoMode instance behind the scenes. It is the frameRate property of the underlying VideoMode that is changed, not the values of the constant references to that VideoMode.

//Identity Operators
//Because classes are reference types, it is possible for multiple constants and variables to refer to the same single instance of a class behind the scenes. (The same is not true for structures and enumerations, because they are always copied when they are assigned to a constant or variable, or passed to a function.)
// It can sometimes be useful to find out if two constants or variables refer to exactly the same instance of a class. To enable this, Swift provides two identity operators:

// Identical to (===)
// Not identical to (!==)

if tenEight === alsoTenEight {
    print("tenEight and alsoTenEight refer to the same VideoMode instance.")
}
// Note that “identical to” (represented by three equals signs, or ===) does not mean the same thing as “equal to” (represented by two equals signs, or ==):

// “Identical to” means that two constants or variables of class type refer to exactly the same class instance.
// “Equal to” means that two instances are considered “equal” or “equivalent” in value, for some appropriate meaning of “equal”, as defined by the type’s designer.

//Pointers
//If you have experience with C, C++, or Objective-C, you may know that these languages use pointers to refer to addresses in memory. A Swift constant or variable that refers to an instance of some reference type is similar to a pointer in C, but is not a direct pointer to an address in memory, and does not require you to write an asterisk (*) to indicate that you are creating a reference. Instead, these references are defined like any other constant or variable in Swift.

//*********************************** Choosing Between Classes and Structures *****************************************
//Structure instances are always passed by value, and class instances are always passed by reference.

//As a general guideline, consider creating a structure when one or more of these conditions apply:
// The structure’s primary purpose is to encapsulate a few relatively simple data values.
// It is reasonable to expect that the encapsulated values will be copied rather than referenced when you assign or pass around an instance of that structure.
// Any properties stored by the structure are themselves value types, which would also be expected to be copied rather than referenced.
// The structure does not need to inherit properties or behavior from another existing type.

//Examples of good candidates for structures include:
// The size of a geometric shape, perhaps encapsulating a width property and a height property, both of type Double.
// A way to refer to ranges within a series, perhaps encapsulating a start property and a length property, both of type Int.
// A point in a 3D coordinate system, perhaps encapsulating x, y and z properties, each of type Double.

//******************* Assignment and Copy Behavior for Strings, Arrays, and Dictionaries ******************
//In Swift, many basic data types such as String, Array, and Dictionary are implemented as structures. This means that data such as strings, arrays, and dictionaries are copied when they are assigned to a new constant or variable, or when they are passed to a function or method.
//This behavior is different from Foundation: NSString, NSArray, and NSDictionary are implemented as classes, not structures. Strings, arrays, and dictionaries in Foundation are always assigned and passed around as a reference to an existing instance, rather than as a copy.


