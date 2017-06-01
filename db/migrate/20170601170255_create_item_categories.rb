class CreateItemCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :item_categories do |t|
      t.references :category, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps null: false
    end
  end
end
