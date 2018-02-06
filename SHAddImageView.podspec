Pod::Spec.new do |s|

s.name         = "SHAddImageView"
s.version      = "1.0.1"
s.summary      = "SHAddImageView is a easy test."

s.description  = "SHAddImageView is a good ."

s.homepage     = "https://github.com/bill19/SHAddImageView"
s.license      = "MIT"

s.author             = { "HaoSun" => "sunhao.private@foxmail.com" }
s.source       = { :git => "https://github.com/bill19/SHAddImageView.git", :tag => "1.0.1" }
s.source_files  = "SHAddImageView/SHAddImgView"
s.exclude_files = "Classes/Exclude"
s.requires_arc = true
s.dependency 'TZImagePickerController', '~> 2.0.0.4'
end
