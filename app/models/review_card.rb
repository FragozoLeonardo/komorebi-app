# frozen_string_literal: true

class ReviewCard < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  validates :ease_factor, :interval, :repetitions, :next_review, presence: true
  validates :ease_factor, numericality: { greater_than_or_equal_to: 1.3 }
end
