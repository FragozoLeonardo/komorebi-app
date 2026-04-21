FactoryBot.define do
  factory :kanji do
    sequence(:kanji) { |n| "字#{n}" }
    sequence(:meaning) { |n| "Meaning #{n}" }
    on_reading { "on_yomi" }
    kun_reading { "kun_yomi" }

    association :jlpt_level
  end
end
