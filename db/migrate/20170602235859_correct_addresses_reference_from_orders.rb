class CorrectAddressesReferenceFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_reference :orders, :addresses
    add_reference :orders, :address
  end
end
