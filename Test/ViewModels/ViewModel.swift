//
//  ViewModel.swift
//  Test
//
//  Created by Artur Ryzhikh on 11.02.2022.
//

import Foundation

final class ViewModel {
    
    enum Sections: Int {
        case person
        case children
    }
   
    var person = Person()
    
    final func numberOfSections() -> Int {
        return (person.children.count > 0) ?  2 : 1
    }
    
    final func numberOfRowsInSection(_ section: Int) -> Int {
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
    
    
}
