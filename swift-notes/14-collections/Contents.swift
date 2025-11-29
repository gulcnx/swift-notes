import Foundation

let numbers = [1, 2, 3, 4]
numbers.first
numbers.last
numbers.count
numbers.map(-)

var mutatingNumbers = [4 ,5 ,6 ]
mutatingNumbers.append(7)
mutatingNumbers.insert(3 , at:0) // insert = Arasına koymak
mutatingNumbers.insert(
    contentsOf: [1 ,2],
    at: 0
)

//This is how we would go through values inside an array.
for value in numbers{
    value
}

//We can enumerate through items inside an array with pattern matching using the where clause. For example if we want to grab all even number , we can do that :
for value in numbers where value % 2 == 0 {
    value
}

// We can map objects inside an array and mapping is also very important because it's one of the most useful functionalities of collections.             Mapping means that you take the values inside that collection and you turn them into something completely different if we want to. Example below there.

numbers.map {
    (value: Int) -> Int in
    value * 2
}

// An alternative way of coding but not recommended in large applications.
// numbers.map{ $0 * 2 }

// We can filter them.
numbers.filter{(value : Int)-> Bool in
    value >= 3
}

// Compact Mapping. They're similar to map but it returns an optional and the values that are returned from this compact map which are nil will not be included in the results. Compact map is a combination of map and filter.

numbers.compactMap{(value : Int)-> String? in
  value % 2 == 0
    ? String(value)
    : nil
}

// Arrays in Swift can contain the value of nil.

let numbers2: [Int?] = [1, 2, nil, 4, 5]
numbers2.count
let notNils = numbers2.filter{ (value: Int?) ->
    Bool in
    value != nil
} // Filter doesn't allow you to change the data type.

// In order to grab the non-null or not nil values out of this array and also change the data type, we have to use compact map.

let notNils2 = numbers2.compactMap{ (value :
Int?) -> Int? in
    value
}

// Arrays can include instances of the same object multiple times. It doesn't check whether they're unique or not.

let number3 = [1, 2 ,1, 2 ]
number3.count

//Arrays can be heterogeneous meaning that we can have integers and strings mixed up and blended up in the same array.

let stuff1 = [
    1,
    "hello",
    2,
    "world"
] as [Any]
stuff1.count

// An alternative way

let stuff2 : [Any] = [
    1,
    "hello",
    2,
    "world"
]
stuff2.count

// Sets = They only contains unique values. Hash values and equality based.

let uniqueNumbers = Set([1 , 2, 1, 2, 3])
uniqueNumbers.count
uniqueNumbers.map(-)
// Sets in Swift cannot guarantee ordering as you pass the ordering to it so ordering could just be mishmashed.

// Sets can also contains nils.
let myNumbers = Set([1, 2, 3, nil, 5])
let notNilNumbers = Set(
    myNumbers.compactMap { // Compact map what it does is if the values are nil, it removes them from their result.
        $0 // current value
    }
)
notNilNumbers

// We can create heterogeneous sets.

let stuff3 : Set<AnyHashable> = [
    1, 2, 3 , "Gülçin"
]
stuff3.count

// If we want to extract specific types out of these sets or arrays we can use a keyword which is called "as" .

// In Arrays
let intsInStuff1 = stuff1.compactMap{
        (value : Any) -> Int? in
        value as? Int
    }

let strsInStuff1 = stuff1.compactMap{
    (value : Any) -> String? in
    value as? String
    }

// In Sets
let instsInStuff3 = stuff3
    .compactMap { (value: AnyHashable)-> String? in
        value as? String
    }
// Compact mapping on a set doesn't return a set. It returns an array.
type(of: instsInStuff3)
type(of: stuff3)

// How sets are calculate uniqueness? The way it does, it's using a protocol called hashable. It contains a some sort of a hash value is an integer value that uniquely identifies every object. It also includes equality. Example below there.

struct Person : Hashable {
    let id : UUID
    let name : String
    let age : Int
}

let fooId = UUID()

let foo = Person(
    id: fooId,
    name: "Foo",
    age: 20
)

let bar = Person(
    id: fooId,
    name: "Bar",
    age: 30
)
let people : Set<Person> = [foo , bar]
people.count
//Identities are different and still its sets for 2 different values. But what we may want to tell is to Swift that "We actually don't want people with the same ID to be recognized as different people. If there are two people with the same ID then they're essentially the same person".

struct Person2 : Hashable {
    let id : UUID
    let name : String
    let age : Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // Only hashed ID. In terms of equation cuz hashing is also doing equality .
    }
    // We also need to change the way equality works.
    static func == (
        lhs : Self,
        rhs : Self
    ) -> Bool {
        lhs.id == rhs.id
    }
}

let bazId = UUID()
let baz = Person2(
    id: bazId,
    name: "baz",
    age: 30
)
let qux = Person2(
    id: bazId,
    name: "qux",
    age: 20
)

// We want to add them to a set.
let people2 = Set([baz , qux])
people2.count

if baz == qux {
    "They're equal" // This basically is invoking our equality.
}
// That's how we can go ahead and implement our own hash value and equality.

// |Dictionaries| They are keys and values.
let userInfo = [
    "name" : "Gülçin",
    "age" : 20 ,
    "address" : [
        "line1" : "Address line 1",
        "postCode" : "12345"
    ]
] as [String : Any]

// We can grab values out of our dictionaries.

userInfo["name"]
userInfo["age"]

userInfo.keys
userInfo.values

// If we want to grab every key and its associated value.
for (key , value) in userInfo {
    print(key)
    print(value)
}

// We can have a where clause in our enumeration over keys and values.

for (key, value) in userInfo where value is Int {
    if let intValue = value as? Int {
        print(key)
        print(intValue)
    }
}
// We can have multiple where clauses.

for (key, value) in userInfo where (value is Int) && (key.count > 2) {
    print(key)
    print(value)
}
