//
//  PersonFooter.swift
//  Test
//
//  Created by Artur Ryzhikh on 11.02.2022.
//

import UIKit

class PersonFooter: UITableViewHeaderFooterView, NameIdentifiable {
    @IBOutlet weak var addButton: UIButton!
    override func layoutSubviews() {
        super.layoutSubviews()
        addButton.layer.borderColor = #colorLiteral(red: 0, green: 0.6808999181, blue: 0.9780741334, alpha: 1)
        addButton.layer.cornerRadius = 30
        addButton.layer.borderWidth = 2.0
        addButton.layer.masksToBounds = true
        
    }
}
