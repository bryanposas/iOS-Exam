# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'
use_frameworks!

def main_pods
  pod 'IQKeyboardManagerSwift'
  pod 'Swinject'
  pod 'SwinjectAutoregistration'
  pod 'SwinjectStoryboard'
  
  # ReachabilitySwift latest is 5.1 but its podspec is not updated and is only installing 5.0. This will get from branch with updated podspec (Sep 7, 2022)
  pod 'ReachabilitySwift', :git => 'https://github.com/codenameDuchess/Reachability.swift.git', :branch => 'pod-spec-update'
  
  pod 'Kingfisher'#, '~> 7.7'
  pod 'Bond'#, '~> 7.8'
end

target 'iOS-Exam' do
  # Pods for iOS-Exam
  
  
  main_pods
end

target 'iOS-ExamTests' do
  inherit! :search_paths
  # Pods for testing
end

target 'iOS-ExamUITests' do
  # Pods for testing
end
post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        if target.name == 'SwinjectStoryboard' || target.name == 'Differ' || target.name == 'ReactiveKit' || target.name == 'Swinject' || target.name == 'SwinjectAutoregistration' || target.name == 'Bond'
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        end
      end
    end
  end
end
