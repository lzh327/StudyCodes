//******************************** Initialization *********************************
//Initialization is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that is required before the new instance is ready for use.

//Unlike Objective-C initializers, Swift initializers do not return a value. Their primary role is to ensure that new instances of a type are correctly initialized before they are used for the first time.

//Instances of class types can also implement a deinitializer, which performs any custom cleanup just before an instance of that class is deallocated.

//******************************** Setting Initial Values for Stored Properties *********************************
//Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties cannot be left in an indeterminate state.

//You can set an initial value for a stored property within an initializer, or by assigning a default property value as part of the property’s definition.

//When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any property observers.

//Initializers
//Initializers are called to create a new instance of a particular type. In its simplest form, an initializer is like an instance method with no parameters, written using the init keyword:
//init() {
    // perform some initialization here
//}

struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

var f = Fahrenheit()
print("The default temperature is \(f.temperature) Fahrenheit")

//Default Property Values
//You can set the initial value of a stored property from within an initializer, as shown above. Alternatively, specify a default property value as part of the property’s declaration. You specify a default property value by assigning an initial value to the property when it is defined.

struct FahrenheitDefault {
    var temperature = 32.0
}

//******************************** Customizing Initialization *********************************
//You can customize the initialization process with input parameters and optional property types, or by assigning constant properties during initialization

//Initialization Parameters
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

//Parameter Names and Argument Labels
//As with function and method parameters, initialization parameters can have both a parameter name for use within the initializer’s body and an argument label for use when calling the initializer.

//However, initializers do not have an identifying function name before their parentheses in the way that functions and methods do. Therefore, the names and types of an initializer’s parameters play a particularly important role in identifying which initializer should be called. Because of this, Swift provides an automatic argument label for every parameter in an initializer if you don’t provide one.

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magneta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

//let veryGreen = Color(0.0, 1.0, 0.0)
// this reports a compile-time error - argument labels are required

//Initializer Parameters Without Argument Labels
//If you do not want to use an argument label for an initializer parameter, write an underscore (_) instead of an explicit argument label for that parameter to override the default behavior.
struct CelsiusNew {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit:Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(framKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

let bodyTemperature = CelsiusNew(37.0)

//Optional Property Types
//If your custom type has a stored property that is logically allowed to have “no value”—perhaps because its value cannot be set during initialization, or because it is allowed to have “no value” at some later point—declare the property with an optional type. Properties of optional type are automatically initialized with a value of nil, indicating that the property is deliberately intended to have “no value yet” during initialization.
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese"

//Assigning Constant Properties During Initialization
//You can assign a value to a constant property at any point during initialization, as long as it is set to a definite value by the time initialization finishes. Once a constant property is assigned a value, it can’t be further modified.

//For class instances, a constant property can be modified during initialization only by the class that introduces it. It cannot be modified by a subclass.

class SurveyQuestionConstant {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

let beetsQuestion = SurveyQuestionConstant(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets. (But not with cheese)"

//******************************** Default Initializers *********************************
//Swift provides a default initializer for any structure or class that provides default values for all of its properties and does not provide at least one initializer itself. The default initializer simply creates a new instance with all of its properties set to their default values.

class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}

var item = ShoppingListItem()

//Memberwise Initializers for Structure Types
//Structure types automatically receive a memberwise initializer if they do not define any of their own custom initializers. Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that do not have default values.

struct SizeMemberwise {
    var width = 0.0, height = 0.0
}
let twoByTwo = SizeMemberwise(width: 2.0, height: 2.0)

//******************************** Initializer Delegation for Value Types *********************************
//Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation, avoids duplicating code across multiple initializers.

//The rules for how initializer delegation works, and for what forms of delegation are allowed, are different for value types and class types. Value types (structures and enumerations) do not support inheritance, and so their initializer delegation process is relatively simple, because they can only delegate to another initializer that they provide themselves. Classes, however, can inherit from other classes, this means that classes have additional responsibilities for ensuring that all stored properties they inherit are assigned a suitable value during initialization.

//For value types, you use self.init to refer to other initializers from the same value type when writing your own custom initializers. You can call self.init only from within an initializer.

//Note that if you define a custom initializer for a value type, you will no longer have access to the default initializer (or the memberwise initializer, if it is a structure) for that type. This constraint prevents a situation in which additional essential setup provided in a more complex initializer is accidentally circumvented by someone using one of the automatic initializers.

//If you want your custom value type to be initializable with the default initializer and memberwise initializer, and also with your own custom initializers, write your custom initializers in an extension rather than as part of the value type’s original implementation.

struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

//******************************** Class Inheritance and Initialization *********************************
//All of a class’s stored properties—including any properties the class inherits from its superclass—must be assigned an initial value during initialization.

//Swift defines two kinds of initializers for class types to help ensure all stored properties receive an initial value. These are known as designated initializers and convenience initializers.

//Designated Initializers and Convenience Initializers

//Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.

//Classes tend to have very few designated initializers, and it is quite common for a class to have only one. Designated initializers are “funnel” points through which initialization takes place, and through which the initialization process continues up the superclass chain.

//Every class must have at least one designated initializer. In some cases, this requirement is satisfied by inheriting one or more designated initializers from a superclass

//Convenience initializers are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values. You can also define a convenience initializer to create an instance of that class for a specific use case or input value type.

//You do not have to provide convenience initializers if your class does not require them. Create convenience initializers whenever a shortcut to a common initialization pattern will save time or make initialization of the class clearer in intent.

//Syntax for Designated and Convenience Initializers
//Designated initializers for classes are written in the same way as simple initializers for value types:
//init(parameters) {
//    statements
//}

//Convenience initializers are written in the same style, but with the convenience modifier placed before the init keyword, separated by a space:
//convenience init(parameters) {
//    statements
//}

//Initializer Delegation for Class Types
//To simplify the relationships between designated and convenience initializers, Swift applies the following three rules for delegation calls between initializers:

//Rule 1
//A designated initializer must call a designated initializer from its immediate superclass.
//
//Rule 2
//A convenience initializer must call another initializer from the same class.
//
//Rule 3
//A convenience initializer must ultimately call a designated initializer.
//
//A simple way to remember this is:
//
//Designated initializers must always delegate up.
//Convenience initializers must always delegate across.

//Two-Phase Initialization

//Class initialization in Swift is a two-phase process. In the first phase, each stored property is assigned an initial value by the class that introduced it. Once the initial state for every stored property has been determined, the second phase begins, and each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use.

//Swift’s compiler performs four helpful safety-checks to make sure that two-phase initialization is completed without error:

//Safety check 1
//A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.
//As mentioned above, the memory for an object is only considered fully initialized once the initial state of all of its stored properties is known. In order for this rule to be satisfied, a designated initializer must make sure that all of its own properties are initialized before it hands off up the chain.

//Safety check 2
//A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization.

//Safety check 3
//A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class). If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer.

//Safety check 4
//An initializer cannot call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.

//The class instance is not fully valid until the first phase ends. Properties can only be accessed, and methods can only be called, once the class instance is known to be valid at the end of the first phase.

//Here’s how two-phase initialization plays out, based on the four safety checks above:

//Phase 1
//
//A designated or convenience initializer is called on a class.
//Memory for a new instance of that class is allocated. The memory is not yet initialized.
//A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
//The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
//This continues up the class inheritance chain until the top of the chain is reached.
//Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.

//Phase 2
//
//Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
//Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.

//Initializer Inheritance and Overriding

//Unlike subclasses in Objective-C, Swift subclasses do not inherit their superclass initializers by default. Swift’s approach prevents a situation in which a simple initializer from a superclass is inherited by a more specialized subclass and is used to create a new instance of the subclass that is not fully or correctly initialized.

//If you want a custom subclass to present one or more of the same initializers as its superclass, you can provide a custom implementation of those initializers within the subclass.

//When you write a subclass initializer that matches a superclass designated initializer, you are effectively providing an override of that designated initializer. Therefore, you must write the override modifier before the subclass’s initializer definition. This is true even if you are overriding an automatically provided default initializer

//As with an overridden property, method or subscript, the presence of the override modifier prompts Swift to check that the superclass has a matching designated initializer to be overridden, and validates that the parameters for your overriding initializer have been specified as intended.

//You always write the override modifier when overriding a superclass designated initializer, even if your subclass’s implementation of the initializer is a convenience initializer.

//Conversely, if you write a subclass initializer that matches a superclass convenience initializer, that superclass convenience initializer can never be called directly by your subclass, as per the rules described above in Initializer Delegation for Class Types. Therefore, your subclass is not (strictly speaking) providing an override of the superclass initializer. As a result, you do not write the override modifier when providing a matching implementation of a superclass convenience initializer.

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}
//The Vehicle class provides a default value for its only stored property, and does not provide any custom initializers itself. As a result, it automatically receives a default initializer. The default initializer (when available) is always a designated initializer for a class

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicyle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicyle = Bicyle()
print("Bicyle: \(bicyle.description)")

//Subclasses can modify inherited variable properties during initialization, but can not modify inherited constant properties.

//Automatic Initializer Inheritance
//As mentioned above, subclasses do not inherit their superclass initializers by default. However, superclass initializers are automatically inherited if certain conditions are met. In practice, this means that you do not need to write initializer overrides in many common scenarios, and can inherit your superclass initializers with minimal effort whenever it is safe to do so.

//Assuming that you provide default values for any new properties you introduce in a subclass, the following two rules apply:

//Rule 1
//If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers.
//
//Rule 2
//If your subclass provides an implementation of all of its superclass designated initializers—either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition—then it automatically inherits all of the superclass convenience initializers.

//These rules apply even if your subclass adds further convenience initializers.

//A subclass can implement a superclass designated initializer as a subclass convenience initializer as part of satisfying rule 2.

//Designated and Convenience Initializers in Action

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
//The init(name: String) convenience initializer provided by RecipeIngredient takes the same parameters as the init(name: String) designated initializer from Food. Because this convenience initializer overrides a designated initializer from its superclass, it must be marked with the override modifier

//Even though RecipeIngredient provides the init(name: String) initializer as a convenience initializer, RecipeIngredient has nonetheless provided an implementation of all of its superclass’s designated initializers. Therefore, RecipeIngredient automatically inherits all of its superclass’s convenience initializers too.

//In this example, the superclass for RecipeIngredient is Food, which has a single convenience initializer called init(). This initializer is therefore inherited by RecipeIngredient. The inherited version of init() functions in exactly the same way as the Food version, except that it delegates to the RecipeIngredient version of init(name: String) rather than the Food version.

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem1: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " yes" : " no"
        return output
    }
}
//Because it provides a default value for all of the properties it introduces and does not define any initializers itself, ShoppingListItem1 automatically inherits all of the designated and convenience initializers from its superclass.

//You can use all three of the inherited initializers to create a new ShoppingListItem1 instance:
var breakfastList = [
    ShoppingListItem1(),
    ShoppingListItem1(name: "Bacon"),
    ShoppingListItem1(name: "Eggs", quantity: 6)
]

breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}

//******************************** Failable Initializers *********************************
//It is sometimes useful to define a class, structure, or enumeration for which initialization can fail. This failure might be triggered by invalid initialization parameter values, the absence of a required external resource, or some other condition that prevents initialization from succeeding.

//To cope with initialization conditions that can fail, define one or more failable initializers as part of a class, structure, or enumeration definition. You write a failable initializer by placing a question mark after the init keyword (init?).

//You cannot define a failable and a nonfailable initializer with the same parameter types and names.

//A failable initializer creates an optional value of the type it initializes. You write return nil within a failable initializer to indicate a point at which initialization failure can be triggered.

//Strictly speaking, initializers do not return a value. Rather, their role is to ensure that self is fully and correctly initialized by the time that initialization ends. Although you write return nil to trigger an initialization failure, you do not use the return keyword to indicate initialization success.

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")
// someCreature is of type Animal?, not Animal

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe)")
}

let anonymousCreature = Animal(species: "")
// anonymousCreature is of type Animal?, not Animal
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}

//Failable Initializers for Enumerations
//You can use a failable initializer to select an appropriate enumeration case based on one or more parameters. The initializer can then fail if the provided parameters do not match an appropriate enumeration case.

enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

//Failable Initializers for Enumerations with Raw Values
//Enumerations with raw values automatically receive a failable initializer, init?(rawValue:), that takes a parameter called rawValue of the appropriate raw-value type and selects a matching enumeration case if one is found, or triggers an initialization failure if no matching value exists.

//You can rewrite the TemperatureUnit example from above to use raw values of type Character and to take advantage of the init?(rawValue:) initializer:
enum TemperatureUnitRawValue: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}

let fahrenheitUnit1 = TemperatureUnitRawValue(rawValue: "F")
if fahrenheitUnit1 != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit1 = TemperatureUnitRawValue(rawValue: "X")
if unknownUnit1 == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

//Propagation of Initialization Failure
//A failable initializer of a class, structure, or enumeration can delegate across to another failable initializer from the same class, structure, or enumeration. Similarly, a subclass failable initializer can delegate up to a superclass failable initializer.

//In either case, if you delegate to another initializer that causes initialization to fail, the entire initialization process fails immediately, and no further initialization code is executed.

//A failable initializer can also delegate to a nonfailable initializer. Use this approach if you need to add a potential failure state to an existing initialization process that does not otherwise fail.

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem(name: "sock", quantity: 2){
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}

if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}

//Overriding a Failable Initializer
//You can override a superclass failable initializer in a subclass, just like any other initializer. Alternatively, you can override a superclass failable initializer with a subclass nonfailable initializer. This enables you to define a subclass for which initialization cannot fail, even though initialization of the superclass is allowed to fail.

//Note that if you override a failable superclass initializer with a nonfailable subclass initializer, the only way to delegate up to the superclass initializer is to force-unwrap the result of the failable superclass initializer.

//You can override a failable initializer with a nonfailable initializer but not the other way around.

class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init(){}
    // this initializer creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

//You can use forced unwrapping in an initializer to call a failable initializer from the superclass as part of the implementation of a subclass’s nonfailable initializer. For example, the UntitledDocument subclass below is always named "[Untitled]", and it uses the failable init(name:) initializer from its superclass during initialization.
class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}
//In this case, if the init(name:) initializer of the superclass were ever called with an empty string as the name, the forced unwrapping operation would result in a runtime error. However, because it’s called with a string constant, you can see that the initializer won’t fail, so no runtime error can occur in this case.

//The init! Failable Initializer
//You typically define a failable initializer that creates an optional instance of the appropriate type by placing a question mark after the init keyword (init?). Alternatively, you can define a failable initializer that creates an implicitly unwrapped optional instance of the appropriate type. Do this by placing an exclamation mark after the init keyword (init!) instead of a question mark.

//You can delegate from init? to init! and vice versa, and you can override init? with init! and vice versa. You can also delegate from init to init!, although doing so will trigger an assertion if the init! initializer causes initialization to fail.

//******************************** Required Initializers *********************************
//Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer:

class SomeClass {
    required init() {
        // initializer implementation goes here
    }
}

//You must also write the required modifier before every subclass implementation of a required initializer, to indicate that the initializer requirement applies to further subclasses in the chain. You do not write the override modifier when overriding a required designated initializer:

class SomeSubclass: SomeClass {
    required init() {
        // subclass implementation of the required initializer goes here
    }
}

//You do not have to provide an explicit implementation of a required initializer if you can satisfy the requirement with an inherited initializer.

//********************* Setting a Default Property Value with a Closure or Function ************************
//If a stored property’s default value requires some customization or setup, you can use a closure or global function to provide a customized default value for that property. Whenever a new instance of the type that the property belongs to is initialized, the closure or function is called, and its return value is assigned as the property’s default value.

//These kinds of closures or functions typically create a temporary value of the same type as the property, tailor that value to represent the desired initial state, and then return that temporary value to be used as the property’s default value.

//Here’s a skeleton outline of how a closure can be used to provide a default property value:
//class AnotherSomeClass {
//    let someProperty: SomeType = {
//        // create a default value for someProperty inside this closure
//        // someValue must be of the same type as SomeType
//        return someValue
//    }()
//}

//Note that the closure’s end curly brace is followed by an empty pair of parentheses. This tells Swift to execute the closure immediately. If you omit these parentheses, you are trying to assign the closure itself to the property, and not the return value of the closure.

//If you use a closure to initialize a property, remember that the rest of the instance has not yet been initialized at the point that the closure is executed. This means that you cannot access any other property values from within your closure, even if those properties have default values. You also cannot use the implicit self property, or call any of the instance’s methods.

//The example below defines a structure called Chessboard, which models a board for the game of chess. Chess is played on an 8 x 8 board, with alternating black and white squares.
//To represent this game board, the Chessboard structure has a single property called boardColors, which is an array of 64 Bool values. A value of true in the array represents a black square and a value of false represents a white square. The first item in the array represents the top left square on the board and the last item in the array represents the bottom right square on the board.
struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

//Whenever a new Chessboard instance is created, the closure is executed, and the default value of boardColors is calculated and returned. 

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
print(board.squareIsBlackAt(row: 7, column: 7))





















