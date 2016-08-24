//
//  User+CoreDataProperties.swift
//  myChallenge
//
//  Created by iMac on 24.08.16.
//  Copyright © 2016 vasayCo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var uid: String?
    @NSManaged var photo: NSData?

}
