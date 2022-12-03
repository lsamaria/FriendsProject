//
//  HomeController.swift
//  FriendsProject
//
//  Created by LanceMacBookPro on 12/1/22.
//

import UIKit

final class HomeController: UIViewController {
    
    // MARK: Init
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Ivars
    private let homeViewModel: HomeViewModel
    
    // MARK: UIElements
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.register(FriendCell.self, forCellWithReuseIdentifier: FriendCell.cellID)
        return collectionView
    }()
    
    private lazy var networkSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView.createActivityIndicatorView()
        spinner.center = view.center
        return spinner
    }()
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUILayout()
        
        fetchFriends()
    }
}

// MARK: - Fetch Friends
extension HomeController {
    
    private func fetchFriends() {
        
        networkSpinner.startAnimating()
        
        homeViewModel.fetchFriends { [weak self] (friends) in
            DispatchQueue.main.async { [weak self] in
                self?.display(friends)
            }
        }
    }
    
    private func display(_ friends: [Friend]) {
        
        networkSpinner.stopAnimating()
        
        collectionView.reloadData()
        
        if friends.isEmpty {
            showAlert(message: "No friends to show")
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCell.cellID, for: indexPath) as? FriendCell else {
            return UICollectionViewCell()
        }
        
        let friend = homeViewModel.datasource[indexPath.item]
        
        cell.friendCellViewModel = FriendCellViewModel(name: friend.name, email: friend.email)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = collectionView.frame.width
        let cellHeight: CGFloat = 75
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? FriendCell,
              let friendName = cell.friendCellViewModel?.name
        else { return }
        
        pushOnHomeDetailVC(with: friendName)
    }
}

// MARK: - Push On HomeDetailVC
extension HomeController {
    
    private func pushOnHomeDetailVC(with friendName: String) {
        
        let homeDetailVC = homeViewModel.createHomeDetailVC(with: friendName)
        navigationController?.pushViewController(homeDetailVC, animated: true)
    }
}

// MARK: - Setup UI Layout
extension HomeController {
    
    private func setupUILayout() {
        
        view.addSubview(collectionView)
        view.addSubview(networkSpinner)
    }
}
