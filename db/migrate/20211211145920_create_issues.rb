class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|
      t.string :uuid
      t.string :title
      t.string :severity
      t.float :score
      t.text :description
      t.string :status
      t.text :solution

      t.belongs_to :scope, null: false, foreign_key: false

      t.timestamps
    end
  end
end
