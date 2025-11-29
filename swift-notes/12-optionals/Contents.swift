import Foundation

// Value is optional integer here and we set a default value by using optional feature.

func multipleByTwo(_ value: Int? = nil)-> Int{
    if let value {
        return value * 2
    }else {
        return 0
    }
}
multipleByTwo()
// And we can see here default is set to zero.
multipleByTwo(nil)
multipleByTwo(4)
multipleByTwo(8)

let age : Int? = nil
if age != nil {
    "Age is there ! How odd!"
}else{
    "Age is nil. Correct."
}
// Thats how we can compare a value not being nil for instance.

// If you want to take an optional value and check whether it actually exist or not we can use "if let" syntax.
if let age {
    "Age is there. How odd! Its value is \(age)"
}else {
    "No age is present as expexted."
}

// With below instance, we can check age is there and print about it or if it isnt there we can return from this function within message.
// If our function depends on some optional values and it cant continue without those optional values being present. We need to use the guard mechanism.

func checkAge(){
    guard age != nil else { // guard age SHOULDN'T BE NIL ELSE
        "Age is nil as expected"
        return // Thats the whole point. Without return, it wont work.
    }
    "Age is not nil here. Strange!! "
}

checkAge()

// By using guard, we can unwrap values.

let age2 : Int? = 10
func checkAge2(){
    guard let age2 else {
        "Age is nil. How strange"
        return
    }
    "Age2 is not nil as expexted. Value = \(age2)"
}

checkAge2()

// Optionals are actually an instance of enumerations.

switch age {
case .none:
    "Age has no value as expected"
    break
case let .some(value):
    "Age has the value of \(value)"
    break
}

// We can compare an optional value with another value. A simple comparison below there.
if age2 == 10 {
    "Age is 10 as expected, and is not nil"
}else {
    "Age2 is not 10. How strange ! "
}

// An alternative way of same example.

if age2 == .some(10) {
    "Age is 10 as expected and not nil"
}else {
    "Age is not 10. How strange !"
}

// Optional chaining. That means we optionally acces optional properties. An example below there. Optional within optional.
struct Person {
    let name : String
    let address : Address?
    struct Address {
        let firstLine : String?
    }
}

let jack: Person = Person(
    name: "Jack",
    address: nil
)

//if let is a way to safely unwrap an optional, meaning you only proceed with the block of code if the optional contains a value.
if let jackFirstAddressLine =
    jack.address?.firstLine{
    jackFirstAddressLine
}else {
    "Jack doesn't have an address with first line as expected."
}

if let jackAddress = jack.address,
   let firstLine = jackAddress.firstLine{
    jackAddress
    firstLine
}

let haley : Person? = Person(
    name: "Haley",
    address: Person.Address(firstLine: nil)
)

if haley?.name == "Haley",
   haley?.address?.firstLine == nil {
    "haley's name is Haley and has no first line of address"
}else {
    "Seems like something isnt working right"
}

// We can switch on options

let sarah : Person? = Person(
    name: "sarah",
    address: Person.Address(firstLine:"sarah's address firstline")
)
switch sarah?.address?.firstLine {//sarah?.address?.firsLine uses optional chaining to safely access sarah's address and its firsLine property.
//If either sarah is nil, or sarah?.address is nil, or sarah?.address?.firsLine is nil, the result of sarah?.address?.firsLine will be nil.
case let .some(firstLine) where
    firstLine.starts(with: "sarah's"): //This case checks if the firstLine is not nil (.some(firstLine)) and if it starts with "sarah's".
    "sarah first address line = \(firstLine)"
case let .some(firstLine): //This case catches all non-nil values for firstLine that did not match the previous condition.
    "sarah first address line that didnt match the previous case"
    firstLine
case .none://This case handles when the value of sarah?.address?.firstLine is nil.
    "Sarah first address line is nil ?? Weird !!"
}

/*
let optionalValue: Int? = nil

if let value = optionalValue {
    print("The value is \(value)")
}else{
    "this is nil"
}

*/

func getFullName(
    firstName: String,
    lastName : String?
)-> String?{
    if let lastName { // You have to have lastName !!!
    return "\(firstName) \(lastName)"
    } else{
        return nil
    }
}

getFullName(firstName: "Gülçin", lastName: "Çetin")
getFullName(firstName: "Gülçin", lastName: nil)

// We can also use guard let here.
func getFullName2(
    firstName: String,
    lastName : String?
)-> String? {
    guard let lastName else { // If there is no lastName then returns nil. 
        return nil
    }
    return "\(firstName) \(lastName)"
}







