//
//  AppDelegate.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import UIKit
import FirebaseMessaging
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let rootAssembly = RootAssembly()
    let notificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configurePushNotification()
        if #available(iOS 13, *) {}
        else {
          application.statusBarStyle = .lightContent
          createStartView(window: window ?? UIWindow(frame: UIScreen.main.bounds))
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    private func createStartView(window: UIWindow) {
        self.window = window
        window.backgroundColor = .AppCollors.darkGray
        window.rootViewController = UINavigationController(rootViewController: rootAssembly.presentationAssembly.getStartScreen())
        window.makeKeyAndVisible()
    }
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard
            let window = self.window,
            window.rootViewController != vc
        else {
            return
        }
        window.rootViewController = vc
        UIView.transition(with: window,
                          duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: nil,
                          completion: nil)
    }
    
    func configurePushNotification() {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
    }

}
extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let token = fcmToken else { return }
        print("FCM token: \(token)")
        rootAssembly.serviceAssembly.userInfoService.saveNotificationToken(token: token)
//        rootAssembly.serviceAssembly.networkService.sendPushToken(token: token)
        if let apnsToken = messaging.apnsToken {
            print("DecimalHex:\n" + apnsToken.map { String(format: "%02.2hhx", $0) }.joined())
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if #available(iOS 14.0, *) {
            completionHandler([.sound, .badge, .banner])
        } else {
            completionHandler([.alert, .sound, .badge])
        }
    }
    
    func application( _ application: UIApplication,
                      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("Failed to register: \(error)")
    }
}
