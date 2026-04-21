FactoryBot.define do
  factory :jlpt_level do
    sequence(:level_description) { |n| "N#{n}-Gen" }
    sequence(:position) { |n| n + 10 }

    trait :n5 do
      level_description { "N5" }
      position { 1 }
    end

    trait :n4 do
      level_description { "N4" }
      position { 2 }
    end

    trait :n3 do
      level_description { "N3" }
      position { 3 }
    end

    trait :n2 do
      level_description { "N2" }
      position { 4 }
    end

    trait :n1 do
      level_description { "N1" }
      position { 5 }
    end
  end
end
