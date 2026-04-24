# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with a name and a unique email' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'is invalid with a duplicate email' do
      create(:user, email: "leo@komorebi.com")
      duplicate = build(:user, email: "LEO@komorebi.com")
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:email]).to include("has already been taken")
    end
  end

  describe 'associations' do
    it 'destroys review_cards when user is deleted' do
      user = create(:user)
      create(:review_card, user: user)
      expect { user.destroy }.to change(ReviewCard, :count).by(-1)
    end
  end
end
