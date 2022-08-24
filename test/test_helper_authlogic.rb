ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy-authlogic/config/environment"
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy-authlogic/db/migrate", __dir__)]
require "test_helper_common"
