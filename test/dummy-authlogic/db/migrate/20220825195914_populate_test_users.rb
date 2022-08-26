class PopulateTestUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :role, :string
    100.times { User.create(name: gen_name, age: rand(100), email: gen_email, role: gen_role, password: '12345678') }
  end

  private

  def gen_name
    ['Igor', 'Michael' 'John', 'Stan', 'Bob', 'Kris', 'Alan'].sample + ' ' + rand(1000).to_s
  end

  def gen_email
    email = ['Igor', 'Michael' 'John', 'Stan', 'Bob', 'Kris', 'Alan'].sample + rand(1000).to_s + '@gmail.com'
    email.downcase
  end

  def gen_role
    ['admin', 'user', 'moderator'].sample
  end
end
