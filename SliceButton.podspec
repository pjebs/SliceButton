#
#  Be sure to run `pod spec lint Game-Timer-iOS.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "SliceButton"
  s.version      = "1.0.0"
  s.summary      = "A Pizza shaped button you can use for games"

  s.description  = <<-DESC
                   SliceButton is a button that is shaped like a pie/pizza and sliced up according to the number in the buttons property.

                   Responds to Taps based on 'slice'.

                   Includes an example project.
                   DESC

  s.homepage     = "https://github.com/pjebs/SliceButton"

  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "PJ Engineering and Business Solutions Pty. Ltd." => "enquiries@pjebs.com.au" }

  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/pjebs/SliceButton.git", :tag => "v1.0.0" }
  s.source_files  = "*.{h,m}"
  s.requires_arc = true

end
