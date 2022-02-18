class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name

      t.belongs_to :issue, null: true, foreign_key: false
      t.belongs_to :user, null: true, foreign_key: false

      t.timestamps
    end
  end
end
