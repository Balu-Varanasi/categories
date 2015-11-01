FactoryGirl.define do
  factory :image do
    image { File.open(File.join(Rails.root, 'spec/fixtures/images/test.png')) }
    before(:create) do |image, evaluator|
      offset = rand(Category.count)
      image.parent = Category.offset(offset).first if evaluator.parent.blank? && offset > 0
    end
  end
end
