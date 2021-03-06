//:## Arrays
//:### Arrays and Mutablility
import UIKit

let fibs = [0, 1, 1, 2, 3, 5]

var mutableFibs = [0, 1, 1, 2, 3, 5]

mutableFibs.append(8)
mutableFibs.append(contentsOf: [13, 21])
mutableFibs

//: Arrays have value semantics. When you assign an existing array to another variable, the array contents are copied over. For example, in the following code snippet, x is never modified
var x = [1,2,3]
var y = x
y.append(4)
y
x

//: Contrast this with the approach to mutability taken by NSArray in Foundation. NSArray has no mutating methods — to mutate an array, you need an NSMutableArray. But just because you have a non-mutating NSArray reference does not mean the array can’t be mutated underneath you:
let a = NSMutableArray(array: [1,2,3])
let b: NSArray = a

a.insert(4, at: 3)
b

//: The correct way to write this is to manually create a copy upon assignment:
let c = NSMutableArray(array: [1,2,3])
let d = c.copy() as! NSArray
c.insert(4, at: 3)
d

//:### Array and Optionals
/*:
 Swift arrays provide all the usual operations you’d expect, like isEmpty and count. Arrays also allow for direct access of elements at a specific index through subscripting, like  bs[3]. Keep in mind that you need to make sure the index is within bounds before getting an element via subscript. Fetch the element at index 3, and you’d better be sure the array has at least four elements in it. Otherwise, your program will trap, i.e. abort with a fatal error.
 
 The reason for this is mainly driven by how array indices are used. It’s pretty rare in Swift to actually need to calculate an index:
- Want to iterate over the array? --for x in array
- Want to iterate over all but the first element of an array? --for x in array.dropFirst()
- Want to iterate over all but the last 5 lements? --for x in array.dropLast(5)
- Want to number all the elements in an array? --for (num, element) in collection.enumerated()
- Want to find the location of a specific element? --if let idx = array.index { someMatchingLogic($0) }
- Want to transform all the elements in an array? --array.map { someTransformation($0) }
- Want to fetch only the elements matching a specific criterion? --array.filter { someCriteria($0) }
 
 The *first* and *last* properties return an optional; they return *nil* if the array is empty. *first* is equivalent to *isEmpty ? nil : self[0]*. Similarly, the *removeLast* method will trap if you call it on an empty array, whereas *popLast* will only delete and return the last element if the array isn’t empty and otherwise do nothing and return nil. Which one you’d want to use depends on your use case. When you’re using the array as a stack, you’ll probably always want to combine checking for *empty* and removing the last entry. On the other hand, if you already know through invariants whether or not the array is empty, dealing with the optional is fiddly.
 */

//:### Transforming Arrays
//:#### Map
//: It’s common to need to perform a transformation on every value in an array. Every programmer has written similar code hundreds of times: create a new array, loop over all elements in an existing array, perform an operation on an element, and append the result of that operation to the new array. For example, the following code squares an array of integers:
var squared: [Int] = []
for fib in fibs {
    squared.append(fib * fib)
}
squared

//: Swift arrays have a map method, adopted from the world of functional programming. Here’s the exact same operation, using map:
let squares = fibs.map {fib in fib * fib}
squares

//: *map* isn’t hard to write — it’s just a question of wrapping up the boilerplate parts of the *for* loop into a generic function. Here’s one possible implementation (though in Swift, it’s actually an extension of Sequence, something we’ll cover in the chapter on writing generic algorithms):
extension Array {
    func map<T>(_ transform: (Element) -> T) -> [T] {
        var result: [T] = []
        result.reserveCapacity(count)
        for x in self {
            result.append(transform(x))
        }
        return result
    }
}

//: Really, the signature of this method should be *func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]*, indicating that map will forward any error the transformation function might throw to the caller. We’ll cover this in detail in the errors chapter. We’ve left the error handling annotations out here for simplicity. If you’d like, you can check out the source code for Sequence.map in the Swift repository on GitHub.

//:#### Parameterizing Behavior with Functions
/*:
 *map* manages to separate out the boilerplate — which doesn’t vary from call to call — from the functionality that always varies: the logic of how exactly to transform each element. It does this through a parameter the caller supplies: the transformation function.
 
 This pattern of parameterizing behavior is found throughout the standard library. There are more than a dozen separate functions that take a closure that allows the caller to customize the key step:
 
 * map and flatMap — how to transform an element
 * filter — should an element be included?
 * reduce — how to fold an element into an aggregate value
 * sequence — what should the next element of the sequence be?
 * forEach — what side effect to perform with an element
 * sort,lexicographicallyPrecedes,and partition — in what order should two elements come?
 * index, first, and contains — does this element match?
 * min and max — which is the min/max of two elements?
 * elementsEqual and starts — are two elements equivalent?
 * split — is this element a separator?
 
 The goal of all these functions is to get rid of the clutter of the uninteresting parts of the code, such as the creation of a new array, the for loop over the source data, and the like. Instead, the clutter is replaced with a single word that describes what’s being done. This brings the important code – the logic the programmer wants to express – to the forefront.
 
 Several of these functions have a default behavior. sort sorts elements in ascending order when they’re comparable, unless you specify otherwise. contains can take a value to check for, so long as the elements are equatable. These help make the code even more readable. Ascending order sort is natural, so the meaning of *array.sort()* is intuitive. *array.index(of: "foo")* is clearer than *array.index { $0 == "foo" }*.
 
 But in every instance, these are just shorthand for the common cases. Elements don’t have to be comparable or equatable, and you don’t have to compare the whole element — you can sort an array of people by their ages (*people.sort { $0.age < $1.age }*) or check if the array contains anyone underage (*people.contains { $0.age < 18 }*). You can also compare some transformation of the element. For example, an admittedly inefficient case-insensitive sort could be performed via *people.sort { $0.name.uppercased() < $1.name.uppercased() }*.
 
 There are other functions of similar usefulness that would also take a closure to specify their behaviors but aren’t in the standard library. You could easily define them yourself (and might like to try):
 
 * accumulate — combine elements into an array of running values(like reduce,but returning an array of each interim combination)
 * all(matching:) and none(matching:) — test if all or no elements in a sequence match a criterion (can be built with contains, with some carefully placed negation)
 * count(where:) — count the number of elements that match(similar to filter, but without constructing an array)
 * indices(where:) — return a list of indices matching a criteria(similar to index(where:), but doesn’t stop on the first one)
 * prefix(while:) — filter elements while a predicate returns true,then drop the rest (similar to filter, but with an early exit, and useful for infinite or lazily computed sequences)
 * drop(while:) — drop elements until the predicate ceases to be true,and then return the rest (similar to prefix(while:), but this returns the inverse)
 */

//: You might find yourself writing something that fits a pattern more than a couple of times — something like this, where you search an array in reverse order for the first element that matches a certain condition:
let names = ["Paula", "Elena", "Zoe"]

var lastNameEndingInA: String?
for name in names.reversed() where name.hasSuffix("a") {
    lastNameEndingInA = name
    break
}
lastNameEndingInA

//: If that’s the case, consider writing a short extension to Sequence. The method *last(where:)* wraps this logic — we use a closure to abstract over the part of our for loop that varies:
extension Sequence {
    func last(where predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
        for element in reversed() where predicate(element) {
            return element
        }
        return nil
    }
}

let match = names.last {$0.hasSuffix("a")}
match

//: It also works nicely with guard — in all likelihood, you’re going to terminate a flow early if the element isn’t found:
//guard let match = someSequence.last(where: { $0.passesTest() }) else { return }
// Do something with match

//:#### Mutation and Stateful Closures
//: When iterating over an array, you could use map to perform side effects (e.g. inserting the elements into some lookup table). We don’t recommend doing this. Take a look at the following:
// array.map { item in
// table.insert(item)
// }

//: This hides the side effect (the mutation of the lookup table) in a construct that looks like a transformation of the array. If you ever see something like the above, then it’s a clear case for using a plain *for* loop instead of a function like *map*. The *forEach* method would also be more appropriate than *map* in this case, but it has its own issues. We’ll look at *forEach* in a bit.

//: Performing side effects is different than deliberately giving the closure local state, which is a particularly useful technique, and it’s what makes closures — functions that can capture and mutate variables outside their scope — so powerful a tool when combined with higher-order functions. For example, the accumulate function described above could be implemented with map and a stateful closure, like this:
extension Array {
    func accumulate<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return map{ next in
            running = nextPartialResult(running, next)
            return running
        }
    }
}

//: This creates a temporary variable to store the running value and then uses map to create an array of the running value as it progresses:
[1,2,3,4].accumulate(0, +)

//: Note that this code assumes that map performs its transformation in order over the sequence. In the case of our map above, it does. But there are possible implementations that could transform the sequence out of order — for example, one that performs the transformation of the elements concurrently. The official standard library version of map doesn’t specify whether or not it transforms the sequence in order, though it seems like a safe bet.

//:#### Filter
let nums = [1,2,3,4,5,6,7,8,9,10]
let newNums = nums.filter{num in num % 2 == 0}
newNums

//: We can use Swift’s shorthand notation for arguments of a closure expression to make this even shorter. Instead of naming the num argument, we can write the above code like this:

nums.filter {$0 % 2 == 0}

//: By combining map and  lter, we can easily write a lot of operations on arrays without having to introduce a single intermediate array, and the resulting code will become shorter and easier to read. For example, to find all squares under 100 that are even, we could map the range 0..<10 in order to square it, and then filter out all odd numbers:
(1..<10).map{$0 * $0}.filter{$0 % 2 == 0}

//: The implementation of filter looks much the same as map:
extension Array {
    func filter(_ isInclude: (Element) -> Bool) -> [Element] {
        var result: [Element] = []
        for x in self where isInclude(x) {
            result.append(x)
        }
        return result
    }
}

//: One quick performance tip: if you ever find yourself writing something like the following, stop!
// bigArray.filter { someCondition }.count > 0
//: filter creates a brand new array and processes every element in the array. But this is unnecessary. This code only needs to check if one element matches — in which case, contains(where:) will do the job:
// bigArray.contains { someCondition }
//: This is much faster for two reasons: it doesn’t create a whole new array of the filtered elements just to count them, and it exits early, as soon as it matches the first element. Generally, only ever use filter if you want all the results.

//: Often you want to do something that can be done by contains, but it looks pretty ugly. For example, you can check if every element of a sequence matches a predicate using *!sequence.contains { !condition }*, but it’s much more readable to wrap this in a new function that has a more descriptive name:
extension Sequence {
    public func all(matching predicate: (Iterator.Element) -> Bool) -> Bool {
        //Every element matches a predicate if no element doesn't match it:
        return !contains{!predicate($0)}
    }
}

let evenNums = nums.filter{$0 % 2 == 0}
evenNums.all {$0 % 2 == 0}

//:#### Reduce
//: Both map and filter take an array and produce a new, modified array. Sometimes, however, you want to combine all elements into a new value. For example, to sum up all the elements, we could write the following code:
var total = 0
for num in fibs {
    total = total + num
}
total

//: The reduce method takes this pattern and abstracts two parts: the initial value (in this case, zero), and the function for combining the intermediate value (total) and the element (num). Using reduce, we can write the same example like this:
let sum = fibs.reduce(0) {total, num in total + num}
sum

//: Operators are functions too, so we could’ve also written the same example like this:
fibs.reduce(0, +)

//: The output type of reduce doesn’t have to be the same as the element type. For example, if we want to convert a list of integers into a string, with each number followed by a space, we can do the following:
fibs.reduce("") {str, num in str + "\(num)"}

//: Here’s the implementation for reduce:
extension Array {
    func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> Result {
        var result = initialResult
        for x in self {
            result = nextPartialResult(result, x)
        }
        return result
    }
}

//: Another performance tip: reduce is very flexible, and it’s common to see it used to build arrays and perform other operations. For example, you can implement map and filter using only reduce:
extension Array {
    func map2<T>(_ transform: (Element) -> T) -> [T] {
        return reduce([]){
            $0 + [transform($1)]
        }
    }
    
    func filter2(_ isIncluded: (Element) -> Bool) -> [Element] {
        return reduce([]) {
            isIncluded($1) ? $0 + [$1] : $0
        }
    }
}

//:#### A Flattening Map
//: Sometimes, you want to map an array where the transformation function returns another array and not a single element. For example, let’s say we have a function, links, which reads a Markdown file and returns an array containing the URLs of all the links in the file. The function type looks like this:
// func extractLinks(markdownFile: String) -> [URL]

//: If we have a bunch of Markdown files and want to extract the links from all files into a single array, we could try to write something like *markdownFiles.map(extractLinks)*. But this returns an array of arrays containing the URLs: one array per file. Now you could just perform the map, get back an array of arrays, and then call joined to flatten the results into a single array:

//let markdownFiles: [String] = // ...
//let nestedLinks = markdownFiles.map(extractLinks)
//let links = nestedLinks.joined()

//: The *flatMap* method combines these two operations into a single step. So *markdownFiles.flatMap(extractLinks)* returns all the URLs in an array of Markdown files as a single array.

//: The implementation for flatMap is almost identical to map, except it takes function argument that returns an array. It uses *append(contentsOf:)* instead of *append(_:)* to flatten the results when appending:
extension Array {
    func flatMap<T>(_ transform: (Element) -> [T]) -> [T] {
        var result: [T] = []
        for x in self {
            result.append(contentsOf: transform(x))
        }
        return result
    }
}

//: Another great use case for flatMap is combining elements from different arrays. To get all possible pairs of two arrays, flatMap over one array and then map over the other:
let suits = ["♠", "♥", "♣", "♦"]
let ranks = ["J","Q","K","A"]

let result = suits.flatMap { suit in
    ranks.map { rank in
        (suit, rank)
    }
}

//:#### Iteration using forEach
//: It works almost like a for loop: the passed-in function is executed once for each element in the sequence. And unlike map, forEach doesn’t return anything. Let’s start by mechanically replacing a loop with forEach:
for element in [1,2,3] {
    print(element)
}

[1,2,3].forEach{ element in
    print(element)
}

[1,2,3].forEach{ print($0) }

//: This isn’t a big win, but it can be handy if the action you want to perform is a single function call on each element in a collection. Passing a function name to forEach instead of a closure expression can lead to clear and concise code. For example, if you’re inside a view controller and want to add an array of subviews to the main view, you can just do *theViews.forEach(view.addSubview)*.

//: However, there are some subtle differences between for loops and forEach. For instance, if a for loop has a return statement in it, rewriting it with forEach can significantly change the code’s behavior. Consider the following example, which is written using a for loop with a where condition:
extension Array where Element: Equatable {
    func index(of element: Element) -> Int? {
        for idx in self.indices where self[idx] == element {
            return idx
        }
        return nil
    }
}

//: We can’t directly replicate the where clause in the forEach construct, so we might (incorrectly) rewrite this using filter:
extension Array where Element: Equatable {
    func index_foreach(of element: Element) -> Int? {
        self.indices.filter{ idx in
            self[idx] == element
            }.forEach{ idx in
                return idx
        }
        return nil
    }
}

//: The return inside the forEach closure doesn’t return out of the outer function; it only returns from the closure itself. In this particular case, we’d probably have found the bug because the compiler generates a warning that the argument to the return statement is unused, but you shouldn’t rely on it finding every such issue.

//: Also, consider the following simple example:
(1..<10).forEach{ number in
    print(number)
    if number > 2 {return}
}
//: It’s not immediately obvious that this prints out all the numbers in the input range. The return statement isn’t breaking the loop, rather it’s returning from the closure.

//:### Array Types
//:#### Slice
//: In addition to accessing a single element of an array by subscript (e.g.  bs[0]), we can also access a range of elements by subscript. For example, to get all but the first element of an array, we can do the following:
let slice = fibs[1..<fibs.endIndex]
slice
type(of: slice)

//: This gets us a slice of the array starting at the second element, including the last element. The type of the result is *ArraySlice*, not Array. ArraySlice is a view on arrays. It’s backed by the original array, yet it provides a view on just the slice. This makes certain the array doesn’t need to get copied. The ArraySlice type has the same methods defined as Array does, so you can use them as if they were arrays. If you do need to convert them into an array, you can just construct a new array out of the slice:
Array(fibs[1..<fibs.endIndex])

//:![arraySlice](arraySlice.png)

//:#### Bridging
//: Swift arrays can bridge to Objective-C. They can also be used with C, but we’ll cover that in a later chapter. Because NSArray can only hold objects, there used to be a requirement that the elements of a Swift array had to be convertible to AnyObject in order for it to be bridgeable. This constrained the bridging to class instances and a small number of value types (such as Int, Bool, and String) that supported automatic bridging to their Objective-C counterparts.

//: This limitation no longer exists in Swift 3. The Objective-C id type is now imported into Swift as Any instead of AnyObject, which means that any Swift array is now bridgeable to NSArray. NSArray still always expects objects, of course, so the compiler and runtime will automatically wrap incompatible values in an opaque box class behind the scenes. Unwrapping in the reverse direction also happens automatically.

//: A universal bridging mechanism for all Swift types to Objective-C doesn’t just make working with arrays more pleasant. It also applies to other collections, like dictionaries and sets, and it opens up a lot of potential for future enhancements to the interoperability between Swift and Objective-C. For example, now that Swift values can be bridged to Objective-C objects, a future Swift version could conceivably allow Swift value types to conform to @objc protocols.

//:## Dictionaries
//: Another key data structure in Swift is Dictionary. A dictionary contains keys with corresponding values; duplicate keys aren’t supported. Retrieving a value by its key takes constant time on average, whereas searching an array for a particular element grows linearly with the array’s size. Unlike arrays, dictionaries aren’t ordered. The order in which pairs are enumerated in a for loop is undefined.

//: In the following example, we use a dictionary as the model data for a fictional settings screen in a smartphone app. The screen consists of a list of settings, and each individual setting has a name (the keys in our dictionary) and a value. A value can be one of several data types, such as text, numbers, or booleans. We use an enum with associated values to model this:
enum Setting {
    case text(String)
    case int(Int)
    case bool(Bool)
}

let defaultSettings: [String : Setting] = [
    "Airplane Mode" : .bool(true),
    "Name" : .text("My iPhone"),
]

defaultSettings["Name"] //Optional(Setting.text("My iPhone"))

//: We use subscripting to get the value of a setting (for example, defaultSettings["Name"]). Dictionary lookup always returns an optional value. When the specified key doesn’t exist, it returns nil. Contrast this with arrays, which respond to an out-of-bounds access by crashing the program.

//: The rationale for this difference is that array indices and dictionary keys are used very differently. We’ve already seen that it’s quite rare that you actually need to work with array indices directly. And if you do, an array index is usually directly derived from the array in some way (e.g. from a range like 0..<array.count); thus, using an invalid index is a programmer error. On the other hand, it’s very common for dictionary keys to come from some source other than the dictionary itself.

//:### Mutation
//: Just like with arrays, dictionaries defined using let are immutable: no entries can be added, removed, or changed. And just like with arrays, we can define a mutable variant using var. To remove a value from a dictionary, we can either set it to nil using subscripting or call *removeValue(forKey:)*. The latter additionally returns the deleted value, or nil if the key didn’t exist. If we want to take an immutable dictionary and make changes to it, we have to make a copy:
var localizedSettings = defaultSettings
localizedSettings["Name"] = .text("Mein iPhone")
localizedSettings["Do Not Disturb"] = .bool(true)

//: Note that, again, the value of *defaultSettings* didn’t change. As with key removal, an alternative to updating via subscript is the *updateValue(_:forKey:)* method, which returns the previous value (if any):
let oldName = localizedSettings.updateValue(.text("Il mio iPhone"), forKey: "Name")
localizedSettings["Name"]
oldName

//:### Some Useful Dictionary Extensions
//: What if we wanted to combine the default settings dictionary with any custom settings the user has changed? Custom settings should override defaults, but the resulting dictionary should still include default values for any keys that haven’t been customized. Essentially, we want to merge two dictionaries, where the dictionary that’s being merged in overwrites duplicate keys. The standard library doesn’t include a function for this, so let’s write one.

//: We can extend Dictionary with a merge method that takes the key-value pairs to be merged in as its only argument. We could make this argument another Dictionary, but this is a good opportunity for a more generic solution. Our requirements for the argument are that it must be a sequence we can loop over, and the sequence’s elements must be key-value pairs of the same type as the receiving dictionary. Any Sequence whose *Iterator.Element* is a *(Key, Value)* pair meets these requirements, so that’s what the method’s generic constraints should express (Key and Value here are the generic type parameters of the Dictionary type we’re extending):
extension Dictionary {
    mutating func merge<S>(_ other: S) where S: Sequence, S.Iterator.Element == (key: Key, value: Value) {
        for (k,v) in other {
            self[k] = v
        }
    }
}

//: We can use this to merge one dictionary into another, as shown in the following example, but the method argument could just as well be an array of key-value pairs or any other sequence:
var settings = defaultSettings
let overriddenSettings: [String : Setting] = ["Name": .text("Jane's iPhone")]
settings.merge(overriddenSettings)
settings

//: Another interesting extension is creating a dictionary from a sequence of (Key, Value) pairs. The standard library provides a similar initializer for arrays that comes up very frequently; you use it every time you create an array from a range (*Array(1...10)*) or convert an ArraySlice back into a proper array (*Array(someSlice)*). However, there’s no such initializer for Dictionary.

//: We can start with an empty dictionary and then just merge in the sequence. This makes use of the *merge* method defined above to do the heavy lifting:
extension Dictionary {
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Key, value: Value) {
        self = [:]
        self.merge(sequence)
    }
}

// All alarms are turned off by default
let defaultAlarms = (1..<5).map{(key: "Alarm \($0)", value: false)}
let alarmsDictionary = Dictionary(defaultAlarms)

//: A third useful extension is a map over the dictionary’s values. Because Dictionary is a Sequence, it already has a map method that produces an array. However, sometimes we want to keep the dictionary structure intact and only transform its values. Our *mapValues* method first calls the standard map to create an array of *(key, transformed value)* pairs and then uses the new initializer we defined above to turn it back into a dictionary:
extension Dictionary {
    func mapValues<NewValue>(transform: (Value) -> NewValue) -> [Key: NewValue] {
        return Dictionary<Key, NewValue>(map{(key, value) in
            return (key, transform(value))
        })
    }
}

let settingsAsStrings = settings.mapValues{setting -> String in
    switch setting {
    case .text(let text):
        return text
    case .int(let number):
        return String(number)
    case .bool(let value):
        return String(value)
    }
}

settingsAsStrings

//:### Hashable Requirement
//: Dictionaries are hash tables. The dictionary assigns each key a position in its underlying storage array based on the key’s hashValue. This is why Dictionary requires its Key type to conform to the Hashable protocol. All the basic data types in the standard library already do, including strings, integers, floating-point, and Boolean values. Enumerations without associated values also get automatic Hashable conformance for free.

//: If you want to use your own custom types as dictionary keys, you must add Hashable conformance manually. This requires an implementation of the hashValue property and, because Hashable extends Equatable, an overload of the == operator function for your type. Your implementation must hold an important invariant: two instances that are equal (as defined by your == implementation) must have the same hash value. The reverse isn’t true: two instances with the same hash value don’t necessarily compare equally. This makes sense, considering that there’s only a finite number of distinct hash values, while many hashable types (like strings) have essentially infinite cardinality.

//: The potential for duplicate hash values means that Dictionary must be able to handle collisions. Nevertheless, a good hash function should strive for a minimal number of collisions in order to preserve the collection’s performance characteristics, i.e. the hash function should produce a uniform distribution over the full integer range. In the extreme case where your implementation returns the same hash value (e.g. zero) for every instance, a dictionary’s lookup performance degrades to O(n).

//: The second characteristic of a good hash function is that it’s fast. Keep in mind that the hash value is computed every time a key is inserted, removed, or looked up. If your hashValue implementation takes too much time, it might eat up any gains you got from the O(1) complexity.

//: Writing a good hash function that meets these requirements isn’t easy. For types that are composed of basic data types that are Hashable themselves, XOR’ing the members’ hash values can be a good starting point:
struct Person {
    var name: String
    var zipCode: Int
    var birthday: Date
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.zipCode == rhs.zipCode && lhs.birthday == rhs.birthday
    }
}

extension Person: Hashable {
    var hashValue: Int {
        return name.hashValue ^ zipCode.hashValue ^ birthday.hashValue
    }
}

//: One limitation of this technique is that XOR is symmetric (i.e. a ^ b == b ^ a), which, depending on the characteristics of the data being hashed, could make collisions more likely than necessary. You can add a bitwise rotation to the mix to avoid this.

//: Finally, be extra careful when you use types that don’t have value semantics(e.g. mutable objects) as dictionary keys. If you mutate an object after using it as a dictionary key in a way that changes its hash value and/or equality, you’ll not be able to find it again in the dictionary. The dictionary now stores the object in the wrong slot, effectively corrupting its internal storage. This isn’t a problem with value types because the key in the dictionary doesn’t share your copy’s storage and therefore can’t be mutated from the outside.

//:## Sets
//: The third major collection type in the standard library is Set. A set is an unordered collection of elements, with each element appearing only once. You can essentially think of a set as a dictionary that only stores keys and no values. Like Dictionary, Set is implemented with a hash table and has similar performance characteristics and requirements. Testing a value for membership in the set is a constant-time operation, and set elements must be Hashable, just like dictionary keys.

//: Use a set instead of an array when you need to test efficiently for membership (an O(n) operation for arrays) and the order of the elements is not important, or when you need to ensure that a collection contains no duplicates.

//: Set conforms to the ExpressibleByArrayLiteral protocol, which means that we can initialize it with an array literal like this:
let naturals: Set = [1,2,3,2]
naturals
naturals.contains(3)
naturals.contains(0)

//: Like all collections, sets support the common operations we’ve already seen: you can iterate over the elements in a for loop, map or  lter them, and do all other sorts of things.

//:### Set Algebra
//: Set is closely related to the mathematical concept of a set; it supports all common set operations you learned in math class. For example, we can subtract one set from another:
let iPods: Set = ["iPod touch", "iPod nano", "iPod mini", "iPod shuffle", "iPod Classic"]
let discontinuedIPods: Set = ["iPod mini", "iPod Classic"]
let currentIPods = iPods.subtracting(discontinuedIPods)

//: We can also form the intersection of two sets, i.e. find all elements that are in both:
let touchscreen: Set = ["iPhone", "iPad", "iPod touch", "iPod nano"]
let iPodsWithTouch = iPods.intersection(touchscreen)

//: Or, we can form the union of two sets, i.e. combine them into one (removing duplicates, of course):
var discontinued: Set = ["iBook", "Powerbook", "Power Mac"]
discontinued.formUnion(discontinuedIPods)
discontinued

//: Here, we used the mutating variant formUnion to mutate the original set (which, as a result, must be declared with var). Almost all set operations have both non-mutating and mutating forms, the latter beginning with form.... For even more set operations, check out the SetAlgebra protocol.

//:### Index Sets and Character Sets
//: Set is the only type in the standard library that conforms to SetAlgebra, but the protocol is also adopted by two interesting types in Foundation: IndexSet and CharacterSet. Both of these date back to a time long before Swift was a thing. The way these and other Objective-C classes are now bridged into Swift as fully featured value types — adopting common standard library protocols in the process — is great because they’ll instantly feel familiar to Swift developers.

//: IndexSet represents a set of positive integer values. You can, of course, do this with a Set<Int>, but IndexSet is way more storage efficient because it uses a list of ranges internally. Say you have a table view with 1,000 elements and you want to use a set to manage the indices of the rows the user has selected. A Set<Int> needs to store up to 1,000 elements, depending on how many rows are selected. An IndexSet, on the other hand, stores continuous ranges, so a selection of the first 500 rows in the table only takes two integers to store (the selection’s lower and upper bounds).

//: However, as a user of an IndexSet, you don’t have to worry about the internal structure, as it’s completely hidden behind the familiar SetAlgebra and Collection interfaces. (Unless you want to work on the ranges directly, that is. IndexSet exposes a view to them via its rangeView property, which itself is a collection.) For example, you can add a few ranges to an index set and then map over the indices as if they were individual members:
var indices = IndexSet()
indices.insert(integersIn: 1..<5)
indices.insert(integersIn: 11..<15)
let evenIndices = indices.filter{$0 % 2 == 0}
evenIndices

//: CharacterSet is an equally efficient way to store a set of Unicode characters. It’s often used to check if a particular string only contains characters from a specific character subset, such as *alphanumerics* or *decimalDigits*. Unlike IndexSet, CharacterSet isn’t a collection, though. We’ll talk a bit more about CharacterSet in the chapter on strings.

//:### Using Sets Inside Closures
//: Dictionaries and sets can be very handy data structures to use inside your functions, even when you’re not exposing them to the caller. For example, if we want to write an extension on Sequence to retrieve all unique elements in the sequence, we could easily put the elements in a set and return its contents. However, that won’t be stable: because a set has no defined order, the input elements might get reordered in the result. To fix this, we can write an extension that maintains the order by using an internal Set for bookkeeping:
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter {
            if seen.contains($0) {
                return false
            } else {
                seen.insert($0)
                return true
            }
        }
    }
}

[1,2,3,12,1,3,4,5,6,4,6].unique()

//: The method above allows us to find all unique elements in a sequence while still maintaining the original order (with the constraint that the elements must be Hashable). Inside the closure we pass to filter, we refer to the variable seen that we defined outside the closure, thus maintaining state over multiple iterations of the closure. In the chapter on functions, we’ll look at this technique in more detail.

//:## Ranges
//: A range is an interval of values, defined by its lower and upper bounds. You create ranges with the two range operators: ..< for half-open ranges that don’t include their upper bound, and ... for closed ranges that include both bounds:
let singleDigitNumbers = 0..<10
let lowercaseLetters = Character("a")...Character("z")

//: Ranges seem like a natural fit to be sequences or collections, so it may surprise you to learn that they’re neither — at least not all of them are.

//: There are now four range types in the standard library. They can be classified in a two-by-two matrix, as follows:

//:![rangeMatrix](rangeMatrix.png)

/*:
 The columns of the matrix correspond to the two range operators we saw above, which create a [Countable]Range (half-open) or a [Countable]ClosedRange (closed), respectively. Half-open and closed ranges both have their place:

* Only a **half-open range** can represent an **empty interval**(when the lower and upper bounds are equal, as in 5..<5).

* Only a **closed range** can contain the **maximum value** its element type can represent (e.g. 0...Int.max). A half-open range always requires at least one representable value that’s greater than the highest value in the range.
 
 The rows in the table distinguish between “normal” ranges whose element type only conforms to the Comparable protocol (which is the minimum requirement), and ranges over types that are Strideable and use integer steps between elements. Only the latter ranges are collections, inheriting all the powerful functionality we’ve seen in this chapter.
 
 Swift calls these more capable ranges countable because only they can be iterated over. Valid bounds for countable ranges include integer and pointer types, but not floating-point types, because of the integer constraint on the type’s Stride. If you need to iterate over consecutive floating-point values, you can use the *stride(from:to:by)* and *stride(from:through:by)* functions to create such a sequence.
 
 This means that you can iterate over some ranges but not over others. For example, the range of Character values we defined above isn’t a sequence, so this won’t work:
*/
/*
 for char in lowercaseLetters {
 //...
 }
*/

//: Meanwhile, the following is no problem because an integer range is a countable range and thus a collection:
singleDigitNumbers.map{$0 * $0}

/*:
 The distinction between the half-open Range and the closed ClosedRange will likely remain, and it can sometimes make working with ranges harder than it used to be. Say you have a function that takes a Range<Character> and you want to pass it the closed character range we created above. You may be surprised to find out that it’s not possible! Inexplicably, there appears to be no way to convert a ClosedRange into a Range. But why? Well, to turn a closed range into an equivalent half-open range, you’d have to find the element that comes after the original range’s upper bound. And that’s simply not possible unless the element is Strideable, which is only guaranteed for countable ranges.
 
 This means the caller of such a function will have to provide the correct type. If the function expects a Range, you can’t use the ... operator to create it. We’re not certain how big of a limitation this is in practice, since most ranges are likely integer based, but it’s definitely unintuitive.
*/




