//
//  CoreDataStack.swift
//  Workout
//
//  Created by Ju on 18.02.2024.
//

import Foundation
import CoreData

protocol ICoreDataStack {
    var mainContext: NSManagedObjectContext { get }
    var saveContext: NSManagedObjectContext { get }
    var persistentStoreCoordinator: NSPersistentStoreCoordinator { get }
    func saveMainContext()
}

class CoreDataStack: ICoreDataStack {
    private let modelName: String = " SoccerWorkout"
    static let shared = CoreDataStack()
    private init() {}
    
    func saveMainContext() {
        mainContext.performAndWait {
            if mainContext.hasChanges {
                do {
                    try mainContext.save()
                } catch {
                    print(#function)
                    print(error)
                }
            }
        }
    }
    
    lazy var saveContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = mainContext
        managedObjectContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyStoreTrumpMergePolicyType)
        managedObjectContext.automaticallyMergesChangesFromParent = true
        return managedObjectContext
    }()
    
     lazy var mainContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        managedObjectContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        return managedObjectModel
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        let persistentStoreDescription = NSPersistentStoreDescription(url: persistentStoreURL)
        persistentStoreDescription.type = NSSQLiteStoreType
        persistentStoreDescription.shouldMigrateStoreAutomatically = true
        persistentStoreDescription.shouldInferMappingModelAutomatically = true
        persistentStoreCoordinator.addPersistentStore(with: persistentStoreDescription, completionHandler: { (description, error) in
            if let error = error {
                print("Unable to Add Persistent Store")
                print("\(error.localizedDescription)")
            }
        })
        return persistentStoreCoordinator
    }()
}
