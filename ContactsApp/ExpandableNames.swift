//
//  ExpandableNames.swift
//  ContactsApp
//
//  Created by Евгений Волчецкий on 2.02.23.
//

import Foundation
import Contacts

struct ExpandableNames {
    
    var isExpanded: Bool
    var names: [FavoritableContact]
}

struct FavoritableContact {
    let contact: CNContact
    var hasFavorited: Bool = false
}
