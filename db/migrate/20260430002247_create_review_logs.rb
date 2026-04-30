# frozen_string_literal: true

class CreateReviewLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :review_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reviewable, polymorphic: true, null: false
      t.integer :quality, null: false
      t.integer :interval, null: false
      t.float :ease_factor, null: false
      t.integer :response_time_ms
      t.timestamps
    end
    add_index :review_logs, [ :user_id, :created_at ]
  end
end
