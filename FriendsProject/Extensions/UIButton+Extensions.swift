//
//  UIButton+Extensions.swift
//  FriendsProject
//
//  Created by LanceMacBookPro on 12/1/22.
//

import UIKit

extension UIButton {
    
    static func createButton(title: String, bgColor: UIColor, alpha: CGFloat) -> UIButton {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = bgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 7
        button.isEnabled = false
        button.alpha = alpha
        return button
    }
}
