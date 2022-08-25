class SorceryCore < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string :crypted_password
      t.string :salt
    end
  end
end
