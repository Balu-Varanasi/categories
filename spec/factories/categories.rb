FactoryGirl.define do
  factory :category do |f|
    f.name { Faker::Commerce.department }

    trait :with_parent do
      after(:build) do |category|
        offset = rand(Category.count)
        category.parent_id = offset > 0 ? Category.offset(offset).first.id : create(:category).id
      end
    end

    trait :with_images do
      ignore do
        number_of_images 3
      end

      after(:create) do |category, evaluator|
        create_list(:image, evaluator.number_of_images, parent: category)
      end
    end

    trait :with_sub_categories do
      ignore do
        number_of_sub_categories 2
      end
      after(:create) do |category, evaluator|
        create_list(:category, evaluator.number_of_sub_categories, parent_id: category.id)
      end
    end

    trait :with_products do
      ignore do
        number_of_products 4
      end
      after(:create) do |category, evaluator|
        create_list(:product, evaluator.number_of_products, category: category)
      end
    end
  end
end
