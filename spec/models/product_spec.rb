# Product Spec
RSpec.describe Product, type: :model do
  let(:product) { FactoryGirl.create(:product) }

  it 'has a valid factory' do
    expect(FactoryGirl.build(:product)).to be_valid
  end

  context ':name' do
    it 'belongs to string class' do
      expect(product.name.class).to eq(String)
    end
  end

  context ':images' do
    it 'create records with zero images' do
      product = FactoryGirl.create(:product)
      expect(product.images.count).to eq(0)
    end

    it 'create records with given number of images' do
      product = FactoryGirl.create(
        :product,
        :with_images,
        number_of_images: 2)
      expect(product.images.count).to eq(2)
    end
  end

  context 'validations' do
    it 'error while saving active dish without image' do
      expect do
        FactoryGirl.create(:product, name: nil)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
