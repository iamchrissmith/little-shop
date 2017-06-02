class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.float :price
      t.integer :status, default: 'active'

      t.timestamps null: false
    end
  end
end
