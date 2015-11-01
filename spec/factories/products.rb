FactoryGirl.define do
  factory :product do |f|
    f.name { Faker::Commerce.product_name }
  end

  trait :with_images do
    ignore do
      number_of_images 3
    end

    after(:create) do |product, evaluator|
      create_list(:image, evaluator.number_of_images, parent: product)
    end
  end
end
