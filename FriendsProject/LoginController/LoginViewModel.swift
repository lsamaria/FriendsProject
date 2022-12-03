//
//  LoginViewModel.swift
//  FriendsProject
//
//  Created by LanceMacBookPro on 12/1/22.
//

import Foundation

final class LoginViewModel {
    
    // MARK: - Log User In
    func logUserIn(with emailText: String?, passwordText: String?, completion: @escaping (Result<Bool, FakeSessionError>)->Void) {
        
        guard let email = emailText, let password = passwordText else {
            completion(.failure(.emailOrPasswordIsNil))
            return
        }
        
        Service.shared.logUserInUsingFakeURLSession(email: email, password: password) { (result) in
            
            switch result {
            
            case .failure(let fakeSessionError):
                
                completion(.failure(fakeSessionError))
                
            case .success(_):
            
                completion(.success(true))
            }
        }
    }
}

// MARK: - Check TextFields Text
extension LoginViewModel {
    
    func isEmailTextFieldOrPasswordTextFieldEmpty(emailText: String?, passwordText: String?) -> Bool {
        
        guard let email = emailText, let password = passwordText else { return true }
        
        return email.trimmingCharacters(in: .whitespaces) == "" || password.trimmingCharacters(in: .whitespaces) == ""
    }
}

// MARK: - Create HomeVC
extension LoginViewModel {
    
    func createHomeVC() -> HomeController {
        
        let homeViewModel = HomeViewModel()
        let homeVC = HomeController(homeViewModel: homeViewModel)
        
        return homeVC
    }
}
