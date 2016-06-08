Pod::Spec.new do |s|
  s.name			= "ApplicationSupport"
  s.version			= "1.0.0"
  s.summary			= "iOS Application Support classes"
  s.homepage		= "https://github.com/AlexZd/ApplicationSupport"
  s.license			= 'MIT'
  s.author			= { "Alex Z" => "alexzd89@mail.ru" }
  s.source 			= { :git => "https://github.com/AlexZd/ApplicationSupport.git", :tag => s.version }
  s.platform     	= :ios, '8.0'
  s.requires_arc 	= true
  s.source_files 	= 'ApplicationSupport/**/*'

  s.dependency 'InflectorKit'
end