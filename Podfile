
platform :ios, '10.0'

target 'Yum' do
  use_frameworks!

  pod 'SwiftLint'
  pod 'SwiftyJSON'
  
  pod 'Alamofire'
  pod 'AlamofireImage'
  
  pod 'DKImagePickerController'
  pod 'ManualLayout'
  pod 'Sharaku'
  pod 'RangeSeekSlider'
  pod 'Toaster'
  
  pod 'FacebookCore'
  pod 'FacebookLogin'

  post_install do |installer|
      # Your list of targets here.
      myTargets = ['Sharaku', 'RangeSeekSlider']
      
      installer.pods_project.targets.each do |target|
          if myTargets.include? target.name
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = '3.2'
              end
          end
      end
  end
end
