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
