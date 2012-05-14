require 'csv'
pages = []

CSV.foreach("#{Rails.root}/db/fixtures/csv/pages.csv", headers: [:title_ru, :title_en, :category]) do |row|
  row[:slug_ru] = row[:slug_en] = row[:title_en].parameterize
  row[:published_by_id] = 1
  row[:published_at] = Time.now
  row[:is_published] = true
  pages << row.to_hash
end

Page.seed_once(:title_ru, pages)
