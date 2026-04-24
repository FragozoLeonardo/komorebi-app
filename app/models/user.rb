# frozen_string_literal: true

class User < ApplicationRecord
  has_many :review_cards, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  before_save { email.downcase! }
end
