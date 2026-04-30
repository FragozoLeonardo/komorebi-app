# frozen_string_literal: true

class CreateReviewCards < ActiveRecord::Migration[8.1]
  def change
    create_table :review_cards do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reviewable, polymorphic: true, null: false

      t.float :ease_factor, null: false, default: 2.5
      t.integer :interval, null: false, default: 0
      t.integer :repetitions, null: false, default: 0
      t.datetime :next_review, null: false, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end

    add_index :review_cards, [ :user_id, :next_review ]
  end
end
