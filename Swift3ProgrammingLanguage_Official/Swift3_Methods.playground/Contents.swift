//******************************** Methods ***************************************
//Methods are functions that are associated with a particular type. Classes, structures, and enumerations can all define instance methods, which encapsulate specific tasks and functionality for working with an instance of a given type. Classes, structures, and enumerations can also define type methods, which are associated with the type itself. Type methods are similar to class methods in Objective-C.

//******************************** Instance Methods ***************************************
//An instance method has implicit access to all other instance methods and properties of that type.

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

let counter = Counter()
counter.increment()
counter.increment(by: 5)
counter.reset()

//The self Property
//Every instance of a type has an implicit property called self, which is exactly equivalent to the instance itself. You use the self property to refer to the current instance within its own instance methods.
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where is x == 1.0")
}

//Modifying Value Types from Within Instance Methods
//Structures and enumerations are value types. By default, the properties of a value type cannot be modified from within its instance methods.
//However, if you need to modify the properties of your structure or enumeration within a particular method, you can opt in to mutating behavior for that method. The method can then mutate (that is, change) its properties from within the method, and any changes that it makes are written back to the original structure when the method ends. The method can also assign a completely new instance to its implicit self property, and this new instance will replace the existing one when the method ends.
struct MutatePoint {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var someMutatePoint = MutatePoint(x: 1.0, y: 1.0)
someMutatePoint.moveBy(x: 2.0, y: 2.0)
print("The point is now at (\(someMutatePoint.x), \(someMutatePoint.y))")

//Note that you cannot call a mutating method on a constant of structure type, because its properties cannot be changed, even if they are variable properties
let fixedPoint = MutatePoint(x: 3.0, y: 3.0)
//fixedPoint.moveBy(x: 2.0, y: 3.0)
// this will report an error

//Assigning to self Within a Mutating Method
//Mutating methods can assign an entirely new instance to the implicit self property. The Point example shown above could have been written in the following way instead:
struct anotherMutatePoint {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = anotherMutatePoint(x: x + deltaX, y: y + deltaY)
    }
}

//Mutating methods for enumerations can set the implicit self parameter to be a different case from the same enumeration:
enum TriStateSwith {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case . low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwith.low
ovenLight.next()
ovenLight.next()

//******************************** Type Methods ***************************************
//Instance methods, as described above, are methods that are called on an instance of a particular type. You can also define methods that are called on the type itself. These kinds of methods are called type methods. You indicate type methods by writing the static keyword before the method’s func keyword. Classes may also use the class keyword to allow subclasses to override the superclass’s implementation of that method.

//Type methods are called with dot syntax, like instance methods. However, you call type methods on the type, not on an instance of that type.
class SomeClass {
    class func someTypeMethod() {
        //type method implementation goes here
    }
}
SomeClass.someTypeMethod()

//Within the body of a type method, the implicit self property refers to the type itself, rather than an instance of that type. This means that you can use self to disambiguate between type properties and type method parameters, just as you do for instance properties and instance method parameters.

//More generally, any unqualified method and property names that you use within the body of a type method will refer to other type-level methods and properties. A type method can call another type method with the other method’s name, without needing to prefix it with the type name. Similarly, type methods on structures and enumerations can access type properties by using the type property’s name without a type name prefix.

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level){
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}
//Because it’s not necessarily a mistake for code that calls the advance(to:) method to ignore the return value, this function is marked with the @discardableResult attribute.

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(lever: Int) {
        LevelTracker.unlock(lever + 1)
        tracker.advance(to: lever + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complete(lever: 1)
print("highest unlocked lever is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("Lever 6 has not yet been unlocked")
}




















































