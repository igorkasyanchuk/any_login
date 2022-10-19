class PopulateTestStaffs < ActiveRecord::Migration[6.1]
  def change
    add_column :staffs, :role, :string
    100.times { |t| Staff.create(name: gen_name(t), age: rand(100), email: gen_email(t), role: gen_role, password: '12345678') }
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
