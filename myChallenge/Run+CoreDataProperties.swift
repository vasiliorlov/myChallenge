//
//  Run+CoreDataProperties.swift
//  myChallenge
//
//  Created by iMac on 28.07.16.
//  Copyright © 2016 vasayCo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Run {

    @NSManaged var distance: NSNumber?
    @NSManaged var duration: NSNumber?
    @NSManaged var timestamp: NSDate?
    @NSManaged var locations: NSOrderedSet?

}
