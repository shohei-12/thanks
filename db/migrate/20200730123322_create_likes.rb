class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps

      t.index %i[user_id post_id], unique: true
      t.index %i[user_id comment_id], unique: true
    end
  end
end
