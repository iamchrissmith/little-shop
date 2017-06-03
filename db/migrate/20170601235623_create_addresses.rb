class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :zipcode
      t.references :city, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
