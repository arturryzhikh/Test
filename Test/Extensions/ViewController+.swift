//
//  ViewController+.swift
//  Test
//
//  Created by Artur Ryzhikh on 11.02.2022.
//

import UIKit

extension UIViewController {
    ///Dismisses keyboard when touching outside
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer( target: self, 
                                         action: #selector(UIViewController.dismissKeyboardTouchOutside))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
}
