class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, index: { unique: true, name: 'unique_usernames' }
      t.string :email, null: false
      t.string :password_digest
      t.integer :role

      t.timestamps
    end
  end
end
