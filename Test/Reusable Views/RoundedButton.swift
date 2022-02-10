//
//  RoundedButton.swift
//  Test
//
//  Created by Artur Ryzhikh on 11.02.2022.
//

import UIKit
@IBDesignable class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: Int {
        get {
            return Int(layer.cornerRadius)
        }
        set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.gray.cgColor)
        }
        
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = CGFloat(cornerRadius)
        layer.borderWidth = 2.0
        layer.masksToBounds = true
    }
}
