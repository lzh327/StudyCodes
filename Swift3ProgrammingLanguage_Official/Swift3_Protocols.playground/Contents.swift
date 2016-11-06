import Foundation
//*********************************** Protocols *******************************************
//A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol.

//In addition to specifying requirements that conforming types must implement, you can extend a protocol to implement some of these requirements or to implement additional functionality that conforming types can take advantage of.

//*********************************** Protocol Syntax *******************************************
//You define protocols in a very similar way to classes, structures, and enumerations:

// protocol SomeProtocol {
//     // protocol definition goes here
// }

//Custom types state that they adopt a particular protocol by placing the protocol’s name after the type’s name, separated by a colon, as part of their definition. Multiple protocols can be listed, and are separated by commas:

// struct SomeStructure: FirstProtocol, AnotherProtocol {
//     // structure definition goes here
// }

// If a class has a superclass, list the superclass name before any protocols it adopts, followed by a comma:

// class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
//     // class definition goes here
// }

//*********************************** Property Requirements *******************************************
//A protocol can require any conforming type to provide an instance property or type property with a particular name and type. The protocol doesn’t specify whether the property should be a stored property or a computed property—it only specifies the required property name and type. The protocol also specifies whether each property must be gettable or gettable and settable.

//If a protocol requires a property to be gettable and settable, that property requirement cannot be fulfilled by a constant stored property or a read-only computed property. If the protocol only requires a property to be gettable, the requirement can be satisfied by any kind of property, and it is valid for the property to be also settable if this is useful for your own code.

//Property requirements are always declared as variable properties, prefixed with the var keyword. Gettable and settable properties are indicated by writing { get set } after their type declaration, and gettable properties are indicated by writing { get }.

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

//Always prefix type property requirements with the static keyword when you define them in a protocol. This rule pertains even though type property requirements can be prefixed with the class or static keyword when implemented by a class:

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

//Here’s an example of a protocol with a single instance property requirement:
protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")

//*********************************** Method Requirements *******************************************
//Protocols can require specific instance methods and type methods to be implemented by conforming types. These methods are written as part of the protocol’s definition in exactly the same way as for normal instance and type methods, but without curly braces or a method body. Variadic parameters are allowed, subject to the same rules as for normal methods. Default values, however, cannot be specified for method parameters within a protocol’s definition.

//As with type property requirements, you always prefix type method requirements with the static keyword when they are defined in a protocol. This is true even though type method requirements are prefixed with the class or static keyword when implemented by a class:

// protocol SomeProtocol {
//     static func someTypeMethod()
// }

//The following example defines a protocol with a single instance method requirement:
protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here is a random number: \(generator.random())")

print("And another one: \(generator.random())")

//*********************************** Mutating Method Requirements *******************************************
//It is sometimes necessary for a method to modify (or mutate) the instance it belongs to. For instance methods on value types (that is, structures and enumerations) you place the mutating keyword before a method’s func keyword to indicate that the method is allowed to modify the instance it belongs to and any properties of that instance.

//If you define a protocol instance method requirement that is intended to mutate instances of any type that adopts the protocol, mark the method with the mutating keyword as part of the protocol’s definition. This enables structures and enumerations to adopt the protocol and satisfy that method requirement.

//If you mark a protocol instance method requirement as mutating, you do not need to write the mutating keyword when writing an implementation of that method for a class. The mutating keyword is only used by structures and enumerations.

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
// lightSwitch is now equal to .on

//*********************************** initializer Requirements *******************************************
//Protocols can require specific initializers to be implemented by conforming types. You write these initializers as part of the protocol’s definition in exactly the same way as for normal initializers, but without curly braces or an initializer body:

// protocol SomeProtocol {
//     init(someParameter: Int)
// }

//Class Implementations of Protocol Initializer Requirements
//You can implement a protocol initializer requirement on a conforming class as either a designated initializer or a convenience initializer. In both cases, you must mark the initializer implementation with the required modifier:

// class SomeClass: SomeProtocol {
//     required init(someParameter: Int) {
//         //initializr implementation goes here
//     }
// }

//The use of the required modifier ensures that you provide an explicit or inherited implementation of the initializer requirement on all subclasses of the conforming class, such that they also conform to the protocol.

//You do not need to mark protocol initializer implementations with the required modifier on classes that are marked with the final modifier, because final classes cannot be subclassed.

//If a subclass overrides a designated initializer from a superclass, and also implements a matching initializer requirement from a protocol, mark the initializer implementation with both the required and override modifiers:

// protocol SomeProtocol {
//     init()
// }

// class SomeSuperClass {
//     init() {
//         //initializer implementation goes here
//     }
// }

// class SomeSubClass: SomeSuperClass, SomeProtocol {
//     // "required" from SomeProtocol conformance; "override" from SomeSuperClass
//     required override init() {
//         //initializer implementation goes here
//     }
// }

//Failable Initializer Requirements
//Protocols can define failable initializer requirements for conforming types.

//A failable initializer requirement can be satisfied by a failable or nonfailable initializer on a conforming type. A nonfailable initializer requirement can be satisfied by a nonfailable initializer or an implicitly unwrapped failable initializer.

//*********************************** Protocols As Types *******************************************
//Protocols do not actually implement any functionality themselves. Nonetheless, any protocol you create will become a fully-fledged type for use in your code.

// Because it is a type, you can use a protocol in many places where other types are allowed, including:

// As a parameter type or return type in a function, method, or initializer
// As the type of a constant, variable, or property
// As the type of items in an array, dictionary, or other container

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

//*********************************** Delegation *******************************************
//Delegation is a design pattern that enables a class or structure to hand off (or delegate) some of its responsibilities to an instance of another type. This design pattern is implemented by defining a protocol that encapsulates the delegated responsibilities, such that a conforming type (known as a delegate) is guaranteed to provide the functionality that has been delegated. Delegation can be used to respond to a particular action, or to retrieve data from an external source without needing to know the underlying type of that source.

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    var delegate: DiceGameDelegate?
    
    func  play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides) - sides dice")
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

//*********************************** Adding Protocol Conformance with an Extension *******************************************
//You can extend an existing type to adopt and conform to a new protocol, even if you do not have access to the source code for the existing type. Extensions can add new properties, methods, and subscripts to an existing type, and are therefore able to add any requirements that a protocol may demand.

//Existing instances of a type automatically adopt and conform to a protocol when that conformance is added to the instance’s type in an extension.

//For example, this protocol, called TextRepresentable, can be implemented by any type that has a way to be represented as text. This might be a description of itself, or a text version of its current state:
protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

//Any Dice instance can now be treated as TextRepresentable:
let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}

print(game.textualDescription)

//Declaring Protocol Adoption with an Extension
//If a type already conforms to all of the requirements of a protocol, but has not yet stated that it adopts that protocol, you can make it adopt the protocol with an empty extension:

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {}

//Types do not automatically adopt a protocol just by satisfying its requirements. They must always explicitly declare their adoption of the protocol.

//Instances of Hamster can now be used wherever TextRepresentable is the required type:
let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

//*********************************** Collections of Protocol Types *******************************************
//A protocol can be used as the type to be stored in a collection such as an array or a dictionary, as mentioned in Protocols as Types. This example creates an array of TextRepresentable things:

let things: [TextRepresentable] = [game, d12, simonTheHamster]

for thing in things {
    print(thing.textualDescription)
}

//Note that the thing constant is of type TextRepresentable. It is not of type Dice, or DiceGame, or Hamster, even if the actual instance behind the scenes is of one of those types. Nonetheless, because it is of type TextRepresentable, and anything that is TextRepresentable is known to have a textualDescription property, it is safe to access thing.textualDescription each time through the loop.

//*********************************** Protocol Inheritance *******************************************
//A protocol can inherit one or more other protocols and can add further requirements on top of the requirements it inherits. The syntax for protocol inheritance is similar to the syntax for class inheritance, but with the option to list multiple inherited protocols, separated by commas:

// protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
//     //protocol definition goes here
// }

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

print(game.prettyTextualDescription)

//*********************************** Class-Only Protocols *******************************************
//You can limit protocol adoption to class types (and not structures or enumerations) by adding the class keyword to a protocol’s inheritance list. The class keyword must always appear first in a protocol’s inheritance list, before any inherited protocols:
// protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol {
//     //class-only protocol definition goes here
// }

// In the example above, SomeClassOnlyProtocol can only be adopted by class types. It is a compile-time error to write a structure or enumeration definition that tries to adopt SomeClassOnlyProtocol.

//Use a class-only protocol when the behavior defined by that protocol’s requirements assumes or requires that a conforming type has reference semantics rather than value semantics.

//*********************************** Protocol Composition *******************************************
//It can be useful to require a type to conform to multiple protocols at once. You can combine multiple protocols into a single requirement with a protocol composition. Protocol compositions have the form SomeProtocol & AnotherProtocol. You can list as many protocols as you need to, separating them by ampersands (&).

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person1: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

let birthdayPerson = Person1(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

//*********************************** Checking for Protocol Conformance *******************************************
//You can use the is and as operators described in Type Casting to check for protocol conformance, and to cast to a specific protocol. Checking for and casting to a protocol follows exactly the same syntax as checking for and casting to a type:

// The is operator returns true if an instance conforms to a protocol and returns false if it does not.
// The as? version of the downcast operator returns an optional value of the protocol’s type, and this value is nil if the instance does not conform to that protocol.
// The as! version of the downcast operator forces the downcast to the protocol type and triggers a runtime error if the downcast does not succeed.

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415926
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) {
        self.radius = radius
    }
}

class Country: HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
}

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something thar doesn't have an area")
    }
}

//Note that the underlying objects are not changed by the casting process. They continue to be a Circle, a Country and an Animal. However, at the point that they are stored in the objectWithArea constant, they are only known to be of type HasArea, and so only their area property can be accessed.

//*********************************** Optional Protocol Requirements *******************************************
//You can define optional requirements for protocols, These requirements do not have to be implemented by types that conform to the protocol. Optional requirements are prefixed by the optional modifier as part of the protocol’s definition. Optional requirements are available so that you can write code that interoperates with Objective-C. Both the protocol and the optional requirement must be marked with the @objc attribute. Note that @objc protocols can be adopted only by classes that inherit from Objective-C classes or other @objc classes. They can’t be adopted by structures or enumerations.

//When you use a method or property in an optional requirement, its type automatically becomes an optional. For example, a method of type (Int) -> String becomes ((Int) -> String)?. Note that the entire function type is wrapped in the optional, not the method’s return value.

//An optional protocol requirement can be called with optional chaining, to account for the possibility that the requirement was not implemented by a type that conforms to the protocol. You check for an implementation of an optional method by writing a question mark after the name of the method when it is called, such as someOptionalMethod?(someArgument).

//The following example defines an integer-counting class called Counter, which uses an external data source to provide its increment amount. This data source is defined by the CounterDataSource protocol, which has two optional requirements:
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

//Strictly speaking, you can write a custom class that conforms to CounterDataSource without implementing either protocol requirement. They are both optional, after all. Although technically allowed, this wouldn’t make for a very good data source.

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

//Here’s a simple CounterDataSource implementation where the data source returns a constant value of 3 every time it is queried. It does this by implementing the optional fixedIncrement property requirement:

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()

for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

//Here’s a more complex data source called TowardsZeroSource, which makes a Counter instance count up or down towards zero from its current count value:

@objc class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}

//*********************************** Protocol Extensions *******************************************
//Protocols can be extended to provide method and property implementations to conforming types. This allows you to define behavior on protocols themselves, rather than in each type’s individual conformance or in a global function.

//For example, the RandomNumberGenerator protocol can be extended to provide a randomBool() method, which uses the result of the required random() method to return a random Bool value:
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

//By creating an extension on the protocol, all conforming types automatically gain this method implementation without any additional modification.
//let generator = LinearCongruentialGenerator()
print("Here is a random number: \(generator.random())")
print("And here is a random Boolean: \(generator.randomBool())")

//Providing Default Implementations
//You can use protocol extensions to provide a default implementation to any method or computed property requirement of that protocol. If a conforming type provides its own implementation of a required method or property, that implementation will be used instead of the one provided by the extension.

//Protocol requirements with default implementations provided by extensions are distinct from optional protocol requirements. Although conforming types don’t have to provide their own implementation of either, requirements with default implementations can be called without optional chaining.

//For example, the PrettyTextRepresentable protocol, which inherits the TextRepresentable protocol can provide a default implementation of its required prettyTextualDescription property to simply return the result of accessing the textualDescription property:

extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

//Adding Constraints to Protocol Extensions
//When you define a protocol extension, you can specify constraints that conforming types must satisfy before the methods and properties of the extension are available. You write these constraints after the name of the protocol you’re extending using a generic where clause

//For instance, you can define an extension to the Collection protocol that applies to any collection whose elements conform to the TextRepresentable protocol from the example above.

extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map{ $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

// The textualDescription property returns the textual description of the entire collection by concatenating the textual representation of each element in the collection into a comma-separated list, enclosed in brackets.

// Consider the Hamster structure from before, which conforms to the TextRepresentable protocol, and an array of Hamster values:
let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]

//Because Array conforms to Collection and the array’s elements conform to the TextRepresentable protocol, the array can use the textualDescription property to get a textual representation of its contents:
print(hamsters.textualDescription)
// Prints "[A hamster named Murray, A hamster named Morgan, A hamster named Maurice]"

//If a conforming type satisfies the requirements for multiple constrained extensions that provide implementations for the same method or property, Swift will use the implementation corresponding to the most specialized constraints.


