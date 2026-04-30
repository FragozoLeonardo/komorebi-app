# frozen_string_literal: true

module Srs
  class Sm2Calculator
    MIN_EASE = 1.3

    def initialize(card, quality)
      @card = card
      @q = quality.to_i
    end

    def calculate!
      return @card unless @q.between?(0, 5)

      update_interval
      update_ease_factor

      @card.next_review = Time.current + @card.interval.days
      @card
    end

    private

    def update_interval
      if @q < 3
        @card.repetitions = 0
        @card.interval = 1
      else
        @card.interval = calculate_success_interval
        @card.repetitions += 1
      end
    end

    def calculate_success_interval
      case @card.repetitions
      when 0 then 1
      when 1 then 6
      else (@card.interval * @card.ease_factor).round
      end
    end

    def update_ease_factor
      new_ease = @card.ease_factor + (0.1 - (5 - @q) * (0.08 + (5 - @q) * 0.02))
      @card.ease_factor = [ new_ease, MIN_EASE ].max
    end
  end
end
