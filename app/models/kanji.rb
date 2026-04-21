class Kanji < ApplicationRecord
  belongs_to :jlpt_level

  validates :kanji, presence: true, uniqueness: true
  validates :meaning, presence: true
  validates :jlpt_level, presence: true
end
