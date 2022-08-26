ENV["RAILS_ENV"] = "test"

require_relative "../rails_apps/devise/config/environment"
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../rails_apps/devise/db/migrate", __dir__)]
require_relative "../test_helper_common"
