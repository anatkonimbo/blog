class AddRateToComment < ActiveRecord::Migration
  def change
    add_column :comments, :rate, :int
  end
end
