import Foundation

struct Person {
    let name : String
    let surname : String
    let age : Int
    let gender = "Female"
    let address : String
    init (name : String, surname : String, age : Int, gender :String, address: String){
        self.name = name
        self.surname = surname
        self.age = age
        self.address = "Paris"
    }
}
let Gülçin = Person(name: "Gülçin", surname: "Çetin", age: 22, gender:"", address: "")
Gülçin.address
Gülçin.gender

let fullName = Gülçin.name + " " + Gülçin.surname
print(fullName)

// first way

struct Person2 {
    let firstName : String
    let lastName : String
    let fullName : String
    init(firstName : String, lastName :String){
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = "\(firstName) \(lastName)"
    }
}
let firstPerson2 = Person2(firstName: "Alex", lastName: "Koslov")
firstPerson2.fullName

// better way

struct Person3 {
    let firstName : String
    let lastName : String
    var fullName: String{
        "\(firstName) \(lastName)"
    }
}
let firstPerson = Person3(firstName: "Penny", lastName: "Willy")
firstPerson.fullName

// MUTABLE STRUCTERS

struct Car {
    var currentSpeed : Int
    mutating func drive(speed: Int){
        "Driving ... "
        currentSpeed = speed
    }
}

let immutableCar = Car(currentSpeed: 11)
// immutableCar.drive(speed: 20) !! You cant use let for mutating func cuz let is immutable

var mutableCar = Car(currentSpeed: 10)
/*
mutableCar.drive(speed: 20)
mutableCar.currentSpeed
*/

let copy = mutableCar // they have absolute no connection, we copied and now we've 2 same values as different

mutableCar.currentSpeed
mutableCar.drive(speed: 30)
mutableCar.currentSpeed
copy.currentSpeed // these two are not affected from each other, thats the point .Even it'd be var, it wouldnt change the copy.

struct LivingThing {
    init(){
        "I'm living thing"
    }
}

struct Bike {
    let manufacturer : String
    let currentSpeed : Int
    func copy(currentSpeed : Int)-> Bike {Bike(
        manufacturer : self.manufacturer,
        currentSpeed: currentSpeed
    )}
}
//-> Bike: This means the function returns a new instance of the Bike struct.

let bike1 = Bike(
    manufacturer: "HD",
    currentSpeed: 20
)

let bike2 = bike1.copy(currentSpeed: 40)
bike1.currentSpeed
bike2.currentSpeed

// this was a way of creating copies or custom copies of our structures.

