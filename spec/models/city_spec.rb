require 'rails_helper'

RSpec.describe City, type: :model do

  describe 'Validations' do

    it { should have_many(:addresses) }
    it { should belong_to(:state) }
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:state_id) }

  end

  describe 'Factory' do

    before do
      @city = create(:city)
    end

    it 'should be a City' do
      expect(@city).to be_a(City)
    end

    it 'should have attributes' do
      expect(@city.name).to be_a(String)
      expect(@city.state).to be_a(State)
    end
  end

end
