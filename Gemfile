source 'https://rubygems.org'

# Declare your gem's dependencies in any_login.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]


# To run tests
group :test do
  gem "sqlite3"
  gem "devise"
  gem "jquery-rails"
  gem "quiet_assets"
  if RUBY_VERSION >= '2.0'
    gem "pry"
    gem "pry-rails"
    gem "pry-byebug"
  end
end