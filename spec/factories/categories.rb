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
      after(:build) do |category|
        create_list(:image, 2, parent: category)
      end
    end

    trait :with_sub_categories do
      after(:build) do |category|
        create_list(:category, 2, parent_id: category.id)
      end
    end
  end
end
