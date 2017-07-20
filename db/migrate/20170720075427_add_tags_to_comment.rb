class AddTagsToComment < ActiveRecord::Migration
  def change
    add_column :comments, :tags, :string
  end
end
