bundle
BUNDLE_GEMFILE=./gemfiles/rails_8_0.gemfile bundle
mkdir log
cd test/rails_apps/authlogic/
BUNDLE_GEMFILE=../../../gemfiles/rails_8_0.gemfile bundle exec rails db:migrate
BUNDLE_GEMFILE=../../../gemfiles/rails_8_0.gemfile RAILS_ENV=test bundle exec rails db:migrate
cd ../../..
cd test/rails_apps/devise/
BUNDLE_GEMFILE=../../../gemfiles/rails_8_0.gemfile bundle exec rails db:migrate
BUNDLE_GEMFILE=../../../gemfiles/rails_8_0.gemfile RAILS_ENV=test bundle exec rails db:migrate
cd ../../..
cd test/rails_apps/clearance/
BUNDLE_GEMFILE=../../../gemfiles/rails_8_0.gemfile bundle exec rails db:migrate
BUNDLE_GEMFILE=../../../gemfiles/rails_8_0.gemfile RAILS_ENV=test bundle exec rails db:migrate
cd ../../..
cd test/rails_apps/sorcery/
BUNDLE_GEMFILE=../../../gemfiles/rails_8_0.gemfile bundle exec rails db:migrate
BUNDLE_GEMFILE=../../../gemfiles/rails_8_0.gemfile RAILS_ENV=test bundle exec rails db:migrate
cd ../../..
