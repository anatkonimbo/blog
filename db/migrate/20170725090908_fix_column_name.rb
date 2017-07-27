class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :comments, :showCom, :show_comment
    rename_column :comments, :lastname, :last_name
  end

  def down
  end
end
