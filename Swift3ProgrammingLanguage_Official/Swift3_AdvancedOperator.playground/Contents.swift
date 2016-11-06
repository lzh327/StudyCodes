//****************************** Advanced Operators *********************************
//In addition to the operators described in Basic Operators, Swift provides several advanced operators that perform more complex value manipulation. These include all of the bitwise and bit shifting operators you will be familiar with from C and Objective-C.

//Unlike arithmetic operators in C, arithmetic operators in Swift do not overflow by default. Overflow behavior is trapped and reported as an error. To opt in to overflow behavior, use Swift’s second set of arithmetic operators that overflow by default, such as the overflow addition operator (&+). All of these overflow operators begin with an ampersand (&).

//When you define your own structures, classes, and enumerations, it can be useful to provide your own implementations of the standard Swift operators for these custom types. Swift makes it easy to provide tailored implementations of these operators and to determine exactly what their behavior should be for each type you create.

//You’re not limited to the predefined operators. Swift gives you the freedom to define your own custom infix, prefix, postfix, and assignment operators, with custom precedence and associativity values. These operators can be used and adopted in your code like any of the predefined operators, and you can even extend existing types to support the custom operators you define.

//****************************** Bitwise Operators *********************************

//Bitwise NOT Operator
//The bitwise NOT operator (~) inverts all bits in a number:
//The bitwise NOT operator is a prefix operator, and appears immediately before the value it operates on, without any white space:
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits   //equals 11110000

//Bitwise AND Operator
//The bitwise AND operator (&) combines the bits of two numbers. It returns a new number whose bits are set to 1 only if the bits were equal to 1 in both input numbers:
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8 = 0b00111111
let middleFoutBits = firstSixBits & lastSixBits //equal 00111100

//Bitwise OR Operator
//The bitwise OR operator (|) compares the bits of two numbers. The operator returns a new number whose bits are set to 1 if the bits are equal to 1 in either input number:
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedBits = someBits | moreBits  //equal 11111110

//Bitwise XOR Operator
//The bitwise XOR operator, or “exclusive OR operator” (^), compares the bits of two numbers. The operator returns a new number whose bits are set to 1 where the input bits are different and are set to 0 where the input bits are the same:
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits //equal 00010001

//Bitwise Left and Right Shift Operators
//The bitwise left shift operator (<<) and bitwise right shift operator (>>) move all bits in a number to the left or the right by a certain number of places, according to the rules defined below.

//Bitwise left and right shifts have the effect of multiplying or dividing an integer by a factor of two. Shifting an integer’s bits to the left by one position doubles its value, whereas shifting it to the right by one position halves its value.

//Shifting Behavior for Unsigned Integers
//The bit-shifting behavior for unsigned integers is as follows:

// Existing bits are moved to the left or right by the requested number of places.
// Any bits that are moved beyond the bounds of the integer’s storage are discarded.
// Zeros are inserted in the spaces left behind after the original bits are moved to the left or right.

//Here’s how bit shifting looks in Swift code:
let shiftBits: UInt8 = 4   // 00000100 in binary
shiftBits << 1             // 00001000
shiftBits << 2             // 00010000
shiftBits << 5             // 10000000
shiftBits << 6             // 00000000
shiftBits >> 2             // 00000001

//You can use bit shifting to encode and decode values within other data types:
let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16    // redComponent is 0xCC, or 204
let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent is 0x66, or 102
let blueComponent = pink & 0x0000FF           // blueComponent is 0x99, or 153

//Shifting Behavior for Signed Integers
//The shifting behavior is more complex for signed integers than for unsigned integers, because of the way signed integers are represented in binary. (The examples below are based on 8-bit signed integers for simplicity, but the same principles apply for signed integers of any size.)

//Signed integers use their first bit (known as the sign bit) to indicate whether the integer is positive or negative. A sign bit of 0 means positive, and a sign bit of 1 means negative.

//The remaining bits (known as the value bits) store the actual value. Positive numbers are stored in exactly the same way as for unsigned integers, counting upwards from 0. Here’s how the bits inside an Int8 look for the number 4:
//00000100

//Negative numbers, however, are stored differently. They are stored by subtracting their absolute value from 2 to the power of n, where n is the number of value bits. An eight-bit number has seven value bits, so this means 2 to the power of 7, or 128.

//Here’s how the bits inside an Int8 look for the number -4:
//11111100

//This time, the sign bit is 1 (meaning “negative”), and the seven value bits have a binary value of 124 (which is 128 - 4):

//Shift the bits of negative numbers to the left and right like positive numbers, and still end up doubling them for every shift you make to the left, or halving them for every shift you make to the right. To achieve this, an extra rule is used when signed integers are shifted to the right: When you shift signed integers to the right, apply the same rules as for unsigned integers, but fill any empty bits on the left with the sign bit, rather than with a zero.

//****************************** Overflow Operators *********************************
//If you try to insert a number into an integer constant or variable that cannot hold that value, by default Swift reports an error rather than allowing an invalid value to be created. This behavior gives extra safety when you work with numbers that are too large or too small.

//For example, the Int16 integer type can hold any signed integer between -32768 and 32767. Trying to set an Int16 constant or variable to a number outside of this range causes an error:

var potentialOverflow = Int16.max
// potentialOverflow equals 32767, which is the maximum value an Int16 can hold
//potentialOverflow += 1
// this causes an error

//Providing error handling when values get too large or too small gives you much more flexibility when coding for boundary value conditions.

// However, when you specifically want an overflow condition to truncate the number of available bits, you can opt in to this behavior rather than triggering an error. Swift provides three arithmetic overflow operators that opt in to the overflow behavior for integer calculations. These operators all begin with an ampersand (&):

// Overflow addition (&+)
// Overflow subtraction (&-)
// Overflow multiplication (&*)

//Value Overflow
//Numbers can overflow in both the positive and negative direction.

//Here’s an example of what happens when an unsigned integer is allowed to overflow in the positive direction, using the overflow addition operator (&+):

var unsignedOverflow = UInt8.max
// unsignedOverflow equals 255, which is the maximum value a UInt8 can hold
unsignedOverflow = unsignedOverflow &+ 1
// unsignedOverflow is now equal to 0

//Something similar happens when an unsigned integer is allowed to overflow in the negative direction. Here’s an example using the overflow subtraction operator (&-):
var unsignedOverflow1 = UInt8.min
// unsignedOverflow equals 0, which is the minimum value a UInt8 can hold
unsignedOverflow1 = unsignedOverflow1 &- 1
// unsignedOverflow is now equal to 255

//Overflow also occurs for signed integers. All addition and subtraction for signed integers is performed in bitwise fashion, with the sign bit included as part of the numbers being added or subtracted, as described in Bitwise Left and Right Shift Operators.

var signedOverflow = Int8.min
// signedOverflow equals -128, which is the minimum value an Int8 can hold
signedOverflow = signedOverflow &- 1
// signedOverflow is now equal to 127

//For both signed and unsigned integers, overflow in the positive direction wraps around from the maximum valid integer value back to the minimum, and overflow in the negative direction wraps around from the minimum value to the maximum.

//****************************** Precedence and Associativity *********************************
// Operator precedence gives some operators higher priority than others; these operators are applied first.

// Operator associativity defines how operators of the same precedence are grouped together—either grouped from the left, or grouped from the right. Think of it as meaning “they associate with the expression to their left,” or “they associate with the expression to their right.”

2 + 3 % 4 * 5
// this equals 17

//2 + ((3 % 4) * 5)

//****************************** Operator Methods *********************************
//Classes and structures can provide their own implementations of existing operators. This is known as overloading the existing operators.

//The example defines a Vector2D structure for a two-dimensional position vector (x, y), followed by a definition of an operator method to add together instances of the Vector2D structure:

struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}

//The operator method is defined as a type method on Vector2D, with a method name that matches the operator to be overloaded (+). Because addition isn’t part of the essential behavior for a vector, the type method is defined in an extension of Vector2D rather than in the main structure declaration of Vector2D. Because the arithmetic addition operator is a binary operator, this operator method takes two input parameters of type Vector2D and returns a single output value, also of type Vector2D.

//The type method can be used as an infix operator between existing Vector2D instances:
let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector
// combinedVector is a Vector2D instance with values of (5.0, 5.0)

//Prefix and Postfix Operators
//The example shown above demonstrates a custom implementation of a binary infix operator. Classes and structures can also provide implementations of the standard unary operators. Unary operators operate on a single target. They are prefix if they precede their target (such as -a) and postfix operators if they follow their target (such as b!).

//You implement a prefix or postfix unary operator by writing the prefix or postfix modifier before the func keyword when declaring the operator method:
extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
// negative is a Vector2D instance with values of (-3.0, -4.0)
let alsoPositive = -negative
// alsoPositive is a Vector2D instance with values of (3.0, 4.0)

//Compound Assignment Operators
//Compound assignment operators combine assignment (=) with another operation. For example, the addition assignment operator (+=) combines addition and assignment into a single operation. You mark a compound assignment operator’s left input parameter type as inout, because the parameter’s value will be modified directly from within the operator method.

extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

//Because an addition operator was defined earlier, you don’t need to reimplement the addition process here. Instead, the addition assignment operator method takes advantage of the existing addition operator method, and uses it to set the left value to be the left value plus the right value:

var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd
// original now has values of (4.0, 6.0)

//It is not possible to overload the default assignment operator (=). Only the compound assignment operators can be overloaded. Similarly, the ternary conditional operator (a ? b : c) cannot be overloaded.

//Equivalence Operators
//Custom classes and structures do not receive a default implementation of the equivalence operators, known as the “equal to” operator (==) and “not equal to” operator (!=). It is not possible for Swift to guess what would qualify as “equal” for your own custom types, because the meaning of “equal” depends on the roles that those types play in your code.

extension Vector2D {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    static func != (left: Vector2D, right: Vector2D) -> Bool {
        return !(left == right)
    }
}

let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("These two vectors are equivalent")
}

//****************************** Custom Operators *********************************
//You can declare and implement your own custom operators in addition to the standard operators provided by Swift. For a list of characters that can be used to define custom operators, see Operators.

// New operators are declared at a global level using the operator keyword, and are marked with the prefix, infix or postfix modifiers:

prefix operator +++

//The example above defines a new prefix operator called +++. This operator does not have an existing meaning in Swift, and so it is given its own custom meaning below in the specific context of working with Vector2D instances. For the purposes of this example, +++ is treated as a new “prefix doubling” operator. It doubles the x and y values of a Vector2D instance, by adding the vector to itself with the addition assignment operator defined earlier. To implement the +++ operator, you add a type method called +++ to Vector2D as follows:

extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

var toBeDoubled = Vector2D(x: 2.0, y: 4.0)
let afterDoubling = +++toBeDoubled
// toBeDoubled now has values of (2.0, 8.0)
// afterDoubling also has values of (2.0, 8.0)

//Precedence for Custom Infix Operators
//Custom infix operators each belong to a precedence group. A precedence group specifies an operator’s precedence relative to other infix operators

//A custom infix operator that is not explicitly placed into a precedence group is given a default precedence group with a precedence immediately higher than the precedence of the ternary conditional operator.

//The following example defines a new custom infix operator called +-, which belongs to the precedence group AdditionPrecedence:

infix operator +-: AdditionPrecedence

extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}

let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
// plusMinusVector is a Vector2D instance with values of (4.0, -2.0)

//You do not specify a precedence when defining a prefix or postfix operator. However, if you apply both a prefix and a postfix operator to the same operand, the postfix operator is applied first.




