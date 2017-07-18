class AddColumnsToComment < ActiveRecord::Migration
  def change
    add_column :comments, :lastname, :string
    add_column :comments, :tel, :integer
  end
end
