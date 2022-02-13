//
//   KeyboardRelatedConstraintAnimator.swift
//  Test
//
//  Created by Artur Ryzhikh on 13.02.2022.
//

import UIKit

/// Animate and modify constraint's constant when keyboard appears, changes frames or disappears.
/// Use-case: move content above keyboard when it appears.
class KeyboardRelatedConstraintAnimator {
    unowned let constraint: NSLayoutConstraint
    unowned let view: UIView
    
    private var defaultValue: CGFloat
    
    /// - note: Keyboard notifications observers are added on init and removed on deinit
    ///
    /// - Parameters:
    ///   - constraint: *(unowned)* constraint wich constant will be modified on keyboard animations, class respect's constraint's default constant, it is saved on initialization
    ///   - view: *(unowned)* view owning constraint, animations will be performed in that view
    init(constraint: NSLayoutConstraint, in view: UIView) {
        self.constraint = constraint
        self.defaultValue = constraint.constant
        self.view = view
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: .main) { [weak self] (notification) in
            self?.animate(notification: notification, willHide: false)
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { [weak self] (notification) in
            self?.animate(notification: notification, willHide: true)
        }
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func animate(notification: Notification, willHide: Bool) {
        guard let userInfo = notification.userInfo,
              let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let keyboardEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let rawAnimationCurveNumber = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        
        let rawAnimationCurve = rawAnimationCurveNumber.uint32Value << 16
        let animationCurve = UIView.AnimationOptions(rawValue: UInt(rawAnimationCurve))
        
        self.constraint.constant = willHide ? self.defaultValue : keyboardEndFrame.height + self.defaultValue
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: [UIView.AnimationOptions.beginFromCurrentState, animationCurve], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
