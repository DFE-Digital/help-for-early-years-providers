class CreateContentPages < ActiveRecord::Migration[7.1]
  def change
    create_table :content_pages, force: :cascade do |t|
      t.string :slug
      t.string :title
      t.string :intro
      t.string :content_list
      t.string :markdown
      t.string :author
      t.string :description
      t.integer :parent_id
      t.integer :previous_id
      t.integer :next_id
      t.integer :position
      t.boolean :is_published, default: false, null: false

      t.timestamps
    end
    add_index :content_pages, :title, unique: true
    add_index :content_pages, %i[position parent_id], unique: true
  end
end
