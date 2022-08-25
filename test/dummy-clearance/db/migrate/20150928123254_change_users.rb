class ChangeUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string :login

      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token

      t.integer :login_count
      t.integer :failed_login_count
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip
    end
  end
end
