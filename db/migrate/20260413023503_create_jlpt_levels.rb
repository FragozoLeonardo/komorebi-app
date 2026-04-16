class CreateJlptLevels < ActiveRecord::Migration[8.1]
  def change
    create_table :jlpt_levels do |t|
      t.string :level_description, null: false
      t.integer :position, null: false

      t.timestamps

      t.index :level_description, unique: true
      t.index :position, unique: true
    end

    add_check_constraint :jlpt_levels, "position > 0", name: "position_check"
  end
end
