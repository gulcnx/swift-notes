import Foundation

protocol CanBreathe{
    func breathe()
}
// Cant create a func body inside protocol.

// Structures dont allow inheritances but protocol's inheritances.
struct Animal : CanBreathe{
    func breathe() {
        "Animal Breathing..."
    }
}
struct Person : CanBreathe{
    func breathe() {
        "Person breathing..."
    }
}

let dog = Animal()
dog.breathe()
let person = Person()
person.breathe()

// You cant create a body func in protocol. But there is a way to do this :

protocol CanJump{
    func jump()
}

extension CanJump{
    func jump(){
        "Jumping..."
    }
}

struct Cat : CanJump{
}

let whiskers = Cat()
whiskers.jump()

protocol HasName {
    var name : String { get }
    var age : Int { get set }
    //In Swift, { get } and { set } define access control for properties in protocols, classes, structs, and enums. They specify whether a property is readable (get) and/or writable (set).
    mutating func increaseAge()
}

extension HasName {
    func describeMe()->String{
        "Your name is \(name) and you are \(age) years old. "
    }
    mutating func increaseAge(){
        self.age += 1
    }
}

struct Dog : HasName{
    let name: String // This satisfies the protocol requirement because HasName only requires that the name property is readable (i.e., has a get), which is true for a constant (let).
    //Since get does not imply that the property needs to be mutable, you can safely declare name as a let constant in the Dog struct. You can read the value of name, but it cannot be changed after initialization, which is perfectly valid for a get-only requirement.
    var age: Int
}

var woof = Dog (
    name : "woof",
    age: 7
)
woof.name
woof.age
woof.age += 1
woof.age
woof.describeMe()

protocol Vehicle {
    var speed : Int {get set}
    mutating func increaseSpeed(by value : Int)
}

extension Vehicle {
    mutating func increaseSpeed( by value : Int){
        self.speed += value
    }
}

struct Bike : Vehicle{
    var speed : Int
    init (){
        self.speed = 0
    }
}

var bike = Bike()
bike.speed
bike.increaseSpeed(by: 10)
bike.speed

// "is" used to check if object conforms to a protocol or not
func describe(obj: Any){
    if obj is Vehicle{
        "obj conforms to the Vehicle protocol"
    } else {
        "obj doesnt NOT conform to the Vehicle protocol"
    }
}

describe(obj: bike)

func increaseSpeedIfVehicle(
    obj : Any
){
    if var vehicle = obj as? Vehicle{
        vehicle.speed
        vehicle.increaseSpeed(by: 10)
        vehicle.speed
    }else{
        "this is not a vehicle"
    }
}
increaseSpeedIfVehicle(obj: bike)
bike.speed
// this bike is a structure and structures are value types. That's why you aren't actually passing the memory consumed by this bike.Not the same memory address.



