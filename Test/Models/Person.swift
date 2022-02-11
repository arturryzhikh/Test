//
//  Person.swift
//  Test
//
//  Created by Artur Ryzhikh on 11.02.2022.
//

import Foundation

final class Person {
    var name: String?
    var age: Int? = nil
    var children: [Person] = []
    init(name: String? = nil, age: Int? = nil) {
        self.name = name
        self.age = age
    }
}
