require "csv"

namespace :db do
  desc "Import kanjis from TSV file"
  task import_kanjis: :environment do
    file_path = Rails.root.join("db", "data", "kanji.tsv")
    return puts "File not found" unless File.exist?(file_path)

    jlpt_levels = JlptLevel.pluck(:level_description, :id).to_h
    kanjis_to_import = []
    timestamp = Time.current

    CSV.foreach(file_path, col_sep: "\t", headers: true) do |row|
      level_id = jlpt_levels[row["Nível JLPT"]&.strip]
      next unless level_id

      kanjis_to_import << {
        kanji: row["Kanji"],
        meaning: row["Significado"],
        on_reading: row["Leitura(s) ON"],
        kun_reading: row["Leitura(s) KUN"],
        mnemonic: row["Mnemônica"],
        jlpt_level_id: level_id,
        created_at: timestamp,
        updated_at: timestamp
      }
    end

    if kanjis_to_import.any?
      Kanji.insert_all(kanjis_to_import, unique_by: :kanji)
      puts "Successfully imported #{kanjis_to_import.size} kanjis."
    end
  end
end
