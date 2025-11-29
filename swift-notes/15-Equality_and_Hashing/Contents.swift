import Foundation

struct Person: Equatable {
    let id : String
    let name : String
}

let firstPerson = Person (
    id: "1",
    name: "Gülçin"
)

let secondPerson = Person (
    id: "1",
    name: "Lexa"
)

if firstPerson == secondPerson {
    "They are equal !"
} else {
    "They aren't equal"
}
// We can override equality.                                                                                                                                 We can basically say any two persons that have the same identifier should be considered equal.
extension Person {
    static func == (
        lhs : Self,
        rhs : Self
    ) -> Bool {
        lhs.id == lhs.id
    }
}
// a static function is a function that belongs to a type itself (such as a struct, class, or enum), rather than to instances of that type. This means you can call the function on the type itself, without needing to create an instance of that type.

// We can implement custom equality on enumerations.

enum AnimalType: Equatable {
    case dog(breed: String)
    case cat(breed : String)
}

/*
extension AnimalType : Equatable {
    static func == (
        lhs : Self,
        rhs : Self
    )-> Bool {
        switch (lhs, rhs) {
        case let (.dog(lhsBreed), .dog(rhsBreed)),
            let (.cat(lhsBreed), .cat(breed: rhsBreed)):
            return lhsBreed == rhsBreed
        default:
            return false
        }
    }
}*/

struct Animal : Equatable {
    let name : String
    let type : AnimalType
    
    static func == (
        lhs : Self,
        rhs : Self
    )-> Bool {
        lhs.type == rhs.type
    }
}
let cat1 = Animal (
    name: "Whiskers",
    type: .cat(
        breed: "Street cat"
    )
)

let cat2 = Animal(
    name: "Whoosh",
    type: .cat(
        breed: "Street cat"
    )
)

if cat1 == cat2 {
    "They're equal because of their type"
}else {
    "They aren't equal"
}

// Hashable Protocol
struct House : Hashable {
    let number : Int
    let numberOfBedrooms: Int
}

let house1 = House (
    number : 123,
    numberOfBedrooms: 2
)
house1.hashValue

let house2 = House(
    number : 123,
    numberOfBedrooms: 3
)
house2.hashValue

let houses = Set([house1 , house2])
houses.count

// We can overwrite a hashing mechanism.

struct NumberedHouse : Hashable {
    let number : Int
    let numberOfBedrooms : Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(number) // This doesn't mean that they're equal.
    }
    
    static func == (
        lhs : Self,
        rhs : Self
    )-> Bool {
        lhs.number == rhs.number
    } // In this case, two houses are considered equal if their number properties are equal.If numberOfBedrooms is also important for distinguishing between houses, you should include it in both the hash(into:) function and the equality check.
    
}

let house3 = NumberedHouse (
    number: 123,
    numberOfBedrooms: 2
)

let house4 = NumberedHouse (
    number: 123,
    numberOfBedrooms: 3
)

let house3And4 = Set([house3 , house4])
house3And4.count // Its basically 1 cuz hashing depending on number value.


// Enums are by default hashable even without raw values.
enum CarPart {
    case roof
    case tire
    case trunk
}

let uniqueParts: Set<CarPart> = [
    .roof,
    .tire,
    .roof,
    .trunk
]// It doesnt contain two roofs, that's the point.
//If we create a simple enum in Swift without any raw values or any associated values , it's by default hashable and equitable.


// If we have an enum with associated values, Then we can basically go ahead and change the hashing mechanism by ourself.

enum HouseType: Hashable {
    case bigHouse(NumberedHouse)
    case smallHouse(NumberedHouse)
}
// Add these into some sort of a set.
let bigHouse1 = HouseType
    .bigHouse(
        NumberedHouse(
            number: 1,
            numberOfBedrooms: 1
        )
    )

let bigHouse2 = HouseType
    .bigHouse(
        NumberedHouse(
            number: 1,
            numberOfBedrooms: 1
        )
    )

let smallHouse1 = HouseType
    .smallHouse(
        NumberedHouse(
            number: 1,
            numberOfBedrooms: 1
        )
    )

let allHouses : Set<HouseType> = [
    bigHouse1,
    bigHouse2,
    smallHouse1
]
allHouses.count
// The reason behind that, bigHouse1 and bigHouse2 are considered to have the same hash value.
