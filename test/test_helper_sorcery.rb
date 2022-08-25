ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy-sorcery/config/environment"
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy-sorcery/db/migrate", __dir__)]
require "test_helper_common"
