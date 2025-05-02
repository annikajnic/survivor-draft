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

# users = [
#   { name: "Annika Nicol", email: "annikajnicol@gmail.com", password: "password", role: "admin" },
#   { name: "Jane Doe", email: "jane@example.com", password: "password", role: "player" }
# ]

# users.each do |user|
#   User.create!(user)
# end

if User.find_by(email: "annikajnicol@gmail.com").nil?
  User.create!(name: "Annika Nicol", email: "annikajnicol@gmail.com", password: "password", role: "admin")
end

# draft = Draft.create!(name: "Draft Season 48", season_number: 48, airing_datetime: Time.parse("2025-02-26T20:00:00-05:00"), draft_owner: User.find_by(email: "annikajnicol@gmail.com"), episodes_count: 13)
# draft.add_owner_as_player
# draft = Draft.find_by(name: "Draft Season 48")
# draft_players = draft.draft_players

# draft.create_episodes

# Create Votes for past episodes
# Create votes for episode 1
Vote.create(user: User.find_by(email: "jane@example.com"), episode: Episode.find_by(number: 1), contestant: Contestant.find_by(name: "Ava"))

# Create votes for episode 2
Vote.create(user: User.find_by(email: "jane@example.com"), episode: Episode.find_by(number: 2), contestant: Contestant.find_by(name: "Kenzie"))


puts "Created #{Contestant.count} contestants for Season 48"
puts "Created #{User.count} users"
puts "Created #{Episode.count} episodes"
puts "Created #{Vote.count} votes"
