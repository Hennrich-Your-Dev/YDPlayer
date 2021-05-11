Pod::Spec.new do |spec|

  spec.name         = "YDPlayer"
  spec.version      = "1.0.4"
  spec.summary      = "Live video player for B2W."
  spec.homepage     = "https://www.yourdev.com.br"
  spec.license      = "MIT"
  spec.author       = { "Douglas Hennrich" => "douglashennrich@yourdev.com.br" }

  spec.platform     = :ios, "11.0"

  spec.source           = { :git => "https://github.com/Hennrich-Your-Dev/YDPlayer.git", :tag => spec.version }
  spec.source_files     = "YDPlayer/**/*.{h,m,swift,xib}"
  spec.swift_version    = "5.0"

  spec.dependency       'youtube-ios-player-helper', '1.0.2'

end
