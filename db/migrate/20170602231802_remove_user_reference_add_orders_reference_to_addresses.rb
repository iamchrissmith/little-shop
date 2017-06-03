class RemoveUserReferenceAddOrdersReferenceToAddresses < ActiveRecord::Migration[5.1]
  def change
    remove_reference :addresses, :user
    add_reference :orders, :addresses
  end
end
