require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations"do
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
end
