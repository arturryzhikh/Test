//
//  RoundedButton.swift
//  Test
//
//  Created by Artur Ryzhikh on 11.02.2022.
//

import UIKit

class RoundedButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 30
        layer.borderColor = titleLabel?.textColor.cgColor
        layer.borderWidth = 1.0
        layer.masksToBounds = true
    }
}
