//
//  PersonFooter.swift
//  Test
//
//  Created by Artur Ryzhikh on 11.02.2022.
//

import UIKit

class PersonFooter: UITableViewHeaderFooterView, NameIdentifiable {
    
    var addChildAction: EmptyCallback?
    
    @IBAction func addButtonTapped() {
        addChildAction?()
    }
   
}
