# frozen_string_literal: true

module Srs
  class Sm2Calculator
    MIN_EASE_FACTOR = 1.3
    MIN_QUALITY = 0
    MAX_QUALITY = 5

    def initialize(card, quality)
      @card = card
      @quality = quality.to_i
    end

    def call
      validate_quality!

      update_interval
      update_ease_factor
      schedule_next_review

      @card
    end

    private

    def validate_quality!
      return if @quality.between?(MIN_QUALITY, MAX_QUALITY)

      raise ArgumentError, "quality must be between #{MIN_QUALITY} and #{MAX_QUALITY}"
    end

    def update_interval
      if @quality < 3
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
      else
        (@card.interval * @card.ease_factor).round
      end
    end

    def update_ease_factor
      distance_from_perfect_score = 5 - @quality
      adjustment = 0.1 - distance_from_perfect_score * (0.08 + distance_from_perfect_score * 0.02)
      new_ease_factor = @card.ease_factor + adjustment

      @card.ease_factor = [ new_ease_factor, MIN_EASE_FACTOR ].max
    end

    def schedule_next_review
      @card.next_review = Time.current + @card.interval.days
    end
  end
end
