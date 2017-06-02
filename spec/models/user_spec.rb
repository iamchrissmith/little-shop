require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it { should have_many(:addresses) }
    it { should have_many(:cities).through(:addresses) }
    it { should have_many(:states).through(:cities) }

    it { should have_secure_password }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

  end

  describe 'Factory' do

    it 'should be a User' do
      expect(create(:user)).to be_a(User)
    end

    it 'should have attributes' do
      user = create(:user)

      expect(user.first_name).to be_a(String)
      expect(user.last_name).to be_a(String)
      expect(user.email).to be_a(String)

      user.addresses.each do |address|
        expect(address).to be_a(Address)
      end

      describe 'traits' do

        it 'with address' do
          user = create(:user, :with_address)
        end
      end
    end
  end
end
