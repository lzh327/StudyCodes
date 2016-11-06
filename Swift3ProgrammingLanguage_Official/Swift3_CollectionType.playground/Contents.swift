//******************************* Collection Types ***************************************

//Swift provides three primary collection types, known as arrays, sets, and dictionaries, for storing collections of values. Arrays are ordered collections of values. Sets are unordered collections of unique values. Dictionaries are unordered collections of key-value associations.

//Arrays, sets, and dictionaries in Swift are always clear about the types of values and keys that they can store. This means that you cannot insert a value of the wrong type into a collection by mistake. It also means you can be confident about the type of values you will retrieve from a collection.

//Mutability of Collections
//If you create an array, a set, or a dictionary, and assign it to a variable, the collection that is created will be mutable. This means that you can change (or mutate) the collection after it is created by adding, removing, or changing items in the collection. If you assign an array, a set, or a dictionary to a constant, that collection is immutable, and its size and contents cannot be changed.


//******************************* Array ***************************************
//Array Type Shorthand Syntax
//The type of a Swift array is written in full as Array<Element>, where Element is the type of values the array is allowed to store. You can also write the type of an array in shorthand form as [Element].

//Creating an Empty Array
var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items.")

//Alternatively, if the context already provides type information, such as a function argument or an already typed variable or constant, you can create an empty array with an empty array literal, which is written as []
someInts.append(3)
// someInts now contains 1 value of type Int
someInts = []
// someInts is now an empty array, but is still of type [Int]

//Creating an Array with a Default Value
var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]

//Creating an Array by Adding Two Arrays Together
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]
var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]

//Creating an Array with an Array Literal
var shoppingList: [String] = ["Eggs", "Milk"]
var shoppingList1 = ["Eggs", "Milk"]

//Accessing and Modifying an Array
//To find out the number of items in an array, check its read-only count property:
print("The shopping list contains \(shoppingList.count) items")

//Use the Boolean isEmpty property as a shortcut for checking whether the count property is equal to 0:
if shoppingList.isEmpty {
    print("The shopping list is empty")
} else {
    print("The shopping list is not empty")
}

//You can add a new item to the end of an array by calling the array’s append(_:) method:
shoppingList.append("Flour")
// shoppingList now contains 3 items

//Alternatively, append an array of one or more compatible items with the addition assignment operator (+=):
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]

//Retrieve a value from the array by using subscript syntax
var firstItem = shoppingList[0]

//You can use subscript syntax to change an existing value at a given index:
shoppingList[0] = "Six eggs"

//You can also use subscript syntax to change a range of values at once, even if the replacement set of values has a different length than the range you are replacing. The following example replaces "Chocolate Spread", "Cheese", and "Butter" with "Bananas" and "Apples":
shoppingList[4...6] = ["Bananas", "Apples"]
//You can’t use subscript syntax to append a new item to the end of an array.

//To insert an item into the array at a specified index, call the array’s insert(_:at:) method:
shoppingList.insert("Maple Syrup", at: 0)
// shoppingList now contains 7 items
// "Maple Syrup" is now the first item in the list

//Similarly, you remove an item from the array with the remove(at:) method. This method removes the item at the specified index and returns the removed item (although you can ignore the returned value if you do not need it):
let mapleSyrup = shoppingList.remove(at: 0)
// the item that was at index 0 has just been removed
// shoppingList now contains 6 items, and no Maple Syrup
// the mapleSyrup constant is now equal to the removed "Maple Syrup" string

//remove the final item from an array
let apples = shoppingList.removeLast()

//Iterating Over an Array
for item in shoppingList {
    print(item)
}

//If you need the integer index of each item as well as its value, use the enumerated() method to iterate over the array instead. For each item in the array, the enumerated() method returns a tuple composed of an integer and the item. The integers start at zero and count up by one for each item; if you enumerate over a whole array, these integers match the items’ indices. You can decompose the tuple into temporary constants or variables as part of the iteration:
for (index, value) in shoppingList.enumerated() {
    print ("Items \(index + 1): \(value)")
}

//******************************* Set ***************************************
//A set stores distinct values of the same type in a collection with no defined ordering. You can use a set instead of an array when the order of items is not important, or when you need to ensure that an item only appears once.

//A type must be hashable in order to be stored in a set—that is, the type must provide a way to compute a hash value for itself. A hash value is an Int value that is the same for all objects that compare equally, such that if a == b, it follows that a.hashValue == b.hashValue.
//All of Swift’s basic types (such as String, Int, Double, and Bool) are hashable by default, and can be used as set value types or dictionary key types. Enumeration case values without associated values     are also hashable by default.

//Set Type Syntax
//The type of a Swift set is written as Set<Element>, where Element is the type that the set is allowed to store. Unlike arrays, sets do not have an equivalent shorthand form.

//Creating and Initializing an Empty Set
var letters = Set<Character>()
print("Letters is of type Set<Character> with \(letters.count) items")

//Alternatively, if the context already provides type information, such as a function argument or an already typed variable or constant, you can create an empty set with an empty array literal:
letters.insert("a")
letters = []

//Creating a Set with an Array Literal
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip Hop"]
//var favoriteGenres: Set = ["Rock", "Classical", "Hip Hop"]

//Accessing and Modifying a Set
//To find out the number of items in a set, check its read-only count property
print("I have \(favoriteGenres.count) favorite music genres.")

//Use the Boolean isEmpty property as a shortcut for checking whether the count property is equal to 0
if favoriteGenres.isEmpty {
    print("As far as music genres, I am not picky.")
} else {
    print("I have particular music preference")
}

//You can add a new item into a set by calling the set’s insert(_:) method
favoriteGenres.insert("Jazz")

//You can remove an item from a set by calling the set’s remove(_:) method, which removes the item if it’s a member of the set, and returns the removed value, or returns nil if the set did not contain it. Alternatively, all items in a set can be removed with its removeAll() method.
if let removedGenres = favoriteGenres.remove("Rock") {
    print("\(removedGenres)? I am over it.")
} else {
    print("I never much cared for that.")
}

//To check whether a set contains a particular item, use the contains(_:) method.
if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It is too funky in here.")
}

//Iterating Over a Set
for genre in favoriteGenres {
    print("\(genre)")
}

//Swift’s Set type does not have a defined ordering. To iterate over the values of a set in a specific order, use the sorted() method, which returns the set’s elements as an array sorted using the < operator.
for genre in favoriteGenres.sorted() {
    print("\(genre)")
}


//Performing Set Operations

//Use the intersection(_:) method to create a new set with only the values common to both sets.
//Use the symmetricDifference(_:) method to create a new set with values in either set, but not both.
//Use the union(_:) method to create a new set with all of the values in both sets.
//Use the subtracting(_:) method to create a new set with values not in the specified set.

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted()
//[]
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
//[1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
// [1, 2, 9]

//Use the “is equal” operator (==) to determine whether two sets contain all of the same values.
//Use the isSubset(of:) method to determine whether all of the values of a set are contained in the specified set.
//Use the isSuperset(of:) method to determine whether a set contains all of the values in a specified set.
//Use the isStrictSubset(of:) or isStrictSuperset(of:) methods to determine whether a set is a subset or superset, but not equal to, a specified set.
//Use the isDisjoint(with:) method to determine whether two sets have any values in common.
let houseAnimals: Set = ["dog", "cat"]
let farmAnimals: Set = ["horse", "chick", "sheep", "dog", "cat"]
let cityAnimals: Set = ["bird", "mouse"]

houseAnimals.isSubset(of: farmAnimals)
//true
farmAnimals.isSuperset(of: houseAnimals)
//true
farmAnimals.isDisjoint(with: cityAnimals)
//true

//******************************* Dictionaries ***************************************
//Dictionary Type Shorthand Syntax
//The type of a Swift dictionary is written in full as Dictionary<Key, Value>, where Key is the type of value that can be used as a dictionary key, and Value is the type of value that the dictionary stores for those keys.
//A dictionary Key type must conform to the Hashable protocol, like a set’s value type.
//You can also write the type of a dictionary in shorthand form as [Key: Value].

//Creating an Empty Dictionary
var namesOfIntegers = [Int: String]()

//If the context already provides type information, you can create an empty dictionary with an empty dictionary literal, which is written as [:] (a colon inside a pair of square brackets):
namesOfIntegers[16] = "sixteen"
namesOfIntegers = [:]

//Creating a Dictionary with a Dictionary Literal
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
//var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

//Accessing and Modifying a Dictionary
//As with an array, you find out the number of items in a Dictionary by checking its read-only count property
print("The airports dictionary contains \(airports.count) items")

//Use the Boolean isEmpty property as a shortcut for checking whether the count property is equal to 0
if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}

//You can add a new item to a dictionary with subscript syntax. Use a new key of the appropriate type as the subscript index, and assign a new value of the appropriate type:
airports["LHR"] = "london"

//You can also use subscript syntax to change the value associated with a particular key:
airports["LHR"] = "London Heathrow"

//As an alternative to subscripting, use a dictionary’s updateValue(_:forKey:) method to set or update the value for a particular key. Like the subscript examples above, the updateValue(_:forKey:) method sets a value for a key if none exists, or updates the value if that key already exists. Unlike a subscript, however, the updateValue(_:forKey:) method returns the old value after performing an update. This enables you to check whether or not an update took place.
//The updateValue(_:forKey:) method returns an optional value of the dictionary’s value type.
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}

//You can also use subscript syntax to retrieve a value from the dictionary for a particular key. Because it is possible to request a key for which no value exists, a dictionary’s subscript returns an optional value of the dictionary’s value type.
if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}

//You can use subscript syntax to remove a key-value pair from a dictionary by assigning a value of nil for that key
airports["APL"] = "Apple International"
airports["APL"] = nil

//Alternatively, remove a key-value pair from a dictionary with the removeValue(forKey:) method. This method removes the key-value pair if it exists and returns the removed value, or returns nil if no value existed:
if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}

//Iterating Over a Dictionary
//You can iterate over the key-value pairs in a dictionary with a for-in loop. Each item in the dictionary is returned as a (key, value) tuple, and you can decompose the tuple’s members into temporary constants or variables as part of the iteration:
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}

//You can also retrieve an iterable collection of a dictionary’s keys or values by accessing its keys and values properties:
for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}

for airportName in airports.values {
    print("Airport name: \(airportName)")
}

//If you need to use a dictionary’s keys or values with an API that takes an Array instance, initialize a new array with the keys or values property
let airportCodes = [String](airports.keys)
// airportCodes is ["YYZ", "LHR"]
let airportNames = [String](airports.values)
// airportNames is ["Toronto Pearson", "London Heathrow"]

//Swift’s Dictionary type does not have a defined ordering. To iterate over the keys or values of a dictionary in a specific order, use the sorted() method on its keys or values property.
































