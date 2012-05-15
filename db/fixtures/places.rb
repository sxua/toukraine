require 'csv'
places = []

lorem_ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc hendrerit ullamcorper imperdiet. Cras ac metus pellentesque erat pharetra commodo quis a lectus. Ut lobortis nibh ac nisl mollis condimentum sed in metus. Ut fermentum diam eget arcu venenatis eget luctus magna volutpat. Duis elementum blandit consectetur. Suspendisse interdum sem id dolor tempor molestie. Nulla aliquam pharetra justo in bibendum. Donec turpis mauris, volutpat in scelerisque vitae, placerat a sem. Duis suscipit, tellus ut suscipit tristique, lorem ipsum euismod tellus, at tincidunt mi enim et ligula. Mauris at nunc risus. Suspendisse at lorem magna. Nulla et ante lectus, sit amet euismod tellus. Nam egestas iaculis purus at scelerisque. Pellentesque egestas neque a velit gravida nec posuere tellus pellentesque.

Nunc rhoncus commodo nunc a lobortis. Vestibulum ultricies metus non dui iaculis sed rhoncus nisi ullamcorper. Nunc sapien velit, pharetra nec feugiat in, malesuada id nisl. Sed sed neque arcu, eget semper velit. Fusce aliquam interdum magna sit amet sodales. Cras urna nibh, interdum eget tristique quis, sodales ac mauris. Donec fringilla libero eget lacus fringilla ac lobortis diam consequat. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris egestas dignissim volutpat. Mauris a quam at nibh varius aliquet. Donec adipiscing aliquet eleifend. Donec sit amet sem sem. Fusce eu scelerisque leo.

Etiam odio arcu, fringilla a mollis non, molestie eget odio. Integer quis magna urna. Aenean sit amet nibh arcu. Pellentesque at lacinia risus. Aliquam sagittis, ipsum hendrerit tempus lobortis, tellus elit laoreet eros, vel pharetra arcu velit et ipsum. Cras dignissim lacus quis enim dignissim eu commodo tellus dictum. Vivamus aliquam nisi ut nisl sollicitudin vel tristique quam facilisis. Ut lorem velit, semper at bibendum in, sagittis eget ante. Nulla sem est, suscipit vitae condimentum et, tristique et mauris. Vestibulum ligula est, ultrices sed tristique quis, placerat ultrices risus. Morbi nec nisl nunc. Duis lobortis, libero at tempus auctor, velit turpis sodales sem, vel consequat sapien justo sit amet turpis. Nullam placerat, magna porta euismod molestie, diam massa ullamcorper diam, id congue justo tortor et nulla."


CSV.foreach("#{Rails.root}/db/fixtures/csv/places.csv", headers: [:id, :title_ru, :title_en, :place_type_id, :city_id]) do |row|
  row[:slug_ru] = row[:slug_en] = row[:title_en].parameterize
  row[:description_ru] = row[:description_en] = lorem_ipsum
  places << row.to_hash
end

Place.seed_once(:title_ru, places)