//
//  Dynamic.swift
//  Test
//
//  Created by Artur Ryzhikh on 17.02.2022.
//

import Foundation

final class Dynamic<Value>: Observable {
    
    typealias Observer = (Value) -> Void
    
    var observers: [Observer?] = []
    
    var value: Value {
        didSet { emitValue() }
    }
    
    init(_ value: Value) {
        self.value = value
    }
    deinit {
        print(description)
    }
    func emitValue() {
        observers.forEach { $0?(value) }
    }
}

extension Dynamic: CustomStringConvertible {
    
    var description: String {
            """
            <Observable<\(Value.self)>:\
             value: \(value),\
             observers count: \(observers.count)>
            """
    }
}


final class OptionalDynamic<Value>: OptionalObservable {
    
    var observers: [Observer?] = []
    typealias Observer = (Value?) -> Void
    
    var value: Value? {
        didSet { emitValue() }
    }
    
    init(_ value: Value? = nil) {
        self.value = value
    }
    
    func emitValue() {
        observers.forEach { $0?(value) }
    }
    
    func nullify() {
        value = nil
    }
}

extension OptionalDynamic: CustomStringConvertible {
    
    var description: String {
            """
            <Observable<\(Value.self)>:\
             value: \(String(describing: value)),\
            observers count: \(observers.count)>
            """
    }
    
}


protocol Observable: AnyObject {
    associatedtype Observer
    associatedtype Value
    var value: Value { get set }
    var observers: [Observer?] { get set }
    var hasObservers: Bool { get }
    func removeObservers()
    func addObserver(_ observer: Observer?)
    func addAndInvokeObserver(_ observer: Observer?)
    func emitValue()
}

protocol OptionalObservable: Observable {
    associatedtype OptionalValue
    var value: OptionalValue? { get set }
    func nullify()
}


extension Observable {
    
    var hasObservers: Bool {
        return !observers.isEmpty
    }
    
    func removeObservers() {
        observers.removeAll()
    }
    
    func addObserver(_ observer: Observer?) {
        observers.append(observer)
    }
    
    func addAndInvokeObserver(_ observer: Observer?) {
        self.addObserver(observer)
        emitValue()
    }
}
