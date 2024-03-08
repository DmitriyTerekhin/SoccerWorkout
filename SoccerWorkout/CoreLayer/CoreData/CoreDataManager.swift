//

import Foundation
import CoreData

protocol IStorageManager: AnyObject {
    func saveUserModel(model: UserModel,
                       with context: NSManagedObjectContext,
                       completionHandler: FinishedCompletionHandler)
    func updateUserPoints( _ points: Int,
                           with context: NSManagedObjectContext,
                           completionHandler: FinishedCompletionHandler)
    func updateUserLevel(_ level: Int,
                         with context: NSManagedObjectContext,
                         completionHandler: FinishedCompletionHandler)
    func purgeAllData(context: NSManagedObjectContext)
    func getUserModel(with context: NSManagedObjectContext) -> UserDB?
    func saveNotification(
        moc: NSManagedObjectContext,
        identifier: String,
        completionHandler: (Bool) -> Void
    )
    func deleteReminer(
        moc: NSManagedObjectContext,
        predicate: NSPredicate,
        completionHandler: FinishedCompletionHandler
    )
    func getNotification(predicate: NSPredicate, moc: NSManagedObjectContext) -> LocalNotificationsDB?
    func saveWorkoutChoosenLevel(model: WorkoutModel, moc: NSManagedObjectContext, predicate: NSPredicate, commpletion: FinishedCompletionHandler)
    func getWorkout(predicate: NSPredicate, moc: NSManagedObjectContext) -> WorkoutDB?
    func getWorkoutHistory(predicate: NSPredicate, moc: NSManagedObjectContext) -> WorkoutHistoryDB?
    func savePassedWorkoutHistory(model: WorkoutHistoryModel,
                                  moc: NSManagedObjectContext,
                                  commpletion: FinishedCompletionHandler)
}

final class CoreDataManager: IStorageManager {
    
    static let shared = CoreDataManager()
    private init() {}

    func saveUserModel(model: UserModel, with context: NSManagedObjectContext, completionHandler: (Bool) -> Void) {
        //Добавляем новых
        context.performAndWait {
            _ = UserDB.insert(
                into: context,
                model: model
            )
        }
        _ = context.saveOrRollback()
        completionHandler(true)
    }
    
    func updateUserPoints(_ points: Int,
                          with context: NSManagedObjectContext,
                          completionHandler: (Bool) -> Void) {
        context.performAndWait {
            UserDB.update(in: context, points: points)
        }
        _ = try? context.save()
        completionHandler(true)
    }
    
    func updateUserLevel(_ level: Int,
                     with context: NSManagedObjectContext,
                     completionHandler: (Bool) -> Void) {
        context.performAndWait {
            UserDB.update(in: context, level: level)
        }
        _ = try? context.save()
        completionHandler(true)
    }
    
    func getUserModel(with context: NSManagedObjectContext) -> UserDB? {
        return UserDB.personForLoggedInUserInContext(moc: context)
    }
    
    func saveNotification(
        moc: NSManagedObjectContext,
        identifier: String,
        completionHandler: (Bool) -> Void
    ) {
        //Добавляем новых
        moc.performAndWait {
            _ = LocalNotificationsDB.insert(
                into: moc,
                identifier: identifier
            )
        }
        _ = moc.saveOrRollback()
        completionHandler(true)
    }
    func getNotification(predicate: NSPredicate, moc: NSManagedObjectContext) -> LocalNotificationsDB? {
        return LocalNotificationsDB.fetch(in: moc) { request in
            request.predicate = predicate
            request.returnsObjectsAsFaults = false
            request.fetchLimit = 1
        }.first
    }
    
    func deleteReminer(
        moc: NSManagedObjectContext,
        predicate: NSPredicate,
        completionHandler: FinishedCompletionHandler
    ) {
        guard
            let object = LocalNotificationsDB.fetch(in: moc, configurationBlock: { request in
                request.predicate = predicate
                request.returnsObjectsAsFaults = false
                request.fetchLimit = 1
            }).first else { return }
        moc.delete(object)
        _ = moc.saveOrRollback()
        completionHandler(true)
    }
    
    func saveWorkoutChoosenLevel(model: WorkoutModel, moc: NSManagedObjectContext, predicate: NSPredicate, commpletion: FinishedCompletionHandler) {
        moc.performAndWait {
            _ = WorkoutDB.insert(into: moc, workout: model)
        }
        _ = moc.saveOrRollback()
        commpletion(true)
    }
    
    func savePassedWorkoutHistory(model: WorkoutHistoryModel,
                                  moc: NSManagedObjectContext,
                                  commpletion: FinishedCompletionHandler) {
        moc.performAndWait {
            _ = WorkoutHistoryDB.insert(into: moc, workout: model)
        }
        _ = moc.saveOrRollback()
        commpletion(true)
    }
    
    func getWorkoutHistory(predicate: NSPredicate, moc: NSManagedObjectContext
    ) -> WorkoutHistoryDB? {
        return WorkoutHistoryDB.fetch(in: moc) { request in
            request.predicate = predicate
            request.returnsObjectsAsFaults = false
            request.fetchLimit = 1
        }.first
    }
    
    func getWorkout(predicate: NSPredicate, moc: NSManagedObjectContext) -> WorkoutDB? {
        return WorkoutDB.fetch(in: moc) { request in
            request.predicate = predicate
            request.returnsObjectsAsFaults = false
            request.fetchLimit = 1
        }.first
    }
    
    func purgeAllData(context: NSManagedObjectContext) {
        guard let uniqueNames = context.persistentStoreCoordinator?.managedObjectModel.entities.compactMap({ $0.name }) else {return}
        uniqueNames.forEach { (name) in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            _ = try? context.execute(batchDeleteRequest)
        }
    }
}
