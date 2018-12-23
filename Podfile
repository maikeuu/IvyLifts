platform :ios, '10.0'
inhibit_all_warnings!
target 'IvyLifts' do
  use_frameworks!
  pod 'Alamofire'
  pod 'RealmSwift'
  pod 'JSONWebToken'
end

# Needed because JSONWebToken 2.2 crashes iOS 12.0
post_install do |installer|
    
    installer.pods_project.targets.each do |target|
        
        if target.name == 'JSONWebToken'
            system("rm -rf Pods/JSONWebToken/CommonCrypto")
        end
        
    end
    
end
