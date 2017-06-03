require 'rails_helper'

RSpec.describe Address, type: :model do

  describe 'Validations' do

    it { should have_many(:orders) }
    it { should belong_to(:city) }
    it { should have_one(:state).through(:city) }
    it { should validate_presence_of(:city_id) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:zipcode) }

  end

  describe 'Factory' do

    it 'is a Address' do
      expect(create(:address)).to be_a(Address)
    end

    it 'has attributes' do
      address = create(:address)


      address.orders.each do |order|
        expect(order).to be_a(Order)
      end
      expect(address.city).to be_a(City)

      expect(address.address).to be_a(String)
      expect(address.zipcode).to be_a(String)
    end
  end
end
