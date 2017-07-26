class FixColumnName1 < ActiveRecord::Migration
  def up
    rename_column :posts, :avrRate, :avr_rates
    rename_column :comments, :rate, :rates
  end

  def down
  end
end
