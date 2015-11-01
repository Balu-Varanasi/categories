FactoryGirl.define do
  factory :product do |f|
    f.name { Faker::Commerce.product_name }
  end
end
