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
  
  pod 'Kingfisher'
  pod 'Bond'
  pod 'StarReview'
end

target 'iOS-Exam' do
  main_pods
end

target 'iOS-ExamTests' do
  inherit! :search_paths
  
end

target 'iOS-ExamUITests' do
  
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        if target.name == 'SwinjectStoryboard' || target.name == 'Differ' || target.name == 'ReactiveKit' || target.name == 'Swinject' || target.name == 'SwinjectAutoregistration' || target.name == 'Bond' || target.name == 'StarReview'
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        end
      end
    end
  end
end
