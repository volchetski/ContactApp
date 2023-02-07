//
//  ContactCell.swift
//  ContactsApp
//
//  Created by Евгений Волчецкий on 1.02.23.
//

import UIKit

class ContactCell: UITableViewCell {
    
    weak var link: ContactsController?
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.clipsToBounds = true
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var itemImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 35
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    public lazy var starButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.nameOfFavouriteImage), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleMarkAsFavourite), for: .touchUpInside)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(itemImage)
        containerView.addSubview(nameLabel)
        containerView.addSubview(descriptionLabel)
        contentView.addSubview(containerView)
        contentView.addSubview(starButton)
        
//        let starButton = UIButton(type: .system)
//        starButton.setImage(UIImage(systemName: Constants.nameOfFavouriteImage), for: .normal)
//        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//
//        starButton.tintColor = .red
//        starButton.addTarget(self, action: #selector(handleMarkAsFavourite), for: .touchUpInside)
//        accessoryView = starButton
        
        NSLayoutConstraint.activate(
            [
                itemImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                itemImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  10),
                itemImage.widthAnchor.constraint(equalToConstant: contentView.frame.height * 1.5),
                itemImage.heightAnchor.constraint(equalToConstant: contentView.frame.height * 1.5),
                
                containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                containerView.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 10),
                containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                containerView.heightAnchor.constraint(equalToConstant: contentView.frame.height),
                
                nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
                nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                
                descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
                descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                
//                starButton.widthAnchor.constraint(equalToConstant: 26),
//                starButton.heightAnchor.constraint(equalToConstant: 26),
                starButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                starButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ]
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(text: String, descriptionText: String, imageName: UIImage) {
        nameLabel.text = text
        descriptionLabel.text = descriptionText
        itemImage.image = imageName
        
    }
    
        @objc private func handleMarkAsFavourite() {
            link?.someMethodIWantToCall(cell: self)
        }
}
