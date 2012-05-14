require 'csv'
cities = []

CSV.foreach("#{Rails.root}/db/fixtures/csv/cities.csv", headers: [:id, :title_ru, :title_en, :region_id]) do |row|
  row[:slug_ru] = row[:slug_en] = row[:title_en].parameterize
  cities << row.to_hash
end

City.seed_once(:title_ru, cities)
