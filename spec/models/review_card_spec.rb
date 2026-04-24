# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewCard, type: :model do
  describe 'validations' do
    it 'is invalid without an ease_factor' do
      card = build(:review_card, ease_factor: nil)
      expect(card).not_to be_valid
    end

    it 'is invalid with an ease_factor below 1.3' do
      card = build(:review_card, ease_factor: 1.2)
      expect(card).not_to be_valid
      expect(card.errors[:ease_factor]).to include("must be greater than or equal to 1.3")
    end
  end

  describe 'polymorphic association' do
    it 'is valid when reviewable is a Kanji' do
      kanji = create(:kanji)
      card = build(:review_card, reviewable: kanji)
      expect(card).to be_valid
      expect(card.reviewable_type).to eq('Kanji')
    end
  end

  describe 'database-level protection' do
    it 'raises NotNullViolation if user_id is missing at DB level' do
      expect {
        ReviewCard.insert({
                            reviewable_type: 'Kanji',
                            reviewable_id: 1,
                            ease_factor: 2.5,
                            interval: 0,
                            repetitions: 0,
                            next_review: Time.current,
                            created_at: Time.current,
                            updated_at: Time.current
                          })
      }.to raise_error(ActiveRecord::NotNullViolation)
    end
  end
end
