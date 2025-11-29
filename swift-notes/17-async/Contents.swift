import Foundation
import PlaygroundSupport
import _Concurrency

PlaygroundPage
    .current
    .needsIndefiniteExecution = true

func calculateFullName(
    firstName : String,
    lastName : String
) async -> String {
    try? await Task.sleep(for: .seconds(1))
    return "\(firstName) \(lastName)"
}

Task{
    let result1 = await calculateFullName(
        firstName: "Gülçin",
        lastName: "Çetin"
    )
    async let result2 = calculateFullName(
        firstName: "Gülçin",
        lastName: "Çetin"
    )
    await result2
}

enum Clothe {
    case socks, shirt, trousers
}

func buySocks() async throws -> Clothe {
    try await Task.sleep(for : .seconds(1))
    return Clothe.socks
}

func buyShirt() async throws -> Clothe {
    try await Task.sleep(for : .seconds(1))
    return Clothe.shirt
}

func buyTrousers() async throws -> Clothe {
    try await Task.sleep(for : .seconds(1))
    return Clothe.trousers
}

struct Ensemble: CustomDebugStringConvertible {
    let clothes : [Clothe]
    let totalPrice: Double
    
    var debugDescription: String {
        "Clothes = \(clothes), price= \(totalPrice)"
    }
}

func buyWholeEnsemble() async throws -> Ensemble {
    async let socks = buySocks()
    async let shirt = buyShirt()
    async let trousers = buyTrousers()
    
    let ensemble = Ensemble(
        clothes: await[
            try socks,
            try shirt,
            try trousers
        ], totalPrice: 200
    )
    return ensemble
}

Task {
    if let ensemble = try? await buyWholeEnsemble(){
        print(ensemble)
    }else {
        print("Something went wrong")
    }
}

// async let can only be used within asynchronous closures and asynchronous functions or wherever there is a task being run.

import Foundation

// Ensure the function is isolated to the MainActor to prevent data races
@MainActor
func getFullName(
    delay: Duration,
    calculator: @escaping () async -> String
) async -> String {
    try? await Task.sleep(for: delay)
    return await calculator()
}

func fullName() async -> String {
    "Gülçin Çetin"
}

// Task to call the main actor-isolated function
Task {
    let name = await getFullName(
        delay: .seconds(1)
    ) {
        return await fullName()  // Await the fullName function inside the closure
    }
    print(name)  // Safely access and print the name on the main thread
}












