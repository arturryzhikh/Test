//
//  ViewModel.swift
//  Test
//
//  Created by Artur Ryzhikh on 11.02.2022.
//

import Foundation

class ViewModel {
    //MARK: Messages
    var onError: ((_ message : String) -> Void)?
    var onReload: (() -> Void)?
    //
    enum Sections: Int {
        case person
        case children
    }
    
    var person = Person()
    
    func numberOfSections() -> Int {
        return (person.children.count > 0) ?  2 : 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        let section = Sections(rawValue: section)
        switch section {
        case .person:
            return 1
        case .children:
            return person.children.count
        case .none:
            return 0
        }
    }
    
    func setName(_ name: String?) {
        guard let name = name else { return }
        person.name = name
        
    }
    
    func setAge(_ age: String?) {
        guard let age = age else { return }
        person.age = age
    }
    
    func addChild() {
        guard person.children.count < 5 else {
            onError?("Упс! Вы можете добавить не более 5 детей")
            return
        }
        person.children.append(Person())
        onReload?()
    }
    
    func deleteChild(at index: Int) {
        person.children.remove(at: index)
        onReload?()
    }
    
    func clear() {
        person.children.removeAll(keepingCapacity: false)
        person.age = nil
        person.name = nil
        onReload?()
    }
    
}
