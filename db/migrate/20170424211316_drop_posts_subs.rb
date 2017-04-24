class DropPostsSubs < ActiveRecord::Migration
  def change
    drop_table :posts_subs
  end
end
