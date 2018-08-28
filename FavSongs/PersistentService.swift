/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Assignment 2
 Author: Hao, Nguyen Xuan
 ID: 3639036
 Created date: 8/18/18
 Acknowledgements:
     K.Lee, Tutorial Contacts App iOS Swift 3 with CoreData
     Lynda Learning Resources
     Stanford CS193P Course
 */

import Foundation
import CoreData

class PersistentService {
    
    private init() {}
    static var context: NSManagedObjectContext { return persistentContainer.viewContext}
    
    static var persistentContainer: NSPersistentContainer = {
        
        
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "FavSongs")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


