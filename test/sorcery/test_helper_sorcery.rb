ENV["RAILS_ENV"] = "test"

require_relative "../rails_apps/sorcery/config/environment"
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../rails_apps/sorcery/db/migrate", __dir__)]
require_relative "../test_helper_common"
