class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|
      t.string :uuid
      t.string :title
      t.integer :severity
      t.integer :status, default: 0
      t.float :score
      t.text :description
      t.text :solution

      t.belongs_to :scope, null: true, foreign_key: false
      t.belongs_to :user, null: true, foreign_key: false

      t.timestamps
    end
  end
end
