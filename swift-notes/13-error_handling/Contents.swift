import Foundation

struct Person {
    let firstName : String?
    let lastName : String?
    
    enum Errors : Error{
        case firstNameIsNil
        case lastNameIsNil
        case bothNamesAreNil
    }
    // pattern matching
    func getFullName() throws -> String {
        switch (firstName, lastName){
        case (.none, .none):
            throw Errors.bothNamesAreNil
        case (.none, .some):
            throw (Errors.firstNameIsNil)
        case (.some , .none):
            throw (Errors.lastNameIsNil)
        case let (.some(firstName), .some(lastName)):
            return "\(firstName) \(lastName)"
        }
    }
}

let firstPerson = Person(
    firstName: "Gülçin",
    lastName: nil
)

do {
    let fullName = try firstPerson.getFullName()
} catch {
    "Got an error = \(error)"
}// This catches any error.

// How we can catch specific errors =
let secondPerson = Person(
    firstName: nil,
    lastName: nil
)

do {
    let fullName = try secondPerson.getFullName()
    fullName
} catch Person.Errors.firstNameIsNil {
    "First name is nil"
} catch Person.Errors.lastNameIsNil {
    "Last name is nil"
}catch Person.Errors.bothNamesAreNil {
    "Both names are nil"
} catch {
    "Some other error was thrown"
}

// We can also throw errors inside Constructors of structures or classes. Below there is how we can define throwing initializers or constructures for structures and classes.

struct Car {
    let manufacturer : String
    
    enum Errors : Error{
        case invalidManufacturer
    }
    
    init (
        manufecturer : String
    ) throws {
        if manufecturer.isEmpty{
            throw Errors.invalidManufacturer
        }
        self.manufacturer = manufecturer
    }
}

do {
    let myCar = try Car(manufecturer: "")// The try keyword is used before calling the Car initializer because the initializer is marked with throws. This means the initializer might throw an error.
} catch Car.Errors.invalidManufacturer{
    "Invalid manufacturer"
}catch {
    "Some other error"
}

if let yourCar = try? Car(manufecturer://The try? keyword is used to attempt to create a Car object, but it will return nil if the initializer throws an error.If an error is thrown, the result is nil, and no error information is accessible (this is the main difference between try? and a regular try used with do-catch).
"Tesla") {
    "Success , your car = \(yourCar)"
}else {
    "Failed to construct and error is not accessible now"
}

/*
| Key Concepts |
throws in initializers: Allows an initializer to throw an error if certain conditions are not met.
try: Must be used when calling a throwing function or initializer to handle potential errors.
do-catch: Catches and handles errors explicitly.
try?: Safely handles errors by returning nil if an error is thrown, without propagating the error or making it accessible.
*/

struct Dog {
    let isInjured : Bool
    let isSleeping : Bool
    
    enum BarkingErrors : Error {
        case cannotBarkIsSleeping
    }
    
    enum RunningErrors : Error {
        case cannotRunIsInjured
    }
    
    func bark () throws {
        if isSleeping {
            throw BarkingErrors.cannotBarkIsSleeping
        }
        "Bark..."
    }
    
    func run () throws {
        if isInjured{
            throw RunningErrors.cannotRunIsInjured
        }
        "Run..."
    }
    
    func barkAndRun() throws {
        try bark()
        try run()
    }
}

let dog = Dog (
    isInjured: true,
    isSleeping: true
)

do {
    try dog.barkAndRun()
} catch Dog.BarkingErrors.cannotBarkIsSleeping,
        Dog.RunningErrors.cannotRunIsInjured {
    "Cannot-bark-is-sleeping OR cannot-run-is-injured"
} catch {
    "some other error"
}

// Function that internally calls another function which can also throw.

func fullName (
    firstName : String?,
    lastName: String?,
    fullName: (String? , String?) throws -> String?
) rethrows -> String? {
    try fullName(
        firstName,
        lastName
    )
}

enum NameErrors : Error {
    case firstNameIsInvalid
    case lastNameIsInvalid
}

func + (
    firstName : String?,
    lastName: String?
) throws -> String? {
    guard let firstName, // guard let means "Make sure firstname avaliable and first name is not nil.
        !firstName.isEmpty else {
        throw NameErrors.firstNameIsInvalid
    }
    guard let lastName,
        !lastName.isEmpty else {
        throw NameErrors.lastNameIsInvalid
    }
    return "\(firstName) \(lastName)" // If there is any error, you will never get here.
}

do {
    let personName = try fullName (
        firstName: "Gülçin" ,
        lastName: "Çetin",
        fullName: +
    )
} catch NameErrors.firstNameIsInvalid {
    "First name is invalid"
} catch NameErrors.lastNameIsInvalid {
    "Last name is invalid"
} catch let err {
    "Some other error = \(err) "
}

// It doesn't actually throw an error but it carries an error with it.We specifically say which error we're gonna carry with us. We usually use it in API calls. Its called as results.

enum IntegerErrors : Error {
    case noPositiveIntegerBefore(thisValue : Int)
}

func getPreviousPositiveInteger(
    //int is a parameter of the getPreviousPositiveInteger function. It's the input value that the function works on. When we call this function, you pass a value like 0 or 2 for int.
    from int: Int) -> Result<Int, IntegerErrors>{
    guard int > 0 else {
        return Result.failure(
            IntegerErrors.noPositiveIntegerBefore(
                //thisValue is an associated value of the IntegerErrors.noPositiveIntegerBefore enum case. When we create an error like IntegerErrors.noPositiveIntegerBefore , we can oass an integer to thisValue. In this code, its used to specify which value caused the error.
                thisValue: int
            )
        )
    }
    return Result.success(int - 1)
}

// Case Names: .success and .failure = These come from the Result type. How they work? Well , Result is an enum provided by Swift that represents either a success (.success) or a (.failure). It has two cases:1) .success(T)- This holds a value of type T, which in our case is an Int. 2) .failure(E)- This holds an error of type E, which in our case is IntegerErrors.                                                                                                           So when we see .success or .failure, we're using the cases of the Result enum. We don't need to define them because they are already part of the Swift standard library.

//forValue is a parameter label in the performGet(forValue :) function. It's how you refer to the parameter when you call the function. You can think of it as a "name" that makes the function call more readable.                                                                                                         For example, performGet(forValue: 2) makes it clear you're performing the operation for a specific value.

func performGet(forValue value: Int) {
    // value is a parameter of the performGet function. It's the input value for performGet. When we call performGet(forValue: 0) , the value 0 is passed to value.
    switch getPreviousPositiveInteger(from: value) {
    case let .success(previousValue):
        // previousValue is a local variable defined in the switch statement inside performGet. When the result of getPreviousPositiveInteger(from:) is .success, the value inside the .success case is assigned to previousValue. For example, when performGet(forValue : 2) is called, previousValue will be 1.
        "Previous value is \(previousValue)"
    case let .failure(error):
        switch error {
        case let .noPositiveIntegerBefore(thisValue):
            "No positive integer before \(thisValue)"
        }
    }
}

performGet(forValue: 0)
performGet(forValue: 2)

// Parameters (like int, value) are defined in function signatures. Associated values (like thisValue) are part of enum cases, defined when you declare the enum.
