# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

20.times do
  short_link = ShortLink.create(
    original_url: "http://example.com/#{SecureRandom.hex}",
    short_url: SecureRandom.uuid[0..5],
    password: SecureRandom.hex(10),
    link_opened: rand(10),
    link_opened_last_time_at: rand(1..2).months.ago,
    created_at: rand(1..2).months.ago,
    updated_at: rand(1..2).months.ago
  )
  short_link.save!
end
