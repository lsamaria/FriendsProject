//
//  Service.swift
//  FriendsProject
//
//  Created by LanceMacBookPro on 12/1/22.
//

import UIKit

final class Service {
    
    static let shared = Service()
    
    private init() { }
    
    private let delay = 0.5
    
    private let passwordCharCountMinimum = 6
}

enum FakeSessionError: Error {
    case emailOrPasswordIsNil
    case invalidEmailAddress
    case passwordTooShort
    case jsonBundlePathIsNil
    case dataContents(Error)
    case malformedData(Error)
}

// MARK: - Authenticate User
extension Service {
    
    func logUserInUsingFakeURLSession(email: String, password: String, completion: @escaping (Result<Bool, FakeSessionError>)->Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let weakSelf = self else { return }
            
            if !weakSelf.validate(email) {
                completion(.failure(.invalidEmailAddress))
                return
            }
            
            if password.count < weakSelf.passwordCharCountMinimum {
                completion(.failure(.passwordTooShort))
                return
            }
            
            completion(.success(true))
        }
    }
    
    private func validate(_ email: String) -> Bool {
        let emailRegexRules = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegexRules)
        return predicate.evaluate(with: email)
    }
}

// MARK: - Fetch Friends
extension Service {
    
    func fetchAPIObjectUsingFakeURLSession(_ completion: @escaping (Result<[Friend],FakeSessionError>)->Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            
            do {
                
                guard let path = Bundle.main.path(forResource: "Response", ofType: "json") else {
                    completion(.failure(.jsonBundlePathIsNil))
                    return
                }
                
                let fileURL = URL(fileURLWithPath: path)
                
                let data = try Data(contentsOf: fileURL)
                
                do {
                    
                    let friendsWrappr = try JSONDecoder().decode(FriendWrapper.self, from: data)
                    
                    completion(.success(friendsWrappr.friends))
                    
                } catch {
                    
                    completion(.failure(.malformedData(error)))
                }
                
            } catch {
                completion(.failure(.dataContents(error)))
            }
        })
    }
}
