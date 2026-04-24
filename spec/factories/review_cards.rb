# frozen_string_literal: true

FactoryBot.define do
  factory :review_card do
    association :user
    association :reviewable, factory: :kanji
    ease_factor { 2.5 }
    interval { 0 }
    repetitions { 0 }
    next_review { Time.current }
  end
end
