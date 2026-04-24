# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Kanji, type: :model do
  it_behaves_like 'reviewable'

  describe 'successful creation' do
    it 'is valid with all factory attributes' do
      expect(build(:kanji)).to be_valid
    end

    it 'persists the data correctly' do
      kanji = create(:kanji, kanji: "人", meaning: "Pessoa")
      expect(kanji.reload.kanji).to eq("人")
      expect(kanji.meaning).to eq("Pessoa")
    end
  end

  describe 'validations' do
    it 'is invalid without a kanji character' do
      kanji = build(:kanji, kanji: nil)
      expect(kanji).not_to be_valid
      expect(kanji.errors[:kanji]).to include("can't be blank")
    end

    it 'is invalid if the kanji character is already taken' do
      create(:kanji, kanji: "木")
      duplicate = build(:kanji, kanji: "木")
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:kanji]).to include("has already been taken")
    end
  end

  describe 'associations' do
    it 'belongs to a jlpt_level' do
      kanji = build(:kanji, jlpt_level: nil)
      expect(kanji).not_to be_valid
      expect(kanji.errors[:jlpt_level]).to include("must exist")
    end
  end

  describe 'database constraints' do
    it 'raises a NotNullViolation if jlpt_level_id is missing' do
      expect {
        Kanji.insert({
                       kanji: "水",
                       meaning: "Água",
                       created_at: Time.current,
                       updated_at: Time.current
                     })
      }.to raise_error(ActiveRecord::NotNullViolation)
    end
  end
end
