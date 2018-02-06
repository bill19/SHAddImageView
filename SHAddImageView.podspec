Pod::Spec.new do |s|

s.name         = "SHAddImageView"
s.version      = "1.0.1"
s.summary      = "SHAddImageView is a easy test."

s.description  = = <<-DESC
Custom Category used on iOS, which implement by Objective-C.
DESC

s.homepage     = "https://github.com/bill19/SHAddImageView"
s.license      = "MIT"
s.platform     = :ios, '8.0'
s.author             = { "HaoSun" => "sunhao.private@foxmail.com" }
s.source       = { :git => "https://github.com/bill19/SHAddImageView.git", :tag => s.version }
s.source_files  = 'SHAddImageView/**/*'
s.requires_arc = true
s.dependency 'TZImagePickerController', '~> 2.0.0.4'
end
