//

import Foundation

protocol ISettingPresenter: AnyObject {
    var userModel: UserModel { get }
    func settingDidSelect(_ type: SettingsTypes)
    func saveUserSkill(skill: Skill)
    func attachView(_ view: ISettingsView)
}
protocol ISettingsView: AnyObject {
    func showWebView(url: String)
    func updateStatus(userModel: UserModel)
    func goToEnterScreen()
}

class SettingsPresenter: ISettingPresenter {
    weak var view: ISettingsView?
    private let userInfoService: ISensentiveInfoService
    private let networkService: INetworkService
    private let databaseService: IDatabaseService
    var userModel: UserModel {
        return databaseService.getUserModel()
    }

    init(
        userInfoService: ISensentiveInfoService,
        networkService: INetworkService,
        databaseService: IDatabaseService
    ) {
        self.databaseService = databaseService
        self.userInfoService = userInfoService
        self.networkService = networkService
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.methodOfReceivedNotification(notification:)),
                                               name: Notification.Name(NotificationsConstants.userStatusNeedToUpdate), object: nil)
    }
    
    func attachView(_ view: ISettingsView) {
        self.view = view
        self.view?.updateStatus(userModel: userModel)
    }
    
    func saveUserSkill(skill: Skill) {
        userInfoService.saveUserSkill(skill: skill)
        databaseService.updateUserLevel(skill.level) { _ in }
        NotificationCenter.default.post(name: Notification.Name(NotificationsConstants.userStatusNeedToUpdate),
                                        object: nil)
    }
    
    func settingDidSelect(_ type: SettingsTypes) {
        switch type {
        case .termsOfUse:
            view?.showWebView(url: "https://doc-hosting.flycricket.io/bno-sport-way-terms-of-use/2ed3d3c7-ca8e-4c3a-a3ce-0e15526b2ae6/terms")
        case .privacy:
            view?.showWebView(url: "https://doc-hosting.flycricket.io/bno-sport-way-privacy-policy/82566c48-4495-46af-8f5e-9a4ac88d40f8/privacy")
        case .rateUs:
            if let bundleIdentifier = Bundle.main.bundleIdentifier {
                let appID = bundleIdentifier
//                let urlStr = "https://itunes.apple.com/app/id\(appID)"
                let urlStr = "https://itunes.apple.com/app/id\(appID)?action=write-review"
                view?.showWebView(url: urlStr)
            }
        case .delete:
            networkService.deleteProfile(token: userInfoService.userId) { [weak self] _ in
                DispatchQueue.main.async {
                    self?.databaseService.purgeAllData()
                    self?.userInfoService.deleteAllInfo(completionBlock: { _ in
                        self?.view?.goToEnterScreen()
                    })
                }
            }
        }
    }
    
    @objc
    func methodOfReceivedNotification(notification: Notification) {
        view?.updateStatus(userModel: userModel)
    }
}
