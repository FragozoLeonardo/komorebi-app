# frozen_string_literal: true

module Cards
  class Grade
    include Interactor

    def call
      validate_params!

      ActiveRecord::Base.transaction do
        Srs::Sm2Calculator.new(context.card, context.quality).calculate!
        context.card.save!
        create_log!
      end
    rescue ActiveRecord::ActiveRecordError => e
      context.fail!(message: :database_error, detail: e.message)
    rescue Interactor::Failure
      raise
    rescue StandardError => e
      context.fail!(message: :unexpected_error, detail: e.message)
    end

    private

    def validate_params!
      context.fail!(message: :card_missing) if context.card.nil?

      quality = context.quality.to_i
      context.fail!(message: :invalid_quality) unless quality.between?(0, 5)
    end

    def create_log!
      context.log = context.card.user.review_logs.create!(
        reviewable: context.card.reviewable,
        quality: context.quality.to_i,
        interval: context.card.interval,
        ease_factor: context.card.ease_factor,
        response_time_ms: context.response_time_ms
      )
    end
  end
end
