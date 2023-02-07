//
//  FavoriteContacts + Ex.swift
//  ContactsApp
//
//  Created by Евгений Волчецкий on 6.02.23.
//

import Foundation
import UIKit

extension FavoriteContacts {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = ContactCell(style: .subtitle, reuseIdentifier: Constants.favoriteTableViewCellId)
        
        if let contact = contact[indexPath.row].imageData {
            defaultContactImage.image = UIImage(data: contact)
        } else {
            defaultContactImage.image = UIImage(systemName: "person.crop.circle.fill")
        }
        
        cell.configure(text: contact[indexPath.row].givenName, descriptionText: (contact[indexPath.row].phoneNumbers.first?.value.stringValue)!, imageName: defaultContactImage.image!)
        
        return cell
    }
}
