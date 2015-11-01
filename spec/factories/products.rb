FactoryGirl.define do
  factory :product do |f|
    f.name { Faker::Commerce.product_name }
  end

  trait :with_images do
    after(:build) do |product|
      create_list(:image, 2, parent: product)
    end
  end
end
