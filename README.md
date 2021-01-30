# swift

```swift
// define variable
var firstname = "Tom"

// constent value, cannot be assigned to other value
let lastname = "Smith" 
```

# Data Types:
- String
- Int
- Float
- Double
- Bool

# Function
```swift
var firstName:String = "Tom"
for counter in 1...5 {}

func addTwoNumbers() {}

// parameter label
func addTwoNumbers(using number1:Int, and number2:Int ) -> Int {
    return number1 + number2
}
let sum = addTwoNumbers(using: 5, and: 5)

func addTwoNumbers(number1: Int, number2: Int ) -> Int {
    return number1 + number2
}
let sum = addTwoNumbers(number1: 5, number2: 5)

func addTwoNumbers(_ number1:Int, _ number2:Int ) -> Int {
    return number1 + number2
}
let sum = addTwoNumbers(5, 5)
```

# Class
```swift
class Employee {
  var name = "name"
  var salary = 0
  var role = ""
    
    func doWork() {
        print("My name is \(name) and I'm doing the work")
        salary += 1;
    }
}

class Manager: Employee {
    var teamSize = 0
    
    override func doWork() {
        super.doWork()                // My name is Maggie and I'm doing the work
        print("I'm managing people")  // I'm managing people
        salary += 2
    }
    
    func firePeople() {
        print("I'm firing people")
    }
}

let c: Employee = Employee()
c.name = "Tom"
print(c.name)
c.doWork()
print(c.salary)


var m = Manager()
m.name = "Maggie"
m.salary = 2000
m.role = "Manager of IT"
m.teamSize = 10
m.doWork()
m.firePeople()
```

```swift
class Person {
    var name = ""
    init() {
        name = "Joe"
    }
    
    init (_ name:String) {
        self.name = name
    }
}

let p = Person()
print(p.name)       // Joe

let p1 = Person("Tom")
print(p1.name)      // Tom


class Employee:Person {
  var salary = 0
  var role = ""
    
  override init() {
      super.init()
  }
  override init(_ name:String) {
      super.init(name)
      self.role = "Analyst"
  }
    
  func doWork() {
      print("My name is \(name) and I'm doing the work")
      salary += 1;
  }
}

let employee = Employee("Mark")     // Employee inherit init() from Person class as well
print(employee.name) // Mark
print(employee.role) // Analyst
```

# Optional
```swift
var a:Int? = nil      // declare an optional, int or nil
var b:String? = nil   // declare an optional, string or nil

// c can store a string or nil, but it is wrapped
var c:String?         // default is nil - RECOMMENDED way to declare
// d can store a string or nil, but it is already unwrapped
var d:String!         // 更容易出错，d.method() 时不会再检查 d 是不是 nil

class  XmasPresent {
    func surprise() -> Int {
        return Int.random(in: 1...10)
    }
}

let present:XmasPresent? = XmasPresent()

// check the optional to see if it contains an object
// 1. check first and then unwrap
if present != nil {
    // have to first unwrap the optional
    print(present!.surprise())
}

// 2. Optional binding
// if present is nil, pass the if statement
// if present is not nil, unwrap it and assign it to actualPresent
if let actualPresent = present {
    print(actualPresent.surprise())
}

// 3. Optional chaining
// if present is nil, nothing happens, otherwise, run the statement
present?.surprise()
```

# Properties
// calculated properties
var bonus:Int {
  return teamSize * 1000
}

# Designated & Convenience Initializer
```swift
class Person {
    var name:String
    // optional integer
    var networth:Int?
    var gender:String!
    
    // designated initializer ensure that the object is ready to be used and all of its properties are initialized
    init() {
        name = "None"
    }
    
    // convenience initializer is for you to preconfig the object in a certain way. may call designated initializer in it
    convenience init(_ gender:String, _ networth:Int) {
        // call the designated initializer to ensure that the object is ready to go
        self.init()
        
        // set any other properties or custom code to initialize for this scenario
        self.gender = gender
        self.networth = networth
    }
}

let a = Person()
print(a.name)
print(a.networth)   // nil

let b = Person("male", 12222)
```

# Array
```swift
let array = ["Dog", "Car", "Bird"]
for counter in 0...array.count - 1 {
    print(array[counter])
}

for item in array {
    print(item)
}

// array type
var myArray:[String] = ["Dog", "Car", "Bird"]

// how to declare an empty array
var emptyArray:[String] = []
var emptyArray2 = [String]()


myArray.insert("Frog", at: 0)
myArray += ["Frog", "Bear"]
// Frog Dog Car Bird Frog Bear
```

# Dictionary
```swift
// declare a distionary
var myDictionary = [String:String]()

// assign data into a distionary
myDictionary["SJD 293"] = "Red Ferrari"
myDictionary["UDS 111"] = "BMW"

// retrieve value as optional string
print(myDictionary["SJD 293"])
print(myDictionary["1"])        // nil

// remove
//myDictionary["SJD 293"] = nil

// loop through
for (key, value) in myDictionary {
    print("\(key) is a \(value)")
}
```
