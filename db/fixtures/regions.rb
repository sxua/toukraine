require 'csv'
regions = []

CSV.foreach("#{Rails.root}/db/fixtures/csv/regions.csv", headers: [:id, :title_ru, :title_en, :parent_id]) do |row|
  row[:slug_ru] = row[:slug_en] = row[:title_en].parameterize
  regions << row.to_hash
end

Region.seed_once(:title_ru, regions)