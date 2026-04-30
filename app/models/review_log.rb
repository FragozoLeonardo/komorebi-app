# frozen_string_literal: true

class ReviewLog < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true
  validates :quality, presence: true, inclusion: { in: 0..5 }
end
