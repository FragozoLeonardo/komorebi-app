# frozen_string_literal: true

FactoryBot.define do
  factory :review_log do
    association :user
    association :reviewable, factory: :kanji
    quality { 4 }
  end
end
