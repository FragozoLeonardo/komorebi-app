# frozen_string_literal: true

class StudyController < ApplicationController
    def n5
      @level = JlptLevel.find_by!(level_description: "N5")
      @kanjis = @level.kanjis.order(:id)
    end
end
