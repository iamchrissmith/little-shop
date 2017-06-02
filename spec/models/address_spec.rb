require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is invalid without a city" do
      address = build(:address, city: nil)
      expect(address).to be_invalid
    end

    it "is invalid without an address" do
      address = build(:address, address: '')
      expect(address).to be_invalid
    end

    it "is invalid without a user" do
      address = build(:address, user: nil)
      expect(address).to be_invalid
    end

    it "is invalid without a zipcode" do
      address = build(:address, zipcode: '')
      expect(address).to be_invalid
    end
  end

  context "with valid attributes" do
    it "address is valid with all required attributes" do
      address = build(:address)
      expect(address).to be_valid
    end
  end

  describe "relationships" do
    it "has one user" do
      address = create(:address)
      expect(address).to respond_to(:user)
    end

    it "has one city" do
      address = create(:address)
      expect(address).to respond_to(:city)
    end

    it "has one state" do
      address = create(:address)
      expect(address).to respond_to(:state)
    end
  end
end
