class ChangePriceToFloatOnOrderItems < ActiveRecord::Migration[5.1]
  def change
    change_column :order_items, :price, :float
  end
end
