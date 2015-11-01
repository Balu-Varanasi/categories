# Category Spec
RSpec.describe Category, type: :model do
  let(:category) { FactoryGirl.create(:category) }

  it 'has a valid factory' do
    expect(FactoryGirl.build(:category)).to be_valid
  end

  context ':name' do
    it 'belongs to string class' do
      expect(category.name.class).to eq(String)
    end
  end

  context ':images' do
    it 'create records with zero images' do
      category = FactoryGirl.create(:category)
      expect(category.images.count).to eq(0)
    end

    it 'create records with given number of images' do
      category = FactoryGirl.create(
        :category,
        :with_images,
        number_of_images: 2)
      expect(category.images.count).to eq(2)
    end
  end

  context ':sub_categories' do
    it 'create records with zero sub_categories' do
      category = FactoryGirl.create(:category)
      expect(category.sub_categories.count).to eq(0)
    end

    it 'create records with given number of sub_categories' do
      category = FactoryGirl.create(
        :category,
        :with_sub_categories,
        number_of_sub_categories: 3)
      expect(category.sub_categories.count).to eq(3)
    end
  end

  context 'validations' do
    it 'error while saving active dish without image' do
      expect do
        FactoryGirl.create(:category, name: nil)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
