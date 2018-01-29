Pod::Spec.new do |s|

  s.name       		= "XBoundlessScrollView"
  s.version   		= "0.0.1"
  s.summary      	= "可以无限滚动的scrollView"
  s.description  	= "一个可以无限滚动的scrollView"
  s.homepage     	= "https://github.com/orangeLong"
  s.license 		= { :type => 'MIT', :file => 'LICENSE' }
  s.author       	= { "Lixinlong" => "lixinlong@xkshi.com" }
  s.platform     	= :ios, "8.0"
  s.source       	= { :git => "https://github.com/orangeLong/XBoundlessScrollView.git", :tag => s.version.to_s }
  #s.source       	= { :git => "git@github.com:orangeLong/XBoundlessScrollView.git", :tag => s.version.to_s }
  s.source_files = "XBoundlessScrollView/XBoundlessScrollView/**/*.{h,m}"
  s.public_header_files = "XBoundlessScrollView/XBoundlessScrollView/**/*.h"
end
