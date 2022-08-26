ENV["RAILS_ENV"] = "test"

require_relative "../rails_apps/clearance/config/environment"
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../rails_apps/clearance/db/migrate", __dir__)]
require "test_helper_common"
