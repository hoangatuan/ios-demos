#  Closure: When it captures/release object?

Take a look at this example and answer these questions:

1. Will the log "Result is: \(result)" be triggered?
2. If yes, then why it can be triggered even if there is not reference to object B?

```swift
class A {
    let create: () -> B
    
    init(create: @escaping () -> B) {
        self.create = create
    }
    
    func startCreate() {
        let b = create()
        debugPrint("Created B object at: \(Date().timeIntervalSince1970)")
    }
}

class B {
    deinit {
        debugPrint("deinit B at: \(Date().timeIntervalSince1970)")
    }
    public typealias Promise = (Int) -> Void
    
    init(_ closure: @escaping (@escaping Promise) -> Void) {
        closure(self.promise)
    }
    
    private func promise(_ result: Int) -> Void {
        debugPrint("Result is: \(result)")
    }
}

let a = A {
    B { promise in
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            promise(10)
        }
    }
}

a.startCreate()
```

========================================================================================================

# Answer

1. Yes
2. The reason is:
    - We have a strong ref to object A
    - Object A has a strong ref to `create` closure
    - when we trigger the `create` closure => we will create B => in the init of B class, the closure start capturing the object B through the `closure(self.promise)`
    - The closure only release object B when the closure finish execution (delay deinit) 
    - We will not have any retain cycle here since we dont have any strong ref to the 2nd closure.
    

Demonstrate through 3 examples:

1. By using DispatchQueue.main.async { self... } => Actually this closure will keep a strong ref to the VC2 until the block finish execution
2. Similar, even if we use a @escaping closure to capture itself, as long as there is no retain cycle, after the closure finish execution => automatic release vc2
