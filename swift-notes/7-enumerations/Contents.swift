import Foundation

enum Animals {
    case lizard, snake , bird
}
let animal1 = Animals.lizard
animal1

switch animal1 {
case .lizard:
    "this is a lizard"
    break
case .snake:
    "this is a snake"
    break
case .bird:
    "this is a bird"
    break
// not a good idea
/*default:
    "This is something else"*/
}

// ASSOCIATED VALUES

enum Shortcut {
    case fileOrFolder(path : URL , name : String)
    case wwwUrl(path : URL)
    case song(artist : String, songName : String)
}
let wwwApple = Shortcut.wwwUrl(
    path : URL(string : "https://apple.com")!
)

switch wwwApple {
case let .fileOrFolder(
    path,
    name
):
    path
    name
    break
case let .wwwUrl(path):
    path
    break
case let.song(
    artist,
    songName
):
    artist
    songName
    break
}

if case let .wwwUrl(path) = wwwApple {
    path
}

let withoutYou = Shortcut.song(
    artist: "Symphony X"
    , songName: "Without You"
)

if case let .song(_,songName) = withoutYou{
    songName
}

/*
enum Vehicle {
    case car (manufacturer :String , model : String)
    case bike (manufacturer : String , yearMade : Int)
}

func getManufacturer(from vehicle: Vehicle)-> String{
    switch vehicle {
    case .car(let manufacturer,_):
        return manufacturer
    case .bike(let manufacturer,_):
        return manufacturer
    }
}

let car = Vehicle.car(manufacturer: "Tesla", model: "X")
let bike = Vehicle.bike(manufacturer: "HD", yearMade: 1987)

getManufacturer(from: bike)
getManufacturer(from: car)
*/

/*
enum Vehicle {
    case car (manufacturer :String , model : String)
    case bike (manufacturer : String , yearMade : Int)
    func getManufacturer()-> String{
        switch self {
        case .car(let manufacturer,_):
            return manufacturer
        case .bike(let manufacturer,_):
            return manufacturer
        }
    }
}

let car = Vehicle.car(manufacturer: "Tesla", model: "X")
let bike = Vehicle.bike(manufacturer: "HD", yearMade: 1987)

car.getManufacturer()
bike.getManufacturer()
*/
/*
enum Vehicle {
    case car (manufacturer :String , model : String)
    case bike (manufacturer : String , yearMade : Int)
    var manufacturer : String{
        switch self {
        case .car(let manufacturer,_):
            return manufacturer
        case .bike(let manufacturer,_):
            return manufacturer
        }
    }
}

let car = Vehicle.car(manufacturer: "Tesla", model: "X")
let bike = Vehicle.bike(manufacturer: "HD", yearMade: 1987)

car.manufacturer
bike.manufacturer
*/

enum Vehicle {
    case car (manufacturer :String , model : String)
    case bike (manufacturer : String , yearMade : Int)
    var manufacturer : String{
        switch self {
        case let .car(manufacturer, _),
            let .bike(manufacturer,_):
            return manufacturer
        }
    }
}

let car = Vehicle.car(manufacturer: "Tesla", model: "X")
let bike = Vehicle.bike(manufacturer: "HD", yearMade: 1987)

car.manufacturer
bike.manufacturer

// RAW VALUES

enum FamilyMember : String{
    case father = "Dad"
    case mother = "Mom"
    case brother = "Bro"
    case sister = "Sis"
}
FamilyMember(rawValue: "Dad")
//or
FamilyMember.father.rawValue

// How to extract all cases

enum FavoriteEmoji : String, CaseIterable {
    case tree = "🌲"
    case brook = "🏞️"
    case sky = "🌄"
}

FavoriteEmoji.allCases
FavoriteEmoji.allCases.map(\.rawValue)

if let tree = FavoriteEmoji(rawValue: "🌲"){
    "Found the tree emoji"
    tree.rawValue
}else{
    
    "This emoji doesnt exist"
}

//MUTATING MEMBERS OF ENUMERATİONS

enum Height {
    case short , medium , long
    mutating func makeLong(){
        self = Height.long
    }
}

var myHeight = Height.medium
myHeight.makeLong()
myHeight

// RECURSIVE||INDIRECT ENUMERATIONS

indirect enum IntOperation {
    case add(Int , Int)
    case subtract (Int, Int)
    case freeHand(IntOperation)
    
    func calculateResult(
        of operation : IntOperation? = nil
    )->Int{
        switch operation ?? self {
        case let .add(lhs, rhs):
            return lhs + rhs
        case let .subtract(lhs, rhs):
            return lhs - rhs
        case let .freeHand(operation):
            return calculateResult (of : operation)
            
        }
    }
}

let freeHand = IntOperation.freeHand(.add(3, 5))
freeHand.calculateResult()
