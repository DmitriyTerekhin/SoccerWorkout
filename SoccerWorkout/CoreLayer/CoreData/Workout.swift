//

import Foundation
import CoreData

@objc(Workout)
public final class WorkoutDB: NSManagedObject {
    @NSManaged public private(set) var id: Int64
    @NSManaged public private(set) var choosenLevel: Int16
    
    static func insert(
        into context: NSManagedObjectContext,
        workout: WorkoutModel
    ) -> WorkoutDB {
        guard let workoutDB: WorkoutDB = .findOrFetch(in: context, matching: NSPredicate(format: "id == %i", workout.id))
        else {
            let workoutDB: WorkoutDB = context.insertObject()
            workoutDB.id = Int64(workout.id)
            workoutDB.choosenLevel = Int16(workout.chooseLevel.level)
            return workoutDB
        }
        workoutDB.choosenLevel = Int16(workout.chooseLevel.level)
        return workoutDB
    }
}

extension WorkoutDB: ManagedObjectType {
    static var entityName: String {
        "Workout"
    }
}
