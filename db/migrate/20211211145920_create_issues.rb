class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|
      t.text :title
      t.string :severity
      t.float :score
      t.text :description
      t.string :status
      t.text :solution

      t.timestamps
    end
  end
end
