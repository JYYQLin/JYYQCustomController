Pod::Spec.new do |spec|
  	spec.name         = "JYYQCustomController"
  	spec.version      = "1.0.0"
  	spec.summary      = "自用一些封装的界面"


	 spec.description  = <<-DESC
                   暂时不想写任何描述
                   DESC

  	spec.homepage     = "https://github.com/JYYQLin/JYYQCustomController"
	spec.screenshots  = "无logo_URl"

  	spec.license      = { :type => "MIT", :file => "LICENSE" }

  	spec.author       = { "JYYQLin" => "No mailBox" }
	spec.social_media_url   = "https://github.com/JYYQLin"


	spec.swift_versions = ['5.0', '5.1', '5.2']

  	spec.ios.deployment_target = "13.0"

  	spec.source       = { :git => "https://github.com/JYYQLin/JYYQCustomController.git", :tag => spec.version }
  	spec.source_files  = "Controller/**/*.{h,m,swift}"

  	spec.dependency "JYYQToolBox", '1.0.0'

end

