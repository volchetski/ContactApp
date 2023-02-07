//
//  ContactsController + Ex.swift
//  ContactsApp
//
//  Created by Евгений Волчецкий on 1.02.23.
//

import Foundation
import UIKit

extension ContactsController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let button = UIButton(type: .system)
//        button.setTitle("Close", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//        button.backgroundColor = .yellow
//        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
//        button.tag = section
//        return button
//    }
//
//    @objc func handleExpandClose(button: UIButton) {
//
//        let section = button.tag
//        var indexPaths = [IndexPath]()
//        for row in Constants.twoDimensonalArray[section].names.indices {
//            print(0, row)
//            let indexPath = IndexPath(row: row, section: section)
//            indexPaths.append(indexPath)
//        }
//
//        let isExpanded = Constants.twoDimensonalArray[section].isExpanded
//        Constants.twoDimensonalArray[section].isExpanded = !isExpanded
//
//        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
//
//        if isExpanded {
//            contactsTableView.deleteRows(at: indexPaths, with: .fade)
//        } else {
//            contactsTableView.insertRows(at: indexPaths, with: .fade)
//        }
//    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return Constants.twoDimensonalArray.count
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return Constants.contacts[section].names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellId, for: indexPath) as? ContactCell else {
            fatalError("The tableview could not dequeue a CustomCell in ViewController")
        }
        
        cell.link = self
        let favoritableContact = Constants.contacts[indexPath.section].names[indexPath.row]
        if let contactImage = favoritableContact.contact.imageData {
            defaultContactImage.image = UIImage(data: contactImage)
            defaultContactImage.contentMode = .left
            defaultContactImage.sizeToFit()
        } else {
            defaultContactImage.image = UIImage(systemName: "person.crop.circle.fill")
        }
        
        cell.configure(text: favoritableContact.contact.givenName + " " + favoritableContact.contact.familyName,
                       descriptionText: (favoritableContact.contact.phoneNumbers.first?.value.stringValue)!, imageName: defaultContactImage.image!)
 
//        cell.accessoryView?.tintColor = favoritableContact.hasFavorited ? .systemRed : .lightGray
          cell.tintColor = .lightGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
