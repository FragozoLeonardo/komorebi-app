# frozen_string_literal: true

module Cards
  class Grade
    include Interactor

    def call
      validate_params!

      card = context.card
      quality = normalized_quality

      ActiveRecord::Base.transaction do
        Srs::Sm2Calculator.new(card, quality).call
        card.save!
        create_log!(card, quality)
      end
    rescue ActiveRecord::ActiveRecordError => error
      context.fail!(message: :database_error, detail: error.message)
    rescue Interactor::Failure
      raise
    rescue StandardError => error
      context.fail!(message: :unexpected_error, detail: error.message)
    end

    private

    def validate_params!
      context.fail!(message: :card_missing) unless context.card

      context.fail!(message: :invalid_quality) unless normalized_quality.between?(0, 5)
    end

    def normalized_quality
      context.quality.to_i
    end

    def create_log!(card, quality)
      context.log = card.user.review_logs.create!(
        reviewable: card.reviewable,
        quality: quality,
        interval: card.interval,
        ease_factor: card.ease_factor,
        response_time_ms: context.response_time_ms
      )
    end
  end
end
