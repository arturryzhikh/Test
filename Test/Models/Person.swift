//
//  Person.swift
//  Test
//
//  Created by Artur Ryzhikh on 11.02.2022.
//

import Foundation

class Person {
    
    var name: String?
    var age: String?
    var children: [Person] = []
    
    init(name: String? = nil, age: String? = nil) {
        self.name = name
        self.age = age
    }
    
    
}

extension Person: CustomStringConvertible {
    var description: String {
        return """
        <Person>: name: \(name ?? "nil"), age: \(age ?? "nil"),\
         count of children: \(children.count),\
         children: \(children.map {$0.description })
        """
    }
    
    
}
