import Foundation

// Generics are helping us to avoid writing same function or writing same code multiple times.

func perform<N: Numeric>(
    _ op :(N,N )-> N,
    on lhs : N,
    and rhs: N
)->N {
    op(lhs , rhs)
}

let x = perform(+ , on: 18.3 , and : 8.2)
x // Here, we can see that x is a double cuz compiler understand that these values are actually double.

perform(+ , on:10 , and: 30)
perform(-, on:78 , and : 78)
perform(*, on: 22, and: 11)
perform(/, on : 22 , and : 11)

//Alternative way of doing above instance.

func perform2<N>(
    _ op :(N,N )-> N,
    on lhs : N,
    and rhs: N
)->N where N: Numeric{
    op(lhs , rhs)
}

perform2(+ , on:10 , and: 30)
perform2(-, on:78 , and : 78)
perform2(*, on: 22, and: 11)
perform2(/, on : 22 , and : 11)

// Classes and structures in Swift can conform to multiple protocols.We can basically create generics that are conformant to multiple types.

protocol CanJump{
    func jump()
}

protocol CanRun{
    func run()
}

struct Person : CanJump , CanRun{
    func jump() {
        "Jumping..."
    }
    
    func run() {
        "Running..."
    }
}

func jumpAndRun<T : CanJump & CanRun>(_ value: T){
    value.jump()
    value.run()
}

let person = Person()
jumpAndRun(person)

// We can have extensions on generic types.

extension [String] {
    func longestString()-> String? {
        self.sorted {(lhs : String , rhs : String)-> Bool
            in lhs.count > rhs.count
        }.first
    }
}

[
    "jack",
    "clarke",
    "Lexa My Love"
].longestString()

//Generic Protocols

protocol View {
    func addSubView(_ view : View)
}//This defines a protocol called View. Any type that conforms to this protocol must implement a method addSubView(_:), which accepts another View.

extension View {
    func addSubView(_ view : View){
        // empty
    }
}//The extension provides a default (empty) implementation of addSubView(_:) for any type that conforms to View. If a conforming type doesn't provide its own implementation, it will use this default one.


struct Button : View {
    // empty
}

struct Table : View {
    // empty
}
//Button and Table are defined as structs, each conforming to the View protocol. Since they don't explicitly implement addSubView(_:), they will use the default empty implementation from the View extension.

protocol PresentableAsView {
    associatedtype ViewType : View
    //PresentableAsView is a protocol that works with any type that conforms to the View protocol (defined by associatedtype ViewType: View).
    func produceView()-> ViewType // produceView() – creates and returns a view.
    func configure(
        superView : View,
        thisView : ViewType
    )// configure(superView:thisView:) – allows custom configuration of the view hierarchy.
    func present(
        view : ViewType,
        on superView : View
    )// present(view:on:) – presents a view on a superview.
}

extension PresentableAsView {
    func configure(
        superView: View,
        thisView: ViewType
    ){
        // empty by default
    }
    func present(
        view : ViewType,
        on superView : View
    ){
        superView.addSubView(view)
    }
}// This extension provides default implementations for the configure and present methods. The default behavior of present is to add a view to the superView using addSubView(_:).

struct MyButton : PresentableAsView {
    func produceView() -> Button {
        Button()
    }// MyButton is a struct that conforms to PresentableAsView, where ViewType is inferred(means) to be Button because produceView() returns a Button.
    
    func configure(
        superView: View,
        thisView: Button
    ) {
        // The configure method here is empty but could be used to set up thisView (the button) in relation to superView.
    }
}

extension PresentableAsView where ViewType == Button {
    func doSomethingWithButton() {
        "This is a button"
    }// This is a conditional extension of PresentableAsView that only applies when ViewType is Button. It adds a method called doSomethingWithButton, which prints the message "This is a button".
    // Essentially, this method is only available for types that conform to PresentableAsView where the associated type is Button.
}

let button = MyButton()
button.doSomethingWithButton()

// This is how we can extend existing data types that are generic such as race.

extension [Int] {
    func average() -> Double {
        return Double(self.reduce(0, +)) / Double(self.count)
    }
}

[1, 2, 3, 4].average()






