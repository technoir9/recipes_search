# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    title { Faker::Food.dish }
    cook_time { rand(5..500) }
    prep_time { rand(5..180) }
    ingredients { ['garlic', 'onion', 'sugar', 'salt'] }
    ratings { rand(100..500) / 100.0 }
    cuisine { '' }
    category { Faker::Food.ethnic_category }
    author { Faker::Name.name_with_middle }
    image { '' }
  end
end
