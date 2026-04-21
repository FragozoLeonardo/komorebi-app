require 'rails_helper'

RSpec.describe Kanji, type: :model do
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
      expect(build(:kanji, kanji: nil)).not_to be_valid
    end

    it 'is invalid without a meaning' do
      expect(build(:kanji, meaning: nil)).not_to be_valid
    end

    it 'is invalid if the kanji character is already taken' do
      create(:kanji, kanji: "一")
      duplicate = build(:kanji, kanji: "一")
      expect(duplicate).not_to be_valid
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
                       kanji: "木",
                       meaning: "Árvore, madeira",
                       created_at: Time.current,
                       updated_at: Time.current
                     })
      }.to raise_error(ActiveRecord::NotNullViolation)
    end
  end
end
