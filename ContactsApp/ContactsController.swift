//
//  ContactsController.swift
//  ContactsApp
//
//  Created by Евгений Волчецкий on 1.02.23.
//

import UIKit
import Contacts

class ContactsController: UIViewController {
    
    let favouriteContactsController = FavoriteContacts()
    
    var showIndexPaths = false
    
    private lazy var addContactsButton: UIButton = {
        let addButton = UIButton()
        addButton.setTitle(Constants.addContactsButtonTitle, for: .normal)
        addButton.setTitleColor(.systemBlue, for: .normal)
        addButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        addButton.backgroundColor = .lightGray
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.isHidden = true
        addButton.addTarget(self, action: #selector(createAlert), for: .touchUpInside)
        addButton.titleLabel?.font = .systemFont(ofSize: 17)
        return addButton
    }()
    
    public lazy var contactsTableView: UITableView = {
        let contactsTableView = UITableView()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contactsTableView.register(ContactCell.self, forCellReuseIdentifier: Constants.tableViewCellId)
        contactsTableView.translatesAutoresizingMaskIntoConstraints = false
        return contactsTableView
    }()
    
    public lazy var defaultContactImage: UIImageView = {
        let contactImage = UIImageView()
        
        
        contactImage.contentMode = .scaleAspectFill
        contactImage.clipsToBounds = true

        return contactImage
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        addSubviews()
        addConstraints()
        setNavigationItem()
        fetchContacts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setRadiusButton()
        
        
    }
        
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        view.addSubview(addContactsButton)
        view.addSubview(contactsTableView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate(
        [
            addContactsButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            addContactsButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            addContactsButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            addContactsButton.heightAnchor.constraint(equalToConstant: view.frame.width / 5),
            
            contactsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contactsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contactsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contactsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func createAlert() {
        let alert = UIAlertController(title: "Add", message: "Add contacts", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    private func setRadiusButton() {
        addContactsButton.layer.cornerRadius = addContactsButton.frame.size.height / 2
    }
    
    private func setNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
    }
    
    @objc func handleShowIndexPath() {
        var indexPathToReload = [IndexPath]()
        
        for section in Constants.contacts.indices {
            for row in Constants.contacts[section].names.indices {
                print(section, row)
                let indexPath = IndexPath(row: row, section: section)
                indexPathToReload.append(indexPath)
            }
        }
        
        showIndexPaths = !showIndexPaths
        
        let animationStyle = showIndexPaths ? UITableView.RowAnimation.right : .left
        
        contactsTableView.reloadRows(at: indexPathToReload, with: animationStyle)
    }
    
    func someMethodIWantToCall(cell: ContactCell) {
    
        guard let indexPathTapped = contactsTableView.indexPath(for: cell) else { return }
        
        let contact = Constants.contacts[indexPathTapped.section].names[indexPathTapped.row]
        
        let hasFavorited = contact.hasFavorited
    
        Constants.contacts[indexPathTapped.section].names[indexPathTapped.row].hasFavorited = !hasFavorited
        
        if !hasFavorited {
            favouriteContactsController.contact.append(contact.contact)
            favouriteContactsController.favoriteContactTableView.reloadData()
        } else {
            favouriteContactsController.contact.removeLast()
            favouriteContactsController.favoriteContactTableView.reloadData()
        }
    
        cell.starButton.tintColor = hasFavorited ? .lightGray : .systemRed
    }
    
    func fetchContacts() {
        
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { granted, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    var favoritableContacts = [FavoritableContact]()
                    try store.enumerateContacts(with: request) { contact, stopPointerIFYouWantToStopEnumerating in
                        favoritableContacts.append(FavoritableContact(contact: contact, hasFavorited: false))
                    }
                    let names = ExpandableNames(isExpanded: true, names: favoritableContacts)
                    Constants.contacts = [names]
                } catch let error {
                    print(error.localizedDescription)
                }
            } else {
                print("Access denied..")
            }
        }
    }
}
