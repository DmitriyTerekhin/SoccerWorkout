# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SoccerWorkout' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SoccerWorkout
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'Kingfisher', '~> 4.0'
  pod 'KeychainSwift’
  pod 'SwiftyUserDefaults'
  pod 'ScreenType'
  pod 'IQKeyboardManagerSwift', '>= 6.5.0'
  pod 'InputMask'
  pod 'NVActivityIndicatorView'
  pod 'Firebase/Messaging'
  pod 'FirebaseAnalytics'
  
  target 'SoccerWorkoutTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SoccerWorkoutUITests' do
    # Pods for testing
  end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = "13.0"
       end
    end
  end
  
end
