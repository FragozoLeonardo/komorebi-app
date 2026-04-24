# frozen_string_literal: true

class Kanji < ApplicationRecord
  belongs_to :jlpt_level
  has_many :review_cards, as: :reviewable, dependent: :destroy

  validates :kanji, presence: true, uniqueness: true
  validates :meaning, presence: true
  validates :jlpt_level, presence: true
end
