class CreateScopes < ActiveRecord::Migration[6.1]
  def change
    create_table :scopes do |t|
      t.text :url
      t.text :description
      t.string :version

      t.timestamps
    end
  end
end
