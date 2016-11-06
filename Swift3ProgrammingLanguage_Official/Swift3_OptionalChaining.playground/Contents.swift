//******************************************** Optional Chaining ************************************************
//Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil. If the optional contains a value, the property, method, or subscript call succeeds; if the optional is nil, the property, method, or subscript call returns nil. Multiple queries can be chained together, and the entire chain fails gracefully if any link in the chain is nil.

//Optional chaining in Swift is similar to messaging nil in Objective-C, but in a way that works for any type, and that can be checked for success or failure.

//Optional Chaining as an Alternative to Forced Unwrapping
//You specify optional chaining by placing a question mark (?) after the optional value on which you wish to call a property, method or subscript if the optional is non-nil. This is very similar to placing an exclamation mark (!) after an optional value to force the unwrapping of its value. The main difference is that optional chaining fails gracefully when the optional is nil, whereas forced unwrapping triggers a runtime error when the optional is nil.

//To reflect the fact that optional chaining can be called on a nil value, the result of an optional chaining call is always an optional value, even if the property, method, or subscript you are querying returns a nonoptional value. You can use this optional return value to check whether the optional chaining call was successful (the returned optional contains a value), or did not succeed due to a nil value in the chain (the returned optional value is nil).

//Specifically, the result of an optional chaining call is of the same type as the expected return value, but wrapped in an optional. A property that normally returns an Int will return an Int? when accessed through optional chaining.

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRoom = 1
}

let john = Person()

//let roomCount = john.residence!.numberOfRoom
//this triggers a runtime error

if let roomCount = john.residence?.numberOfRoom {
    print("John's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms")
}

//Because the attempt to access numberOfRooms has the potential to fail, the optional chaining attempt returns a value of type Int?, or “optional Int”. When residence is nil, as in the example above, this optional Int will also be nil, to reflect the fact that it was not possible to access numberOfRooms. The optional Int is accessed through optional binding to unwrap the integer and assign the nonoptional value to the roomCount variable.

//Note that this is true even though numberOfRooms is a nonoptional Int. The fact that it is queried through an optional chain means that the call to numberOfRooms will always return an Int? instead of an Int.

john.residence = Residence()

//john.residence now contains an actual Residence instance, rather than nil. If you try to access numberOfRooms with the same optional chaining as before, it will now return an Int? that contains the default numberOfRooms value of 1:
if let roomCount = john.residence?.numberOfRoom {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "John's residence has 1 room(s)."

//Defining Model Classes for Optional Chaining
//You can use optional chaining with calls to properties, methods, and subscripts that are more than one level deep. This enables you to drill down into subproperties within complex models of interrelated types, and to check whether it is possible to access properties, methods, and subscripts on those subproperties.

class Person1 {
    var residence: Residence1?
}

class Residence1 {
    var rooms = [Room]()
    var numberOfRoom: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRoom(){
        print("The number of rooms is \(numberOfRoom)")
    }
    
    var address: Address?
}

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String? {
        if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

//Accessing Properties Through Optional Chaining
let mike = Person1()
if let roomCount = mike.residence?.numberOfRoom {
    print("Mike's residence has \(roomCount) rooms")
} else {
    print("Unable to retrieve the number of rooms")
}

//You can also attempt to set a property’s value through optional chaining:
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
mike.residence?.address = someAddress
//In this example, the attempt to set the address property of john.residence will fail, because john.residence is currently nil.

//The assignment is part of the optional chaining, which means none of the code on the right hand side of the = operator is evaluated. In the previous example, it’s not easy to see that someAddress is never evaluated, because accessing a constant doesn’t have any side effects. The listing below does the same assignment, but it uses a function to create the address. The function prints “Function was called” before returning a value, which lets you see whether the right hand side of the = operator was evaluated.
func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}
mike.residence?.address = createAddress()

//Calling Methods Through Optional Chaining
//You can use optional chaining to call a method on an optional value, and to check whether that method call is successful. You can do this even if that method does not define a return value.

//The printNumberOfRooms() method on the Residence class prints the current value of numberOfRooms. Here’s how the method looks:

//func printNumberOfRooms() {
//    print("The number of rooms is \(numberOfRooms)")
//}
//This method does not specify a return type. However, functions and methods with no return type have an implicit return type of Void, as described in Functions Without Return Values. This means that they return a value of (), or an empty tuple.

//If you call this method on an optional value with optional chaining, the method’s return type will be Void?, not Void, because return values are always of an optional type when called through optional chaining.
if mike.residence?.printNumberOfRoom() != nil {
    print("It was possible to print the number of rooms")
} else {
    print("It was not possible to print the number of rooms")
}

//The same is true if you attempt to set a property through optional chaining. The example above in Accessing Properties Through Optional Chaining attempts to set an address value for mike.residence, even though the residence property is nil. Any attempt to set a property through optional chaining returns a value of type Void?, which enables you to compare against nil to see if the property was set successfully:
if (mike.residence?.address = someAddress) != nil {
    print("It was possible to set the address")
} else {
    print("It was not possible to set the address")
}

//Accessing Subscripts Through Optional Chaining
//You can use optional chaining to try to retrieve and set a value from a subscript on an optional value, and to check whether that subscript call is successful.

//When you access a subscript on an optional value through optional chaining, you place the question mark before the subscript’s brackets, not after. The optional chaining question mark always follows immediately after the part of the expression that is optional.

if let firstRoomName = mike.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name")
}

//Similarly, you can try to set a new value through a subscript with optional chaining:
mike.residence?[0] = Room(name: "Bathroom")
//This subscript setting attempt also fails, because residence is currently nil.

let mikeHouse =  Residence1()
mikeHouse.rooms.append(Room(name: "Living Room"))
mikeHouse.rooms.append(Room(name: "Kitchen"))
mike.residence = mikeHouse

if let firstRoomName = mike.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name")
}

//Accessing Subscripts of Optional Type
//If a subscript returns a value of optional type—such as the key subscript of Swift’s Dictionary type—place a question mark after the subscript’s closing bracket to chain on its optional return value:
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brain"]?[0] = 72

//Linking Multiple Levels of Chaining
//You can link together multiple levels of optional chaining to drill down to properties, methods, and subscripts deeper within a model. However, multiple levels of optional chaining do not add more levels of optionality to the returned value.

//To put it another way:
//
//If the type you are trying to retrieve is not optional, it will become optional because of the optional chaining.
//If the type you are trying to retrieve is already optional, it will not become more optional because of the chaining.

//Therefore:
//
//If you try to retrieve an Int value through optional chaining, an Int? is always returned, no matter how many levels of chaining are used.
//Similarly, if you try to retrieve an Int? value through optional chaining, an Int? is always returned, no matter how many levels of chaining are used.

if let mikesStreet = mike.residence?.address?.street {
    print("Mike's street name is \(mikesStreet)")
} else {
    print("Unable to retrieve the address")
}

let mikesAddress = Address()
mikesAddress.buildingName = "The Larches"
mikesAddress.street = "Laurel Street"
mike.residence?.address = mikesAddress

if let mikesStreet = mike.residence?.address?.street {
    print("Mike's street name is \(mikesStreet)")
} else {
    print("Unable to retrieve the address")
}

//Chaining on Methods with Optional Return Values
//The previous example shows how to retrieve the value of a property of optional type through optional chaining. You can also use optional chaining to call a method that returns a value of optional type, and to chain on that method’s return value if needed.

if let buildingIdentifier = mike.residence?.address?.buildingIdentifier() {
    print("Mike's building identifier is \(buildingIdentifier)")
}

if let beginsWithThe = mike.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("Mike's building identifier begins with \"The\".")
    } else {
        print("Mike's building identifier does not begin with \"The\".")
    }
}



























