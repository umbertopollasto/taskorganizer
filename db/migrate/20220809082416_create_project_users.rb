class CreateProjectUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :project_users do |t|
      t.belongs_to :user, foreign_kye: true
      t.belongs_to :project, foreign_kye: true
      t.datetime :work_start
      t.datetime :work_end
    end
    add_index :project_users, %i[user_id project_id work_start work_end], name: 'unique_project_user'
  end
end
