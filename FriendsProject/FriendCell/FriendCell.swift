//
//  FriendCell.swift
//  FriendsProject
//
//  Created by LanceMacBookPro on 12/1/22.
//

import UIKit

final class FriendCell: UICollectionViewCell {
    
    // MARK: UIElements
    private lazy var nameLabel: UILabel = {
        let label = UILabel.createLabel(font: UIFont.systemFont(ofSize: 21), textColor: .black)
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel.createLabel(font: UIFont.systemFont(ofSize: 19), textColor: .systemTeal)
        return label
    }()
    
    private lazy var separatorLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: - Ivars
    static let cellID = "FriendCellID"
    
    var friendCellViewModel: FriendCellViewModel? {
        didSet {
            guard let friendCellViewModel = friendCellViewModel else { return }
            
            setTextForNameLabelAndEmailLabel(from: friendCellViewModel)
            
            friendCellViewModel.setNameTxtAndEmailTxt()
            
            setupUILayout()
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("init(coder:) has not been implemented")
    }
}

// MARK: - Set NameLabel & EmailLabel
extension FriendCell {
    
    private func setTextForNameLabelAndEmailLabel(from friendCellViewModel: FriendCellViewModel) {
        
        friendCellViewModel.nameTxt = { [weak self] (name) in
            self?.nameLabel.text = name
        }
        
        friendCellViewModel.emailTxt = { [weak self] (email) in
            self?.emailLabel.text = email
        }
    }
}

// MARK: - LayoutUI
extension FriendCell {
    
    private func setupUILayout() {
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(separatorLineView)
        
        let padding: CGFloat = 8
        
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        
        let separatorLineViewHeight: CGFloat = 0.5
        
        separatorLineView.heightAnchor.constraint(equalToConstant: separatorLineViewHeight).isActive = true
        separatorLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separatorLineView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        separatorLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}
