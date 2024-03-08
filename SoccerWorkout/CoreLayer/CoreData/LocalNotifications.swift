//

import Foundation
import CoreData

@objc(LocalNotifications)
public final class LocalNotificationsDB: NSManagedObject {
    @NSManaged public private(set) var identifier: String
    
    static func insert(
        into context: NSManagedObjectContext,
        identifier: String
    ) -> LocalNotificationsDB {
        let norification: LocalNotificationsDB = context.insertObject()
        norification.identifier = identifier
        return norification
    }
}

extension LocalNotificationsDB: ManagedObjectType {
    static var entityName: String {
        "LocalNotifications"
    }
}
