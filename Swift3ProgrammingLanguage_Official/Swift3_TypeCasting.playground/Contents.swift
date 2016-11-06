//*********************************** Type Casting *********************************************
//Type casting is a way to check the type of an instance, or to treat that instance as a different superclass or subclass from somewhere else in its own class hierarchy.

//Type casting in Swift is implemented with the is and as operators. These two operators provide a simple and expressive way to check the type of a value or cast a value to a different type.

//You can also use type casting to check whether a type conforms to a protocol.

//*********************************** Defining a Class Hierarchy for Type Casting *********************************************

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String){
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

//The final snippet creates a constant array called library, which contains two Movie instances and three Song instances. The type of the library array is inferred by initializing it with the contents of an array literal. Swift’s type checker is able to deduce that Movie and Song have a common superclass of MediaItem, and so it infers a type of [MediaItem] for the library array:
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

//The items stored in library are still Movie and Song instances behind the scenes. However, if you iterate over the contents of this array, the items you receive back are typed as MediaItem, and not as Movie or Song. In order to work with them as their native type, you need to check their type, or downcast them to a different type.

//*********************************** Checking Type *********************************************
//Use the type check operator (is) to check whether an instance is of a certain subclass type. The type check operator returns true if the instance is of that subclass type and false if it is not.

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")

//*********************************** Downcasting *********************************************
//A constant or variable of a certain class type may actually refer to an instance of a subclass behind the scenes. Where you believe this is the case, you can try to downcast to the subclass type with a type cast operator (as? or as!).

//Because downcasting can fail, the type cast operator comes in two different forms. The conditional form, as?, returns an optional value of the type you are trying to downcast to. The forced form, as!, attempts the downcast and force-unwraps the result as a single compound action.

//Use the conditional form of the type cast operator (as?) when you are not sure if the downcast will succeed. This form of the operator will always return an optional value, and the value will be nil if the downcast was not possible. This enables you to check for a successful downcast.

//Use the forced form of the type cast operator (as!) only when you are sure that the downcast will always succeed. This form of the operator will trigger a runtime error if you try to downcast to an incorrect class type.

for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}

//Casting does not actually modify the instance or change its values. The underlying instance remains the same; it is simply treated and accessed as an instance of the type to which it has been cast.

//*********************************** Type Casting for Any and AnyObject *********************************************
// Swift provides two special types for working with nonspecific types:

// Any can represent an instance of any type at all, including function types.
// AnyObject can represent an instance of any class type.

//Use Any and AnyObject only when you explicitly need the behavior and capabilities they provide. It is always better to be specific about the types you expect to work with in your code.

var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.1415926)
things.append("Hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({(name: String) -> String in "Hello, \(name)"})

//To discover the specific type of a constant or variable that is known only to be of type Any or AnyObject, you can use an is or as pattern in a switch statement’s cases.

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an Integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))//??Why it is not stringConverter(name: "Michael")
    default:
        print("something else")
    }
}

//The Any type represents values of any type, including optional types. Swift gives you a warning if you use an optional value where a value of type Any is expected. If you really do need to use an optional value as an Any value, you can use the as operator to explicitly cast the optional to Any, as shown below.
let optionalNumber: Int? = 3
things.append(optionalNumber)        //Warning
things.append(optionalNumber as Any) //No warning



print("\r")
print("\r")


//*********************************** Test For Label Name and Function Type *********************************************


func testFunctionWithLabelName(name: String) -> String {
    return "this is a test, \(name)"
}

let result = testFunctionWithLabelName(name: "LiZhen")
//let result1 = testFunctionWithLabelName("LiZhen") //Error, need the argument label of "name"
print(result)

var test1: (String) -> String
test1 = testFunctionWithLabelName
let result1 = test1("LiZhen")
//let result1 = test1(name: "LiZhen") //Error, it should not use the argument label of "name"
print(result1)

//var test2: (name: String) -> String   //function types cannot have argument label 'name'; use '_' instead
var test2: (_ name: String) -> String //function types cannot have argument label 'name'; use '_' instead
test2 = testFunctionWithLabelName
let result2 = test2("LiZhen")
//let result2 = test2(name: "LiZhen") //Error, it should not use the argument label of "name"
print(result2)



































