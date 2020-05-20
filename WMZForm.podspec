Pod::Spec.new do |s|

  s.name         = "WMZForm"
  s.version      = "1.0.0"
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.license      = "Copyright (c) 2020年 WMZ. All rights reserved."
  s.summary      = "快速构建表单,不止是表单,也可以画各种界面"
  s.description  = <<-DESC 
                    轻量级
                   DESC
  s.homepage     = "https://github.com/wwmz/WMZForm"
  s.license      = {:type => "MIT", :file => "LICENSE" }
  s.author       = { "wmz" => "925457662@qq.com" }
  s.source       = { :git => "https://github.com/wwmz/WMZForm",:tag => s.version.to_s}
  s.source_files = "WMZForm/WMZForm/**/*.{h,m}"
  s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
  s.frameworks   = 'UIKit'
  s.resources    = "WMZForm/WMZForm/WMZFormMain/WMZForm.bundle"
  s.dependency  'SDWebImage'
  s.dependency  'Masonry'
  s.dependency  'WMZDialog', '>=1.1.2'
  s.dependency  'IQKeyboardManager'
end

