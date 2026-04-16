# db/seeds.rb

puts "--- Populating JLPT Levels ---"

# Data in Portuguese as requested, maintaining professional naming
levels = [
  { level_description: "N5",       position: 1 },
  { level_description: "N4",       position: 2 },
  { level_description: "N3",       position: 3 },
  { level_description: "N2",       position: 4 },
  { level_description: "N1",       position: 5 },
  { level_description: "Trabalho", position: 6 }
]

levels.each do |attrs|
  # Using find_or_initialize_by to ensure idempotency (Kodawari style)
  level = JlptLevel.find_or_initialize_by(level_description: attrs[:level_description])
  level.position = attrs[:position]

  if level.save
    puts "✅ [Level] #{level.level_description} (Position: #{level.position})"
  else
    puts "❌ Error creating #{attrs[:level_description]}: #{level.errors.full_messages.join(', ')}"
  end
end

puts "--- Seed finished successfully ---"
