//
//  NibNaming.swift
//  Test
//
//  Created by Artur Ryzhikh on 10.02.2022.
//
import Foundation

protocol NameIdentifiable {
    static var className: String { get }
}

extension NameIdentifiable {
    static var className: String {
        return String(describing: self)
    }
}
