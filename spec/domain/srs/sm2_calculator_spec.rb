# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Srs::Sm2Calculator do
  let(:card) { Struct.new(:repetitions, :interval, :ease_factor, :next_review).new(0, 0, 2.5, nil) }

  describe '#calculate!' do
    it "sets first interval to 1 for quality 5" do
      described_class.new(card, 5).calculate!
      expect(card.interval).to eq(1)
      expect(card.repetitions).to eq(1)
    end

    it "resets interval when quality is low" do
      card.repetitions = 3
      card.interval = 12
      described_class.new(card, 2).calculate!
      expect(card.interval).to eq(1)
      expect(card.repetitions).to eq(0)
    end
  end
end
