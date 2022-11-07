## Extension

### Extend Existing Type

```swift
extension Double {
    var squared: Double { return self * self }
}
let sideLength: Double = 12.5
let area = sideLength.squared
```

### Extend Own Type

`structs` give you a free memberwise initializer if you do not provide your own. If you want to write a new initializer for your `struct` but do not want to lose the free memberwise or empty initializer, you can add the initializer to your `type` with an `extension`.

```swift
struct Car {
    let make: String
    let model: String
    let year: Int
    var fuelLevel: Double {
        willSet {
            precondition(newValue <= 1.0 && newValue >= 0.0, "New value must be between 0 and 1.")
        }
    }
}

// Add protocol conformance
extension Car: CustomStringConvertible {
    var description: String {
        return "\(year) \(make) \(model), fuel level: \(fuelLevel)"
    }
}

// Add initializer
extension Car {
    init(make: String, model: String, year: Int) {
        self.init(make: make, model: model, year: year, fuelLevel: 1.0)
    }
}

let firstCar = Car(make: "Benz", model: "Patent-Motorwagon", year: 1886, fuelLevel: 0.5)
var currentCar = Car(make: "Honda", model: "Civic", year: 2008)
firstCar.fuelLevel // 0.5
currentCar.fuelLevel // 1

// Add nested types, computed property
extension Car {
    enum Era {
        case veteran, brass, vintage, modern
    }
    var era: Era {
        switch year {
        case ...1896:
            return .veteran
        case 1897...1919:
            return .brass
        case 1920...1930:
            return .vintage
        default:
            return .modern
        }
    }
}
firstCar.era // veteran

// Add methods
extension Car {
    mutating func emptyFuel(by amount: Double) {
        precondition(amount <= 1 && amount > 0, "Amount to remove must be between 0 and 1.")
        fuelLevel -= amount
    }
    mutating func fillFuel() {
        fuelLevel = 1.0
    }
}
currentCar.emptyFuel(by: 0.3)
currentCar.fuelLevel
```

```swift
extension UIButton {
    func makeCircular() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
}
let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
button.backgroundColor = .red
button.makeCircular()
```

### Extend Protocol

```swift
protocol CanFly {
    func fly()
}

// provide a default implementation of fly()
extension CanFly {
    func fly() {
        print("The obj can take off into the air")
    }
}
struct Airplane: CanFly {}

let myPlane = Airplane()
myPlane.fly() // The obj can take off into the air
```

## Protocols

- All types can conform to protocols
- A type can conform to multiple protocols

```swift
protocol MyProtocol {
    // Define requirements
}
struct MyStruct: FirstProtocol, SecondProtocol {}
class MyClass: SuperClass, FirstProtocol {}
protocol MyProtocol: AnotherProtocol {}

protocol CanFly {
    func fly()  // cannot have implementation
}

class Bird {
    var isFemale = true
    func layEgg() {
        if isFemale { ... }
    }
}

class Eagle: Bird, CanFLy {
    func fly() { ... }
    func soar() { ... }
}

class Penguin: Bird {
    func swim() { ... }
}

// struct instead of class, because it does not need to inherit from any parent class
struct Airplane: CanFly {
    func fly() { ... }
}

struct FlyingMuseum {
    func flyingDemo(flyingObject: CanFly) { // requires an obj that adopts CanFly
        flyingObject.fly()
    }
}

// Protocol composition
// 1. require dataSource conforms to both TabularDataSource and CustomStringConvertible.
struct Department: TabularDataSource, CustomStringConvertible {...}
func printTable(_ dataSource: TabularDataSource & CustomStringConvertible) {
    print("Table: \(dataSource)")
}
// 2. create a new protocol that inherit from both
protocol PrintableTabularDataSource: TabularDataSource, CustomStringConvertible {}
```

## Delegate Design Pattern

![](/media/delegate.png)

## Closure

```swift
func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(n1, n2)
}

// function type (Int, Int) -> Int)
func add(n1: Int, n2: Int) -> Int {
    return n1 + n2
}
func multiply(n1: Int, n2: Int) -> Int {
    return n1 * n2
}
calculator(n1: 2, n2: 3, operation: add)         // 5
calculator(n1: 2, n2: 3, operation: multiply)    // 6

// closure expression syntax
{ (parameters) -> return type in
    // Code
}

// closure syntax for the multiply function
{ (n1: Int, n2: Int) -> Int in
    return n1 * n2
}

calculator(n1: 2, n2: 3, operation: { (n1: Int, n2: Int) -> Int in
    return n1 * n2
})
calculator(n1: 2, n2: 3, operation: { (n1, n2) in n1 * n2 })      // 6
calculator(n1: 2, n2: 3, operation: { $0 * $1 })
// trailing closure
calculator(n1: 2, n2: 3) { $0 * $1 }

let volunteerCounts = [1, 3, 40, 32, 2, 53, 77, 13]
func isAscending(_ i: Int, _ j: Int) -> Bool {
    return i < j
}
// function type for sorted(by:) is ((Int, Int) -> Bool) -> [Int]
// input - a closure; output - an array
let volunteersSorted = volunteerCounts.sorted(by: isAscending)
// [1, 2, 3, 13, 32, 40, 53, 77]

let volunteersSorted = volunteerCounts.sorted(by: {
    (i: Int, j: Int) -> Bool in
    return i < j
})
// take advantage of Swift’s type inference system
let volunteersSorted = volunteerCounts.sorted(by: { i, j in i < j })
// positional variable names
let volunteersSorted = volunteerCounts.sorted(by: { $0 < $1 })
// trailing closure syntax - because no parameters remain after moving the closure argument outside the parentheses, the parentheses are deleted.
let volunteersSorted = volunteerCounts.sorted { $0 < $1 }

// If there are multiple trailing closures, this only applies to the first; subsequent trailing closures retain their argument labels
func doAwesomeWork(on input: String,
                using transformer: () -> Void,
                then completion: () -> Void)
doAwesomeWork(on: "My Project") {
    print("Doing work on \(input) in `transformer`")
} then: {
    print("Finishing up in `completion`")
}

// functions as arguments
func format(numbers: [Double], using formatter: (Double) -> String) -> [String] {
    var result = [String]()
    for number in numbers {
        let transformed = rounder(number)
        result.append(transformed)
    }
    return result
}
let rounder: (Double) -> String = {
    (num: Double) -> String in
    return "\(Int(num.rounded()))"
}
let volunteerAverages = [10.75, 4.2, 1.5, 12.12, 16.815]
let roundedAveragesAsStrings = format(numbers: volunteerAverages, using: rounder)

// default value for the formatter argument: a concise closure that merely returns its argument interpolated into a String
func format(numbers: [Double], using formatter: (Double) -> String = {"\($0)"}) -> [String] {
    var result = [String]()
    for number in numbers {
        let transformed = rounder(number)
        result.append(transformed)
    }
    return result
}
let exactAveragesAsStrings = format(numbers: volunteerAverages)
```

High Order functions

```swift
let roundedAverages = volunteerAverages.map {
    (avg: Double) -> Int in
    return Int(avg.rounded())
}
let passingAverages = roundedAverages.filter {
    (avg: Int) -> Bool in
    return avg >= 10
}
let estimatedParticipation = passingAverages.reduce(5) {
    (estimationSoFar: Int, currentOrgAverage: Int) -> Int in
    return estimationSoFar + currentOrgAverage
}
```

Functions as Return types

```swift
func makeCharacterRemover(for character: Character) -> (String) -> String {
    func removeFrom(_ input: String) -> String {
        return input.filter { $0 != character }
    }
    return removeFrom
}
let removeLowerCaseLs = makeCharacterRemover(for: "l")
let strangeGreeting = removeLowerCaseLs("Hello, World!")
```

## Generics

```swift
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ newItem: Element) {
        items.append(newItem)
    }
    mutating func pop() -> Element? {
        guard !items.isEmpty else { return nil }
        return items.removeLast()
    }

    func map<U>(_ txform: (Element) -> U) -> Stack<U> {
        var mappedItems = [U]()
        for item in items {
            mappedItems.append(txform(item))
        }
        return Stack<U>(items: mappedItems)
    }
}

func myMap<T,U>(_ items: [T], _ txform: (T) -> (U)) -> [U] {
    var result = [U]()
    for item in items {
        result.append(txform(item))
    }
    return result
}

var intStack = Stack<Int>()
var doubledStack = intStack.map { 2 * $0 }
let strings = ["one", "two", "three"]
let stringLengths = myMap(strings) { $0.count }

// type constraints
func checkIfEqual<T: Equatable>(_ first: T, _ second: T) -> Bool {
    return first == second
}
print(checkIfEqual(1, 1))

func checkIfDescriptionsMatch<T: CustomStringConvertible, U: CustomStringConvertible>(_ first: T, _ second: U) -> Bool {
    return first.description == second.description
}
print(checkIfDescriptionsMatch(Int(1), UInt(1))) // T
print(checkIfDescriptionsMatch(1, 1.0)) // F
print(checkIfDescriptionsMatch(Float(1.0), Double(1.0))) // T
```

### Pattern Match for Enum Case

```swift
// Result<UIImage, Error>
if case let .success(image) = result {
    photo.image = image
}
// behaves just like this code:
switch result {
    case let .success(image):
        photo.image = image
    case .failure:
        break
}
```
