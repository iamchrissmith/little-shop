require 'rails_helper'

RSpec.describe State, type: :model do

  describe 'Validations' do

    it { should have_many(:cities) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:abbr) }
    it { should validate_uniqueness_of(:abbr) }
  end

  define 'Factory' do

    it 'should be a State' do
      expect(create(:state)).to be_a(State)
    end

    it 'should have attributes' do
      state = create(:state)

      expect(state.name).to be_a(String)
      expect(state.abbr).to be_a(String)
    end

    describe 'traits' do

      it 'should have cities' do
        state = create(:state, :with_cities, city_count: 3)
        expect(state.cities.count).to eq(3)
      end
    end
  end
end
