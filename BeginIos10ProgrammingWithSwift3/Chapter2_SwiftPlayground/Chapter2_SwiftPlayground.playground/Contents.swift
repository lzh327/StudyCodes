//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var message1 = "Hello Swift! How can I get started?"
var message2 = "The best way to get started is to stop talking and code."

message1.uppercased()

print(message2.lowercased() + " OK, I am working on it 😁")

if message1 == message2 {
    print("Same message")
} else {
    print("Not the same message")
}

let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
messageLabel.text = message1

messageLabel

messageLabel.backgroundColor = UIColor.orange
messageLabel.textAlignment = NSTextAlignment.center
messageLabel.layer.cornerRadius = 10.0
messageLabel.clipsToBounds = true

messageLabel