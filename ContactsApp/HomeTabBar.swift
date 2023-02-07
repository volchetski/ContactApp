//
//  TabBarController.swift
//  ContactsApp
//
//  Created by Евгений Волчецкий on 1.02.23.
//
import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties

    private let contactsController = ContactsController()
    private let favouriteController = FavoriteContacts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupVCs()
    }
    
    // MARK: - Methods
    
    private func setupVCs() {
        viewControllers = [
            createNavController(for: contactsController, title: Constants.contactsTitle, image: UIImage(systemName: Constants.contactsTabBarImageName)),
            createNavController(for: favouriteController, title: Constants.favouriteContactsTitle, image: UIImage(systemName: Constants.favouriteContactsTabBarImageName))
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
}
