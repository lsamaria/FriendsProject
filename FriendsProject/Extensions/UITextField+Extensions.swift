//
//  UITextField+Extensions.swift
//  FriendsProject
//
//  Created by LanceMacBookPro on 12/1/22.
//

import UIKit

extension UITextField {
    
    static func createTextField(delegate: UITextFieldDelegate, placeholderText: String, keyboardType: UIKeyboardType) -> UITextField {
        
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = delegate
        textField.placeholder = placeholderText
        textField.keyboardType = keyboardType
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 7
        textField.borderStyle = .roundedRect
        return textField
    }
}
