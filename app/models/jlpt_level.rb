# frozen_string_literal: true

class JlptLevel < ApplicationRecord
  has_many :kanjis, dependent: :destroy

  validates :level_description, presence: true, uniqueness: true
  validates :position, presence: true, uniqueness: true, numericality: { only_integer: true, greater_than: 0 }

  default_scope { order(:position) }
end
