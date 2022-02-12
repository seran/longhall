class InsertDefaultOptions < ActiveRecord::Migration[6.1]
  def change
    execute "insert into options (slack, notify_new, notify_updates, id, created_at, updated_at) values(null, 0, 0, 1, now(), now())"
  end

  def down
    execute "delete from options where id = 1"
  end
end
