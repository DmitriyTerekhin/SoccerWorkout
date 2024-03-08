//

import Foundation
import CoreData

@objc(WorkoutHistory)
public final class WorkoutHistoryDB: NSManagedObject {
    @NSManaged public private(set) var id: Int64
    @NSManaged public private(set) var choosenLevel: String
    @NSManaged public private(set) var passedTime: String
    @NSManaged public private(set) var earnedPoints: String
    @NSManaged public private(set) var trainingTime: String
    @NSManaged public private(set) var totalNumberOfEx: String
    @NSManaged public private(set) var type: String
    @NSManaged public private(set) var date: Date?
    
    static func insert(
        into context: NSManagedObjectContext,
        workout: WorkoutHistoryModel
    ) -> WorkoutHistoryDB {
        guard let workoutDB: WorkoutHistoryDB = .findOrFetch(in: context, matching: NSPredicate(format: "id == %i", workout.id))
        else {
            let workoutDB: WorkoutHistoryDB = context.insertObject()
            workoutDB.id = Int64(workout.id)
            workoutDB.choosenLevel = workout.chooseLevel.rawValue
            workoutDB.earnedPoints = workout.earnedPoints
            workoutDB.passedTime = workout.passedTime
            workoutDB.trainingTime = workout.trainingTime
            workoutDB.date = workout.date
            workoutDB.totalNumberOfEx = workout.totalNumberOfEx
            workoutDB.type = workout.type
            return workoutDB
        }
        workoutDB.choosenLevel = workout.chooseLevel.rawValue
        workoutDB.earnedPoints = workout.earnedPoints
        workoutDB.passedTime = workout.passedTime
        workoutDB.trainingTime = workout.trainingTime
        workoutDB.date = workout.date
        workoutDB.totalNumberOfEx = workout.totalNumberOfEx
        workoutDB.type = workout.type
        return workoutDB
    }
}

extension WorkoutHistoryDB: ManagedObjectType {
    static var entityName: String {
        "WorkoutHistory"
    }
}
