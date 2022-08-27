class PopulateTestUsers < ActiveRecord::Migration[6.1]
  def change
    100.times { |t| User.create(name: gen_name(t), age: rand(100), email: gen_email(t), role: gen_role, password: '12345678') }
  end

  private

  def gen_name(number)
    ['Igor', 'Michael' 'John', 'Stan', 'Bob', 'Kris', 'Alan'].sample + ' ' + number.to_s
  end

  def gen_email(number)
    email = ['Igor', 'Michael' 'John', 'Stan', 'Bob', 'Kris', 'Alan'].sample + number.to_s + '@gmail.com'
    email.downcase
  end

  def gen_role
    ['admin', 'user', 'moderator'].sample
  end
end
