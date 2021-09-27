// https://stackoverflow.com/questions/46018677/what-is-where-self-in-protocol-extension
import UIKit

protocol Meh {
    func doSomething()
}

// Extend protocol Meh, where `Self` is of type `UIViewController`
// func blah() will only exist for classes that inherit `UIViewController`.
// In fact, this entire extension only exists for `UIViewController` subclasses.

extension Meh where Self: UIViewController {
    func blah() {
        print("Blah")
    }

    func foo() {
        print("Foo")
    }
}

class Foo : UIViewController, Meh { //This compiles and since Foo is a `UIViewController` subclass, it has access to all of `Meh` extension functions and `Meh` itself. IE: `doSomething, blah, foo`.
    func doSomething() {
        print("Do Something")
    }
}

class Obj : NSObject, Meh { //While this compiles, it won't have access to any of `Meh` extension functions. It only has access to `Meh.doSomething()`.
    func doSomething() {
        print("Do Something")
    }
}
// 以下では、ObjがMeh拡張関数にアクセスできないため、コンパイラエラーが発生します。
let i = Obj()
i.blah()

// しかし、以下は機能します。
let j = Foo()
j.blah()
// つまり、Meh.blah()はタイプがのクラスでのみ使用できますUIViewController。
