require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'Validations' do

    it { should have_many(:categories).through(:item_categories) }
    it { should validate_presence_of(:categories) }
    it { should have_many(:orders).through(:order_items) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price) }

  end

  describe 'Factory' do

    before do
      @item = create(:item)
    end

    it 'should be an Item' do
      expect(@item).to be_a(Item)
    end

    it 'should have attributes' do
      expect(@item.name).to be_a(String)
      expect(@item.description).to be_a(String)
      expect(@item.price).to be_a(Float)
      expect(@item.categories.count).to eq(1)
      expect(@item.categories.first).to be_a(Category)
      expect(@item.photo).to be_a(Paperclip::Attachment)
    end

    it 'should have traits' do
      item = create(:item, :with_more_categories)
      expect(item.categories.count).to eq(3)

      item = create(:item, :with_more_categories, category_count: 3)
      expect(item.categories.count).to eq(4)
    end
  end

  describe 'Enums' do

    it 'defaults to active and can be retired' do
      item = create(:item)
      expect(item.active?).to be_truthy

      item.retired!
      expect(item.retired?).to be_truthy
    end

    it 'can be retired and made active' do
      item = create(:item, status: 'retired')
      expect(item.retired?).to be_truthy

      item.active!
      expect(item.active?).to be_truthy
    end
  end
end
