//
//  ViewModel.swift
//  Test
//
//  Created by Artur Ryzhikh on 11.02.2022.
//

import Foundation

class ViewModel {
    //MARK: Messages
    var onReload: EmptyCallback?
    //
    enum Sections: Int {
        case person
        case children
    }
    
    let person = Person()
    
    var numberOfSections: Int {
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
    
    func setName(_ name: String?, at indexPath: IndexPath) {
        guard
            let name = name ,
            let person = pickPerson(at: indexPath) else { return }
        person.name = name
    }
    
    func setAge(_ age: String?, at indexPath: IndexPath) {
        guard
            let age = age,
            let person = pickPerson(at: indexPath) else { return }
        person.age = age
        
    }
    
    func pickPerson(at indexPath: IndexPath) -> Person? {
        let section = Sections(rawValue: indexPath.section)
        switch section {
        case .person:
            return person
        case .children:
            return person.children[indexPath.row]
        case .none:
            return nil
        }
    }
    
    func addChild() {
         guard canAddChild else {
            onReload?()
            return
        }
        person.children.append(Person())
        onReload?()
    }
    
    var canAddChild: Bool {
        return person.children.count < 5
    }
    
    func deleteChild(at index: Int) {
        person.children.remove(at: index)
        onReload?()
    }
    
    func clear() {
        person.reset()
        onReload?()
    }
    
}
