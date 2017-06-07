require 'rails_helper'

RSpec.describe Category do

  describe 'Validations' do

    it { should have_many(:items).through(:item_categories) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:slug) }

  end

  describe 'Factory' do

    before do
      @category = create(:category)
    end

    it 'should be a Category' do
      expect(@category).to be_a(Category)
    end

    it 'should have attributes' do
      expect(@category.name).to be_a(String)
    end

    it 'should have traits' do
      category = create(:category, :with_items, item_count: 3)

      expect(category.items.count).to eq(3)

      category.items.each do |item|
        expect(item).to be_a(Item)
      end
    end
  end
end
