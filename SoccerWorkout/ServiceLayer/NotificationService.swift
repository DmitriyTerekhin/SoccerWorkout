//

import Foundation
import UserNotifications

protocol INotificationService {
    func removeCurrentReminder(trainingName: String, date: Date)
    func setReminder(trainingName: String, date: Date, completionHandler: @escaping FinishedCompletionHandler)
    func isNotificationExist(trainingName: String, date: Date) -> Bool
}

class NotificationService: INotificationService {
    
    private let databaseService: IDatabaseService
    
    init(databaseService: IDatabaseService) {
        self.databaseService = databaseService
    }
    
    func isNotificationExist(trainingName: String, date: Date) -> Bool {
        let identifier = getIdentifier(date: date, trainingName: trainingName)
        return databaseService.getNotification(identifier: identifier) != nil
    }
    
    func removeCurrentReminder(trainingName: String, date: Date) {
        let identifier = getIdentifier(date: date, trainingName: trainingName)
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identifier])
        databaseService.deleteReminder(with: identifier) { _ in }
    }
    
    func setReminder(trainingName: String, date: Date, completionHandler: @escaping FinishedCompletionHandler) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        let identifier = getIdentifier(date: date, trainingName: trainingName)
        content.title = "You have training today!"
        content.body = "\(trainingName.capitalized) in 15 minutes"
        content.sound = .default
        let fireDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: date.addingTimeInterval(-60*15))
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request) { (error) in
            if error != nil {
                print("Error = \(error?.localizedDescription ?? "error local notification")")
            }
            DispatchQueue.main.async {
                self.databaseService.saveNotification(identifier: identifier, completionHandler: completionHandler)
            }
        }
    }
    
    private func getIdentifier(date: Date, trainingName: String) -> String {
        return "\(date.toString(.YYYYMMDDTHHMMSS))\(trainingName)"
    }
}
