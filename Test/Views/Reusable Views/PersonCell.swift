//
//  PersonCell.swift
//  Test
//
//  Created by Artur Ryzhikh on 10.02.2022.
//

import UIKit

class PersonCell: UITableViewCell, NameIdentifiable {
    
    //MARK: Messages
    var nameChanged: ((String?) -> Void)?
    var ageChanged: ((String?) -> Void)?
    //MARK: Outlets
    @IBOutlet  var backgrounds: [UIView]!
    
    @IBOutlet  var nameTextField: UITextField!
    
    @IBOutlet  var ageTextField: UITextField!
    
   
    @IBAction  func textFieldTextDidChange(_ textField: UITextField) {
        if textField === nameTextField {
            nameChanged?(textField.text)
        } else if textField === ageTextField {
            ageChanged?(textField.text)
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        backgrounds.forEach {
            $0.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.masksToBounds = true
          
        }
       
    }
    
}
