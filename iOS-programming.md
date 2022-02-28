## Delegate Design Pattern - with Protocol

```swift
// define the required functions in protocol, but no implementation
protocol AdvancedLifeSupport {
    func performCPR()
}

// similar to TextField class
// EmergencyCallHandler don't care who can do performCPR, as long as they adopt the AdvancedLifeSupport protocol
class EmergencyCallHandler {
    var delegate: AdvancedLifeSupport?

    func assessSituation() { ... }

    func medicalEmergency() {
        delegate?.performCPR()
    }
}

// Paramedic adopts the AdvancedLifeSupport protocol
struct Paramedic: AdvancedLifeSupport {
    // when the paramedic is going on call
    init(handler: EmergencyCallHandler) {
        // set the handler's delegate to the paramedic self
        handler.delegate = self
    }

    func performCPR() { // implementation... }
}

class Doctor: AdvancedLifeSupport {
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }

    func performCPR() { // implementation... }
    func useStethescope() { ... }
}

class Surgeon: Doctor {
    override func performCPR() {
        super.performCPR()
        // do more stuff on behalf of Surgeon...
    }

    func useElectricDrill() { ... }
}

let emilio = EmergencyCallHandler()
let pete = Paramedic(handler: emilio)
let angela = Surgeon(handler: emilio)

emilio.assessSituation()
emilio.medicalEmergency()
```

## ViewController LifeCycle

- viewDidLoad() - IBOutlet/IBAction is created and connected, called only ONCE
- viewWillAppear() - just before the view is presented on the screen
- viewDidAppear() - user is able to see the view
- viewWillDisappear() - when navigate back or dismiss the view
- viewDidDisappear() - does not mean the view is destroyed

## App LifeCycle

```swift
// open the app
application(_:didFinishLaunchingWithOptions:)
scene(_:willConnectTo:options:)
viewDidLoad()
viewWillAppear()
sceneWillEnterForeground()
sceneDidBecomeActive()
viewDidAppear()
// bring the app to the multitasking screen
sceneWillResignActive()
// navigate to another app
sceneDidEnterBackground()
// relaunch the app
sceneWillEnterForeground()
sceneDidBecomeActive()
// kill the app
sceneWillResignActive()
sceneDidDisconnect()
application(_:didDiscardSceneSessions:)
```

## Singleton

```swift
class Car {
    var color = "Red"
    static let singletonCar = Car()
}

let myCar = Car.singletonCar
meCar.color = "Blue"
let yourCar = Car.singletonCar
print(yourCar.color)  // Blue
```
