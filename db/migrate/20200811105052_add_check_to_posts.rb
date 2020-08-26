class AddCheckToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :check, :integer, null: false
  end
end
