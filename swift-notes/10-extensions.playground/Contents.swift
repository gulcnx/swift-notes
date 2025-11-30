import Foundation

// Extensions can add functionality to existing types.

extension Int{
    func plusTwo()-> Int{
        self + 2
        // self inside extensions refers to the current instance.
    }
}
let two = 2
two.plusTwo()

// We can add initializers to existing types by using extensions.

struct Person {
    let firstName: String
    let lastName : String
}

extension Person {
    init(fullName : String){
        let components = fullName.components(separatedBy: " ")
        self.init(
            firstName: components.first ?? fullName ,
            lastName: components.last ?? fullName
        )
    }
}

let person = Person(fullName: "Clarke Johnson")
person.firstName
person.lastName

// We can also extend existing types and add conformance to a protocol to an existing type.

protocol GoesVroom {
    var vroomValue : String { get }
    func goVroom() -> String
}

extension GoesVroom{
    func goVroom() -> String{
        "\(self.vroomValue) goes vroom ! "
    }
}

struct Car {
    let manufacturer : String
    let model : String
}

let modelX = Car(
    manufacturer: "Tesla",
    model: "X"
)

extension Car : GoesVroom{
    var vroomValue: String {
        "\(self.manufacturer) model \(self.model)"
    }
}

modelX.goVroom()

//Extensions on classes and with convenience initializers. So we can extend existing data types and convenience intitializers to classes.

class MyDouble{
    let value : Double
    init(value: Double){
        self.value = value
    }
}

extension MyDouble {
    convenience init (){
        self.init(value: 0)
    }
}

MyDouble().value

// We can also extend existing protocols.

extension GoesVroom{
    func goVroomEvenMore() -> String {
        "\(self.vroomValue) is vrooming even more !"
    }
}

modelX.goVroomEvenMore()



