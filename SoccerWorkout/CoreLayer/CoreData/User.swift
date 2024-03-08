//

import Foundation
import CoreData

@objc(User)
public final class UserDB: NSManagedObject {

    @NSManaged public private(set) var level: Int16
    @NSManaged public private(set) var goalLevel: Int16
    @NSManaged public private(set) var goalTime: Int16
    @NSManaged public private(set) var userId: String
    @NSManaged public private(set) var points: Int64
    
    static let cacheKey = "loggedInUser"

    static func insert(
        into context: NSManagedObjectContext,
        model: UserModel
    ) -> UserDB {
        let userDB: UserDB = context.insertObject()
        userDB.level = Int16(model.level.level)
        userDB.points = Int64(model.userPoints)
        userDB.userId = model.userId
        context.set(userDB, forSingleObjectCacheKey: UserDB.cacheKey)
        return userDB
    }
    
    static func update(
        in context: NSManagedObjectContext,
        level: Int) {
            let userDB: UserDB? = personForLoggedInUserInContext(moc: context)
            userDB?.level = Int16(level)
            context.set(userDB, forSingleObjectCacheKey: UserDB.cacheKey)
        }
    
    static func update(
        in context: NSManagedObjectContext,
        points: Int) {
            let userDB: UserDB? = personForLoggedInUserInContext(moc: context)
            userDB?.points = Int64(points)
            context.set(userDB, forSingleObjectCacheKey: UserDB.cacheKey)
        }
}

extension UserDB: ManagedObjectType {
    static var entityName: String {
        "User"
    }
}

extension UserDB {
    static func personForLoggedInUserInContext(
        moc: NSManagedObjectContext) -> UserDB?
    {
        guard let userId = SecureStorage.shared.getUserId() else { return nil }
        return fetchSingleObjectInContext(moc: moc, cacheKey: UserDB.cacheKey) {
            request in
            request.predicate = NSPredicate(format: "userId == %@", userId)
        }
    }
}
