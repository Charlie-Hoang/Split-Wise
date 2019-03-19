# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs'
platform :ios, '9.0'

workspace 'Splitwise.xcworkspace'

use_frameworks!

inhibit_all_warnings!

def common_pods
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RealmSwift'
end

target 'SplitwiseApp' do
    project 'SplitwiseApp/SplitwiseApp.xcodeproj'
    common_pods
end

target 'SplitwiseAppTests' do
    project 'SplitwiseApp/SplitwiseApp.xcodeproj'
    common_pods
end


