//
//  DBInspector.swift
//  myChallenge
//
//  Created by iMac on 29.07.16.
//  Copyright © 2016 vasayCo. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import Firebase

@objc protocol DBInspetorDelegateListChallenge {
    optional func reloadChallenge()
}

struct filter{
    static let all = 0
    static let my = 1
    static let friends = 2
}


class DBInspector: NSObject {
    
    static let sharedInstance = DBInspector()
    var dbInspectorListCh:DBInspetorDelegateListChallenge?
    
    //MARK: - work with challenge table
    
    func saveChallenge(challenge:ChallengeObj){
        
        let queue = dispatch_queue_create("com.vasili.arlou.myChallenge",DISPATCH_QUEUE_SERIAL)
        dispatch_async(queue) {
            
            let savedChallenge = NSEntityDescription.insertNewObjectForEntityForName("Challenge", inManagedObjectContext: self.managedObjectContext) as! Challenge
            savedChallenge.id = challenge.id
            savedChallenge.ownId = challenge.ownId
            savedChallenge.name = challenge.name
            savedChallenge.date = challenge.date
            savedChallenge.dist = challenge.dist
            
            
            if self.managedObjectContext.hasChanges {
                do {
                    try self.managedObjectContext.save()
                    print("save")
                } catch let error as NSError{
                    print("Cound not save the challenge. Error ",error)
                }
            }
        }
        
        dispatch_async(queue) {
            dispatch_async(dispatch_get_main_queue(), {
                if let delegate = self.dbInspectorListCh {
                    delegate.reloadChallenge!()
                }
            })
        }
        
    }
    
    
    func updateChallenge(challenge:ChallengeObj){
        let queue = dispatch_queue_create("com.vasili.arlou.myChallenge",DISPATCH_QUEUE_SERIAL)
        dispatch_async(queue) {
            let predicate = NSPredicate(format: "id == %@", challenge.id!)
            
            let fetchRequest = NSFetchRequest(entityName: "Challenge")
            fetchRequest.predicate = predicate
            
            do {
                let fetchedEntities = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Challenge]
                fetchedEntities.first?.name = challenge.name
                fetchedEntities.first?.date = challenge.date
                fetchedEntities.first?.dist = challenge.dist
                
            } catch {
                // что-то делаем в зависимости от ошибки
            }
            
            do {
                try self.managedObjectContext.save()
            } catch let error as NSError{
                print("Cound not save the challenge. Error ",error)
            }
        }
        dispatch_async(queue) {
            dispatch_async(dispatch_get_main_queue(), {
                if let delegate = self.dbInspectorListCh {
                    delegate.reloadChallenge!()
                }
            })
        }
    }
    
    //get challenge
    func getChallenge(filter:Int)->[ChallengeObj]{
        
        var ChallengeObjs = [ChallengeObj]()
        let fetchRequest = NSFetchRequest(entityName: "Challenge")
        do {
            let fetchedEntities = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Challenge]
            for entity in fetchedEntities {
                let obj = ChallengeObj()
                obj.name = entity.name
                obj.date = entity.date
                obj.dist = entity.dist
                obj.id = entity.id
                obj.ownId = entity.ownId
                ChallengeObjs.append(obj)
            }
            
        } catch {
            print("Error fetchRequest")
        }
        return ChallengeObjs
        
    }
    
    
    // MARK: - user function core data
    func getCountEntity(entity entity:String)-> Int{
        var count = 0
        let fetchRequest = NSFetchRequest(entityName: entity)
        do {
            let fetchedEntities = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Run]
            count = fetchedEntities.count
        } catch {
            print("Error fetchRequest")
        }
        return count
    }
    
    func saveRun(distance:Double , seconds:Double, time:NSDate,locations:[CLLocation]){
        let savedRun = NSEntityDescription.insertNewObjectForEntityForName("Run", inManagedObjectContext: managedObjectContext) as! Run
        savedRun.distance = distance
        savedRun.duration = seconds
        savedRun.timestamp = time
        
        var savedLocations = [Location]()
        for location in locations {
            let savedLocation = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: managedObjectContext) as! Location
            savedLocation.timestamp = location.timestamp
            savedLocation.latitude = location.coordinate.latitude
            savedLocation.longitude = location.coordinate.longitude
            savedLocations.append(savedLocation)
            
        }
        
        savedRun.locations = NSOrderedSet(array: savedLocations)
        
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError{
                print("Cound not save the track. Error ",error)
            }
        }
        
    }
    
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.orlov.vasili.myChallenge" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("myChallenge", withExtension: "momd")!
        
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    
}
