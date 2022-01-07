class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :message

      t.belongs_to :issue, null: false, foreign_key: false

      t.timestamps
    end
  end
end
