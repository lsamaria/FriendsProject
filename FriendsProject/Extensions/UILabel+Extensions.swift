//
//  UILabel+Extensions.swift
//  FriendsProject
//
//  Created by LanceMacBookPro on 12/1/22.
//

import UIKit

extension UILabel {
    
    static func createLabel(font: UIFont, textColor: UIColor = .black) -> UILabel {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.textColor = textColor
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        return label
    }
}
