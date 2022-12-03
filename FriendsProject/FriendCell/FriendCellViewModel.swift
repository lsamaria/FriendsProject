//
//  FriendCellViewModel.swift
//  FriendsProject
//
//  Created by LanceMacBookPro on 12/1/22.
//

import Foundation

final class FriendCellViewModel {
    
    var nameTxt: ((String)->Void)?
    var emailTxt: ((String)->Void)?
    
    var name: String
    var email: String
    
    init(name: String?, email: String?) {
        self.name = name?.capitalized ?? "Name Unavailable"
        self.email = email ?? "Email Unavailable"
    }
}

extension FriendCellViewModel {
    
    func setNameTxtAndEmailTxt() {
        nameTxt?(name)
        emailTxt?(email)
    }
}
