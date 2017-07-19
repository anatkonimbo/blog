class AddShowComToComment < ActiveRecord::Migration
  def change
    add_column :comments, :showCom, :boolean
  end
end
