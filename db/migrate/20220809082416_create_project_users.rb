class CreateProjectUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :project_users do |t|
      t.belongs_to :user, null: false, foreign_kye: true
      t.belongs_to :project, null: false, foreign_kye: true
      t.timestamps
    end
    add_index :project_users, %i[user_id project_id], name: 'unique_project_user', unique: true
  end
end
