//
//  FavouriteContacts.swift
//  ContactsApp
//
//  Created by Евгений Волчецкий on 1.02.23.
//

import UIKit
import Contacts

class FavoriteContacts: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var contact = [CNContact]() {
        didSet {
            DispatchQueue.main.async {
                self.favoriteContactTableView.reloadData()
            }
        }
    }
    
    public lazy var favoriteContactTableView: UITableView = {
        let contactsTableView = UITableView()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contactsTableView.register(ContactCell.self, forCellReuseIdentifier: Constants.favoriteTableViewCellId)
        contactsTableView.translatesAutoresizingMaskIntoConstraints = false
        return contactsTableView
    }()
    
    public lazy var defaultContactImage: UIImageView = {
        let contactImage = UIImageView()
        
        contactImage.contentMode = .scaleAspectFit
        return contactImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        addConstraints()
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        favoriteContactTableView.reloadData()
    }
    
    private func addSubviews() {
        view.addSubview(favoriteContactTableView)
        view.addSubview(defaultContactImage)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate(
        [
            favoriteContactTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteContactTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favoriteContactTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            favoriteContactTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
