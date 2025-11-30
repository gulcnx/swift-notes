import Foundation

class Person {
    var name : String
    var age : Int
    
    // it needs a constructer or initializer
    init(
        name : String,
        age : Int
    ){
        self.name = name
        self.age = age
    }
    
    func increaseAge(){
        self.age += 1
    }
}

let person1 = Person(
    name:"John" ,
    age: 22
)

person1.name
person1.age

person1.increaseAge()
person1.age
// classes allow to internal mutability, but structers doesnt.

person1.age
let person2 = person1
person2.increaseAge()
person1.age
person2.age
//it didnt copy it, instead it made it same instance. these two pointing to the same memory now.

if person1 === person2 {
    "person1 and person2 point to the same memory "
}else {
    "they dont point to the same memory"
}

// subclassing the superclass

class Vehicle {
    func goVroom(){
        print("vroom vroom")
    }
}

class Car : Vehicle{
}

let car = Car()
car.goVroom()
// You cant to that in structers.

//private(set) = Only can mutate internally.

class Person2 {
    private(set) var age : Int
    init (age : Int){
        self.age = age
    }
    func increaseAge(){
        self.age += 1
    }
}

let person3 = Person2(age: 23)
person3.age
person3.increaseAge()
person3.age

// person3.age += 1 //that gave us a error.

// |CONVENIENCE AND DESIGNATED INITIALIZER|
//Convenience initializer delegates work to the designated initializer.

//Designated Initializer
class Tesla {
    let manufacturer = "Tesla"
    let model : String
    let year : Int
    
    init(){
        self.model = "X"
        self.year = 2023
    }
    init(
        model : String,
        year : Int
    ){
        self.model = model
        self.year = year
    }
    
    // Convenience Inıtıalizer
    convenience init (
        model: String
){
    self.init(
        model: model,
        year : 2023
    )
}
}

class TeslaModelY : Tesla {
    override init() {
        super.init(
            model: "Y",
            year: 2023
        )
    }
}

// Designated initializers in subclasses only call to designated initializers in their superclass.
// Inside any class a designated initializer cannot delegate to any other initializer.

let modelY = TeslaModelY()
modelY.model
modelY.year
modelY.manufacturer

// Classes are reference types ,they aren't value types unlike structures.

let someOne = Person2(age: 20)
someOne.age
func doSomething(with person : Person2){
    person.increaseAge()
}
doSomething(with: someOne)
someOne.age


let someone = Person2(age : 20)
someone.age
someone.increaseAge()
someone.age

// Deinitializer

class MyClass{
    init(){
        "Initialized"
    }
    func doSomething(){
        "Do something"
    }
    deinit{
        "Deinitialized"
    }
}

let myClouser = {
    let myClass = MyClass()
    myClass.doSomething()
}
myClouser()

