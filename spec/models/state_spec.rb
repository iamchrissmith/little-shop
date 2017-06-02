require 'rails_helper'

RSpec.describe State, type: :model do
  describe 'validations' do
    it 'is invalid without a name' do
      state = build(:state, name: '')
      expect(state).to be_invalid
    end

    it 'is invalid without an abbr' do
      state = build(:state, abbr: '')
      expect(state).to be_invalid
    end
  end

  context 'with valid attributes' do
    it 'user is valid with all required attributes' do
      state = build(:state)
      expect(state).to be_valid
    end
  end

  describe 'relationships' do
    it 'has many cities' do
      state = build(:state)
      expect(state).to respond_to(:cities)
    end
  end
end
