//
//  HomeViewModel.swift
//  FriendsProject
//
//  Created by LanceMacBookPro on 12/1/22.
//

import Foundation

final class HomeViewModel {
    
    var datasource = [Friend]()
}

// MARK: - Fetch Friends
extension HomeViewModel {
    
    func fetchFriends(_ completion: @escaping ([Friend])->Void) {
        
        Service.shared.fetchAPIObjectUsingFakeURLSession { [weak self](result) in
            
            switch result {
            
            case .failure(let fakeSessionError):
                
                print("\nFake-Server-Response-Fetching-Friends-Error: ", fakeSessionError)
                
                completion([])
                
            case .success(let friends):
                
                DispatchQueue.main.async { [weak self] in
                    self?.datasource = friends
                    
                    completion(friends)
                }
            }
        }
    }
}

// MARK: - Create HomeDetailVC
extension HomeViewModel {
    
    func createHomeDetailVC(with friendName: String) -> HomeDetailController {
        let homeDetailVC = HomeDetailController(friendName: friendName)
        return homeDetailVC
    }
}
