require 'csv'
places = []

CSV.foreach("#{Rails.root}/db/fixtures/csv/places.csv", headers: [:id, :title_ru, :title_en, :place_type_id, :city_id]) do |row|
  row[:slug_ru] = row[:slug_en] = row[:title_en].parameterize
  places << row.to_hash
end

Place.seed_once(:title_ru, places)