class CreateKanjis < ActiveRecord::Migration[8.1]
  def change
    create_table :kanjis do |t|
      t.string :kanji, null: false
      t.string :meaning, null: false
      t.string :on_reading
      t.string :kun_reading
      t.text :mnemonic

      t.references :jlpt_level, null: false, foreign_key: true

      t.timestamps

      t.index :kanji, unique: true
    end
  end
end
