//
//  HomeDetailController.swift
//  FriendsProject
//
//  Created by LanceMacBookPro on 12/1/22.
//

import UIKit

final class HomeDetailController: UIViewController {
    
    // MARK: - Init
    init(friendName: String) {
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = friendName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    // MARK: - Deinit
    deinit {
        print("HomeDetailVC - DEINIT")
    }
}
