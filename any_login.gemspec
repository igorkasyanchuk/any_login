$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "any_login/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "any_login"
  s.version     = AnyLogin::VERSION
  s.authors     = ["Igor Kasyanchuk"]
  s.email       = ["igorkasyanchuk@gmail.com"]
  s.homepage    = "https://github.com/igorkasyanchuk"
  s.summary     = "AnyLogin is created to speedup development process and allow developer's quickly login as any user in DB."
  s.description = "Simply add this gem to your application and make your life easier with switching users."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.required_ruby_version = '>= 1.9.3'

  s.add_runtime_dependency 'rails', '>= 4.0.0'

  # to remove warning
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "devise"
  s.add_development_dependency "authlogic"
  s.add_development_dependency "clearance"
  s.add_development_dependency "sorcery"
  s.add_development_dependency "bcrypt"
  s.add_development_dependency "jquery-rails"
  s.add_development_dependency "quiet_assets"
  if RUBY_VERSION >= '2.0'
    s.add_development_dependency "pry"
    s.add_development_dependency "pry-rails"
  end
end