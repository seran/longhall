class CreateScopes < ActiveRecord::Migration[6.1]
  def change
    create_table :scopes do |t|
      t.string :uuid
      t.string :title
      t.text :description
      t.string :version

      t.belongs_to :project, null: false, foreign_key: false

      t.timestamps
    end
  end
end
