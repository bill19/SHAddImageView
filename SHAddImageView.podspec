Pod::Spec.new do |s|

s.name         = "SHAddImageView"
s.version      = "1.0.0"
s.summary      = "MTKitTest is a easy test."

s.description  = <<-DESC
This description is used to generate tags and improve search results;
DESC

s.homepage     = "https://github.com/bill19/SHAddImageView"
s.license      = "MIT"

s.author             = { "HaoSun" => "sunhao.private@foxmail.com" }
s.source       = { :git => "https://github.com/bill19/SHAddImageView.git", :tag => "1.0.0" }
s.source_files  = "SHAddImageView/SHAddImgView"
s.exclude_files = "Classes/Exclude"
s.requires_arc = true
s.dependency 'TZImagePickerController', '~> 2.0.0.4'
end
