bundle
BUNDLE_GEMFILE=./gemfiles/rails_6_1.gemfile bundle
BUNDLE_GEMFILE=./gemfiles/rails_7.gemfile bundle
BUNDLE_GEMFILE=./gemfiles/rails_7_1.gemfile bundle
mkdir log
cd test/rails_apps/authlogic/
bundle exec rails db:migrate
RAILS_ENV=test bundle exec rails db:migrate
cd ../../..
cd test/rails_apps/devise/
bundle exec rails db:migrate
RAILS_ENV=test bundle exec rails db:migrate
cd ../../..
cd test/rails_apps/clearance/
bundle exec rails db:migrate
RAILS_ENV=test bundle exec rails db:migrate
cd ../../..
cd test/rails_apps/sorcery/
bundle exec rails db:migrate
RAILS_ENV=test bundle exec rails db:migrate
cd ../../..
