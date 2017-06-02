require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is invalid without a first name" do
      user = build(:user, first_name: '')
      expect(user).to be_invalid
    end

    it "is invalid without a last name" do
      user = build(:user, last_name: '')
      expect(user).to be_invalid
    end

    it "is invalid without an email" do
      user = build(:user, email: '')
      expect(user).to be_invalid
    end

    it "is invalid without a unique email" do
      user_first = create(:user)
      user = build(:user, email: user_first.email)
      expect(user).to be_invalid
    end

    it "is invalid without a password" do
      user = build(:user, password: '')
      expect(user).to be_invalid
    end
  end

  context "with valid attributes" do
    it "user is valid with all required attributes" do
      user = build(:user)
      expect(user).to be_valid
    end
  end

  describe "relationships" do
    it "has many addresses" do
      user = create(:user)
      expect(user).to respond_to(:addresses)
    end

    it "has many cities" do
      user = create(:user)
      expect(user).to respond_to(:cities)
    end

    it "has many states" do
      user = create(:user)
      expect(user).to respond_to(:states)
    end
  end
end
