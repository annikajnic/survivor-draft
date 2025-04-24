# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
Contestant.destroy_all

# Create contestants for Season 48
contestants = [
  { name: "Ava", tribe: "Civa", status: "active" },
  { name: "Ben", tribe: "Civa", status: "active" },
  { name: "Bhanu", tribe: "Civa", status: "active" },
  { name: "Charlie", tribe: "Civa", status: "active" },
  { name: "David", tribe: "Civa", status: "active" },
  { name: "Hunter", tribe: "Civa", status: "active" },
  { name: "Jem", tribe: "Lagi", status: "active" },
  { name: "Kenzie", tribe: "Lagi", status: "active" },
  { name: "Liz", tribe: "Lagi", status: "active" },
  { name: "Maria", tribe: "Lagi", status: "active" },
  { name: "Moriah", tribe: "Lagi", status: "active"  },
  { name: "Randen", tribe: "Nami", status: "active" },
  { name: "Soda", tribe: "Nami", status: "active" },
  { name: "Tevin", tribe: "Nami", status: "active" },
  { name: "Tim", tribe: "Nami", status: "active" },
  { name: "Tiffany", tribe: "Nami", status: "active" },
  { name: "Venus", tribe: "Nami", status: "active" }
]

# Create contestants with season number 48
contestants.each do |contestant|
  Contestant.create!(contestant.merge(season_number: 48))
end

puts "Created #{Contestant.count} contestants for Season 48"
