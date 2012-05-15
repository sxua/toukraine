promotions = []
files = []

(1..11).each do |i|
  files << File.open("#{Rails.root}/db/fixtures/images/sldr#{i}.jpg")
  promotions << {
    id: i,
    title_ru: "Тестовый слайдер №#{i}",
    title_en: "Test slider ##{i}",
    caption_ru: "Тестовая подпись под заголовком №#{i}",
    caption_en: "Test label under the title ##{i}",
    place_id: i
  }
end

Promotion.seed_once(:id, promotions)

files.each_with_index do |f, i|
  p = Promotion.find(i+1)
  p.image = f
  p.save!
end
