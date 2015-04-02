class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.references :commentable, polymorphic: true, index: true
      t.text :comment, null: false
      t.timestamps null: false
    end

    add_index :comments, :commentable_id
  end
end
