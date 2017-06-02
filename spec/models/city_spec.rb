require 'rails_helper'

RSpec.describe City, type: :model do
  describe "validations" do
    it "is invalid without a name" do
      city = build(:city, name: '')
      expect(city).to be_invalid
    end

    it "is invalid without a state" do
      city = build(:city, state: nil)
      expect(city).to be_invalid
    end
  end

  context "with valid attributes" do
    it "user is valid with all required attributes" do
      city = build(:city)
      expect(city).to be_valid
    end
  end

  describe "relationships" do
    it "has one state" do
      city = build(:city)
      expect(city).to respond_to(:state)
    end
  end
end
