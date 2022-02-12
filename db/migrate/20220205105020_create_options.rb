class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options do |t|

      t.text :slack
      t.boolean :notify_new
      t.boolean :notify_updates

      t.timestamps
    end
  end
end
