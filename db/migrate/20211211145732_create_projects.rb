class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :uuid
      t.string :title
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
