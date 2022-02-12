class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :uuid
      t.string :title
      t.text :description
      t.integer :status, default: 0

      t.belongs_to :user, null: false, foreign_key: false

      t.timestamps
    end
  end
end
