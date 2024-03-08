//

import Foundation

protocol IDatabaseService {
    func saveUserModel(model: UserModel,
                       completionHandler: FinishedCompletionHandler)
    func updateUserPoints( _ points: Int,
                          completionHandler: FinishedCompletionHandler)
    func updateUserLevel(_ level: Int,
                          completionHandler: FinishedCompletionHandler)
    func purgeAllData()
    func getNotification(identifier: String) -> LocalNotification?
    func saveNotification(identifier: String, completionHandler: FinishedCompletionHandler)
    func deleteReminder(with identifier: String,
                        completionHandler: FinishedCompletionHandler)
    func getUserModel() -> UserModel
    func saveWorkoutChoosenLevel(model: WorkoutModel, commpletion: FinishedCompletionHandler)
    func getWorkout(id: Int) -> WorkoutModel?
    func savePassedWorkoutHistory(model: WorkoutHistoryModel,
                                  completion: FinishedCompletionHandler)
    func getWorkoutHistory(id: Int) -> WorkoutHistoryModel?
}

class DatabaseService: IDatabaseService {
    
    func saveUserModel(model: UserModel,
                       completionHandler: FinishedCompletionHandler) {
        db.saveUserModel(model: model, with: CDStack.mainContext, completionHandler: completionHandler)
    }
    func updateUserPoints( _ points: Int,
                           completionHandler: FinishedCompletionHandler) {
        db.updateUserPoints(points,
                           with: CDStack.mainContext,
                           completionHandler: completionHandler)
    }
    func updateUserLevel(_ level: Int,
                         completionHandler: FinishedCompletionHandler) {
        db.updateUserLevel(level,
                           with: CDStack.mainContext,
                           completionHandler: completionHandler)
    }

    func getUserModel() -> UserModel {
        UserModel(from: db.getUserModel(with: CDStack.mainContext))
    }
    
    func saveNotification(identifier: String, completionHandler: FinishedCompletionHandler) {
        db.saveNotification(moc: CDStack.mainContext,
                            identifier: identifier,
                            completionHandler: completionHandler)
    }
    
    func getNotification(identifier: String) -> LocalNotification? {
        return LocalNotification(fromDB: db.getNotification(predicate: NSPredicate(format: "identifier == %@", identifier),
                                                                                   moc: CDStack.mainContext))
    }
    
    func deleteReminder(with identifier: String,
                        completionHandler: FinishedCompletionHandler) {
        db.deleteReminer(moc: CDStack.mainContext,
                         predicate: NSPredicate(format: "identifier == %@", identifier),
                         completionHandler: completionHandler)
    }

    func purgeAllData() {
        db.purgeAllData(context: CDStack.mainContext)
        CDStack.mainContext.refreshAllObjects()
        CDStack.saveContext.refreshAllObjects()
    }
    
    func saveWorkoutChoosenLevel(model: WorkoutModel, commpletion: FinishedCompletionHandler) {
        db.saveWorkoutChoosenLevel(model: model,
                                   moc: CDStack.mainContext,
                                   predicate: NSPredicate(format: "id == %i", model.id),
                                   commpletion: commpletion)
    }
    func getWorkout(id: Int) -> WorkoutModel? {
        return WorkoutModel(from: db.getWorkout(predicate: NSPredicate(format: "id == %i", id), moc: CDStack.mainContext))
    }
    
    func savePassedWorkoutHistory(model: WorkoutHistoryModel,
                                  completion: FinishedCompletionHandler) {
        db.savePassedWorkoutHistory(model: model,
                                    moc: CDStack.mainContext,
                                    commpletion: completion)
    }
    func getWorkoutHistory(id: Int) -> WorkoutHistoryModel? {
        return WorkoutHistoryModel(from: db.getWorkoutHistory(
            predicate: NSPredicate(format: "id == %i", id),
            moc: CDStack.mainContext))
    }
    
    private let db: IStorageManager
    private let CDStack: ICoreDataStack
    
    init(db: IStorageManager, coreDataStack: ICoreDataStack) {
        self.db = db
        self.CDStack = coreDataStack
    }
    
}
