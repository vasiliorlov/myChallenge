//
//  Challenge+CoreDataProperties.swift
//  myChallenge
//
//  Created by iMac on 12.08.16.
//  Copyright © 2016 vasayCo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Challenge {

    @NSManaged var id: String?
    @NSManaged var ownId: String?
    @NSManaged var name: String?
    @NSManaged var date: String?
    @NSManaged var dist: String?

}
