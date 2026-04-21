require 'rails_helper'

RSpec.describe JlptLevel, type: :model do
  describe 'successful creation' do
    it 'is valid with a level_description and a positive integer position' do
      level = JlptLevel.new(level_description: 'N1', position: 5)
      expect(level).to be_valid
    end

    it 'persists the data correctly' do
      level = create(:jlpt_level, level_description: 'Trabalho', position: 6)
      expect(level.reload.level_description).to eq('Trabalho')
      expect(level.position).to eq(6)
    end

    it 'maintains the default order by position' do
      create(:jlpt_level, level_description: 'N1', position: 5)
      create(:jlpt_level, level_description: 'N5', position: 1)
      create(:jlpt_level, level_description: 'N3', position: 3)

      expect(JlptLevel.all.map(&:level_description)).to eq([ 'N5', 'N3', 'N1' ])
    end
  end

  describe 'validations and constraints' do
    it 'is invalid without a level_description' do
      level = JlptLevel.new(level_description: nil, position: 1)
      expect(level).not_to be_valid
      expect(level.errors[:level_description]).to include("can't be blank")
    end

    context 'when data already exists' do
      before { create(:jlpt_level, level_description: 'N1', position: 5) }

      it 'is invalid with a duplicate description' do
        duplicate = JlptLevel.new(level_description: 'N1', position: 1)
        expect(duplicate).not_to be_valid
        expect(duplicate.errors[:level_description]).to include("has already been taken")
      end

      it 'is invalid with a duplicate position' do
        duplicate = JlptLevel.new(level_description: 'N2', position: 5)
        expect(duplicate).not_to be_valid
        expect(duplicate.errors[:position]).to include("has already been taken")
      end
    end

    describe 'position boundaries' do
      it 'is invalid with a position of 0' do
        level = JlptLevel.new(level_description: 'N5', position: 0)
        expect(level).not_to be_valid
        expect(level.errors[:position]).to include("must be greater than 0")
      end

      it 'is invalid with a negative position' do
        level = JlptLevel.new(level_description: 'N5', position: -1)
        expect(level).not_to be_valid
        expect(level.errors[:position]).to include("must be greater than 0")
      end
    end
  end

  # ... (seus testes anteriores de unicidade e position)

  describe 'associations' do
    it 'can have many kanjis' do
      level = create(:jlpt_level)
      create(:kanji, jlpt_level: level, kanji: "A")
      create(:kanji, jlpt_level: level, kanji: "B")

      expect(level.kanjis.count).to eq(2)
    end

    it 'destroys associated kanjis when the level is deleted' do
      level = create(:jlpt_level)
      create(:kanji, jlpt_level: level)

      expect { level.destroy }.to change(Kanji, :count).by(-1)
    end
  end

  describe 'database-level constraints' do
    it 'raises a database error when bypassing Rails validations for uniqueness' do
      create(:jlpt_level, level_description: 'N1', position: 5)

      expect {
        JlptLevel.new(level_description: 'N1', position: 1).save(validate: false)
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it 'raises a database error when bypassing Rails validations for negative position' do
      expect {
        JlptLevel.insert({ level_description: 'Error', position: -1, created_at: Time.current, updated_at: Time.current })
      }.to raise_error(ActiveRecord::StatementInvalid, /position_check/)
    end
  end
end
