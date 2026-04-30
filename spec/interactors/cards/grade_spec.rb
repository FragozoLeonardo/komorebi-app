# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cards::Grade do
  let(:user)  { create(:user) }
  let(:kanji) { create(:kanji) }
  let(:card)  { create(:review_card, user: user, reviewable: kanji) }

  describe ".call" do
    context "when input is invalid" do
      it "fails if card is missing" do
        result = described_class.call(card: nil, quality: 5)
        expect(result).to be_a_failure
        expect(result.message).to eq(:card_missing)
      end

      it "fails if quality is out of range" do
        result = described_class.call(card: card, quality: 10)
        expect(result).to be_a_failure
        expect(result.message).to eq(:invalid_quality)
      end
    end

    context "when database fails" do
      it "rolls back card updates if log creation fails" do
        allow_any_instance_of(ReviewLog).to receive(:save!).and_raise(ActiveRecord::RecordInvalid)

        initial_interval = card.interval
        result = described_class.call(card: card, quality: 5)

        expect(result).to be_a_failure
        expect(result.message).to eq(:database_error)
        expect(card.reload.interval).to eq(initial_interval)
      end
    end

    context "when everything is valid (Happy Path)" do
      it "successfully updates the card and creates a log" do
        result = described_class.call(card: card, quality: 5, response_time_ms: 500)

        expect(result).to be_a_success
        expect(card.reload.repetitions).to eq(1)
        expect(user.review_logs.count).to eq(1)
        expect(user.review_logs.last.quality).to eq(5)
      end
    end
  end
end
