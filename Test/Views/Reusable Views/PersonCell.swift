//
//  PersonCell.swift
//  Test
//
//  Created by Artur Ryzhikh on 10.02.2022.
//

import UIKit

class PersonCell: UITableViewCell, NameIdentifiable {
    
    @IBOutlet  var backgrounds: [UIView]!
    
    @IBOutlet  var nameTextField: UITextField!
    
    @IBOutlet  var ageTextField: UITextField!
    
    @IBAction  func textFieldTextDidChange(_ textField: UITextField) {
        print(textField.text)
    }
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    //MARK: Messages
    var nameChanged: ((String) -> Void)?
    var ageChanged: ((String) -> Void)?
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        backgrounds.forEach {
            $0.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.masksToBounds = true
          
        }
       
    }
    
}

extension PersonCell: UITextFieldDelegate {
    
    
}
