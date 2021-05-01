# frozen_string_literal: true
# This migration comes from decidim_surveys (originally 20180406201818)

class AddPositionToDecidimSurveyAnswerChoices < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_surveys_survey_answer_choices, :position, :integer
  end
end
