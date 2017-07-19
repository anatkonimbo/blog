class AddAvrRateToPost < ActiveRecord::Migration
  def change
    add_column :posts, :avrRate, :float
  end
end
