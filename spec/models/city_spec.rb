require 'rails_helper'

RSpec.describe City, type: :model do

  describe 'Validations' do

    it { should have_many(:addresses) }
    it { should belong_to(:state) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:state_id) }

  end

  describe 'Factory' do

    it 'should be a City' do
end
