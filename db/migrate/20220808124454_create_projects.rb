class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name, index: { unique: true, name: 'unique_names' }
      t.timestamps
    end
  end
end
