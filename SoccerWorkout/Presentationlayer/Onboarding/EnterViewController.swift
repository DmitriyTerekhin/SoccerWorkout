//
//  OnboardingViewController.swift
//  LogoGenerator
//
//  Created by Дмитрий Терехин on 29.07.2023.
//

import UIKit
import AuthenticationServices
import CoreLocation
import NotificationCenter

class EnterViewController: UIViewController {
    
    private let contentView = EnterView(frame: UIScreen.main.bounds)
    private var currentPage: Int
    private let networkService: INetworkService
    private let userInfoService: ISensentiveInfoService
    private let presentationAssemmbly: IPresentationAssembly
    private let dataSource: [EnterLogicType] = [
        EnterLogicType.notification,
        EnterLogicType.signIn
    ]
    
    init(presentationAssemmbly: IPresentationAssembly,
         networkService: INetworkService,
         userInfoService: ISensentiveInfoService) {
        self.currentPage = 0
        self.networkService = networkService
        self.presentationAssemmbly = presentationAssemmbly
        self.userInfoService = userInfoService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
    }
    
    @objc
    func noThanksTapped() {
        self.currentPage = 1
        self.contentView.collectionView.scrollToItem(at: IndexPath(row: self.currentPage, section: 0),
                                                     at: .centeredHorizontally,
                                                     animated: true)
    }
    
    @objc
    func allowNotificationTapped() {
        registerForPushNotifications {
               self.userInfoService.changeAskPushValue()
               DispatchQueue.main.async {
                   self.currentPage = 1
                   self.contentView.collectionView.scrollToItem(at: IndexPath(row: self.currentPage, section: 0),
                                                           at: .centeredHorizontally,
                                                           animated: true)
               }
           }
    }
    
    @objc
    func signInWithAppleTapped() {
        navigationController?.pushViewController(presentationAssemmbly.chooseSkillScreen(), animated: true)
//        let provider = ASAuthorizationAppleIDProvider()
//        let request = provider.createRequest()
//        request.requestedScopes = [.email]
//
//        let controller = ASAuthorizationController(authorizationRequests: [request])
//        controller.delegate = self
//        controller.presentationContextProvider = self
//        controller.performRequests()
    }
    
    private func makeAppleAuth(code: String) {
        networkService.makeAuth(token: code) { [weak self] result in
              DispatchQueue.main.async {
                  guard let strongSelf = self else { return }
                  switch result {
                  case .success(let authModel):
                      print(authModel)
                      guard authModel.accessToken.count > 3 else { return }
                      strongSelf.userInfoService.saveAppleToken(token: authModel.accessToken)
                      strongSelf.goToTabBar()
                  case .failure(let error):
                      print(error.localizedDescription)
                  }
              }
          }
      }
    
    @objc
    func goToTabBar() {
        presentationAssemmbly.changeRootViewController(on: presentationAssemmbly.tabBarViewController())
    }
    
    private func registerForPushNotifications(completionHandler: @escaping () -> Void) {
       UNUserNotificationCenter.current()
         .requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, _ in
             completionHandler()
             guard granted else { return }
             self?.getNotificationSettings()
         }
     }
     
     private func getNotificationSettings() {
       UNUserNotificationCenter.current().getNotificationSettings { settings in
         print("Notification settings: \(settings)")
           guard settings.authorizationStatus == .authorized else { return }
           DispatchQueue.main.async {
             UIApplication.shared.registerForRemoteNotifications()
           }
       }
     }
}

// MARK: Delegates
extension EnterViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch dataSource[indexPath.row] {
        case .notification, .signIn:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EnterCollectionViewCell.reuseID, for: indexPath) as! EnterCollectionViewCell
            cell.setupWith(dataSource[indexPath.row])
            return cell
        }
    }
}

extension EnterViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentiontials as ASAuthorizationAppleIDCredential:
            guard
                let code = credentiontials.authorizationCode,
                let codeString = String(data: code, encoding: .utf8)
            else { return }
            print(codeString)
            makeAppleAuth(code: codeString)
        default:
            break
        }
    }
}

extension EnterViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        view.window!
    }
}


// MARK: - CollectionView Delegate
extension EnterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}
