class CreateWorkDays < ActiveRecord::Migration[7.0]
  def change
    create_table :work_days do |t|
      t.belongs_to :user, null: false, foreign_kye: true
      t.belongs_to :project, null: false, foreign_kye: true
      t.datetime :work_start, null: false
      t.datetime :work_end, null: false
    end
    add_index :work_days, %i[user_id project_id work_start work_end], name: 'unique_work_days'
  end
end
