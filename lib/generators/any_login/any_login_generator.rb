class AnyLoginGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  def copy_initializer
    template 'any_login.rb', 'config/initializers/any_login.rb'
  end
end
