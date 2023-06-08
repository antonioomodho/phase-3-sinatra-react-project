class Users < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :user_id
      t.string :username
      t.string :email
      t.string :password
      t.string :first_name
      t.string :last_name
      t.timestamps
    end

  end
end
