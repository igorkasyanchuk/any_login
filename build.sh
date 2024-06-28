bundle lock --add-platform arm64-darwin-22
BUNDLE_GEMFILE=./gemfiles/rails_6_1.gemfile bundle lock --add-platform arm64-darwin-22
BUNDLE_GEMFILE=./gemfiles/rails_7.gemfile bundle lock --add-platform arm64-darwin-22
BUNDLE_GEMFILE=./gemfiles/rails_7_1.gemfile bundle lock --add-platform arm64-darwin-22
rm *.gem
rm -fr test/dummy/log/*.log
rm -fr test/dummy/tmp/cache
rm -fr test/dummy-authlogic/log/*.log
rm -fr test/dummy-authlogic/tmp/cache
rm -fr test/dummy-clearance/log/*.log
rm -fr test/dummy-clearance/tmp/cache
rm -fr test/dummy-sorcery/log/*.log
rm -fr test/dummy-sorcery/tmp/cache
gem build any_login.gemspec
