# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewLog, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)

      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to a polymorphic reviewable' do
      association = described_class.reflect_on_association(:reviewable)

      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:polymorphic]).to be(true)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      review_log = build(:review_log)

      expect(review_log).to be_valid
    end

    it 'is invalid without quality' do
      review_log = build(:review_log, quality: nil)

      expect(review_log).not_to be_valid
      expect(review_log.errors[:quality]).to include("can't be blank")
    end

    it 'is invalid when quality is less than 0' do
      review_log = build(:review_log, quality: -1)

      expect(review_log).not_to be_valid
      expect(review_log.errors[:quality]).to include('is not included in the list')
    end

    it 'is invalid when quality is greater than 5' do
      review_log = build(:review_log, quality: 6)

      expect(review_log).not_to be_valid
      expect(review_log.errors[:quality]).to include('is not included in the list')
    end
  end

  describe 'polymorphic reviewable' do
    it 'can reference a kanji' do
      kanji = create(:kanji)
      review_log = build(:review_log, reviewable: kanji)

      expect(review_log).to be_valid
      expect(review_log.reviewable).to eq(kanji)
    end
  end
end
