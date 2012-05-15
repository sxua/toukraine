require 'csv'
pages = []

lorem_ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc hendrerit ullamcorper imperdiet. Cras ac metus pellentesque erat pharetra commodo quis a lectus. Ut lobortis nibh ac nisl mollis condimentum sed in metus. Ut fermentum diam eget arcu venenatis eget luctus magna volutpat. Duis elementum blandit consectetur. Suspendisse interdum sem id dolor tempor molestie. Nulla aliquam pharetra justo in bibendum. Donec turpis mauris, volutpat in scelerisque vitae, placerat a sem. Duis suscipit, tellus ut suscipit tristique, lorem ipsum euismod tellus, at tincidunt mi enim et ligula. Mauris at nunc risus. Suspendisse at lorem magna. Nulla et ante lectus, sit amet euismod tellus. Nam egestas iaculis purus at scelerisque. Pellentesque egestas neque a velit gravida nec posuere tellus pellentesque.

Nunc rhoncus commodo nunc a lobortis. Vestibulum ultricies metus non dui iaculis sed rhoncus nisi ullamcorper. Nunc sapien velit, pharetra nec feugiat in, malesuada id nisl. Sed sed neque arcu, eget semper velit. Fusce aliquam interdum magna sit amet sodales. Cras urna nibh, interdum eget tristique quis, sodales ac mauris. Donec fringilla libero eget lacus fringilla ac lobortis diam consequat. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris egestas dignissim volutpat. Mauris a quam at nibh varius aliquet. Donec adipiscing aliquet eleifend. Donec sit amet sem sem. Fusce eu scelerisque leo.

Etiam odio arcu, fringilla a mollis non, molestie eget odio. Integer quis magna urna. Aenean sit amet nibh arcu. Pellentesque at lacinia risus. Aliquam sagittis, ipsum hendrerit tempus lobortis, tellus elit laoreet eros, vel pharetra arcu velit et ipsum. Cras dignissim lacus quis enim dignissim eu commodo tellus dictum. Vivamus aliquam nisi ut nisl sollicitudin vel tristique quam facilisis. Ut lorem velit, semper at bibendum in, sagittis eget ante. Nulla sem est, suscipit vitae condimentum et, tristique et mauris. Vestibulum ligula est, ultrices sed tristique quis, placerat ultrices risus. Morbi nec nisl nunc. Duis lobortis, libero at tempus auctor, velit turpis sodales sem, vel consequat sapien justo sit amet turpis. Nullam placerat, magna porta euismod molestie, diam massa ullamcorper diam, id congue justo tortor et nulla.

Pellentesque tincidunt lobortis volutpat. Donec id elit libero, eget hendrerit nulla. In pulvinar placerat odio, sed ultricies ipsum viverra sed. Quisque euismod nulla sed magna euismod rutrum. Mauris vitae urna ac felis malesuada elementum. Pellentesque aliquet eros eu mauris tincidunt tempus. Nunc euismod, mauris sit amet sollicitudin placerat, arcu diam tincidunt nulla, vitae convallis ipsum nibh lobortis urna. Phasellus tempus, urna eu hendrerit pulvinar, magna ligula ultrices tortor, in gravida lacus nisl id erat. Praesent id rutrum dolor.

Etiam a nisi est, eget elementum nulla. In condimentum vestibulum cursus. Curabitur a semper odio. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Phasellus fringilla, sem sed posuere lacinia, urna velit placerat ante, eget porta neque orci eget massa. Donec lectus risus, varius id elementum sit amet, gravida eget turpis. Praesent euismod magna faucibus nulla accumsan molestie. Sed consequat leo ut dolor posuere at pharetra augue vulputate. Integer felis sapien, congue id rutrum vitae, eleifend non sapien. Vivamus nisi felis, aliquam sit amet tincidunt vitae, fermentum id nulla. Nunc ligula ligula, iaculis non varius ac, placerat sed arcu. Nulla facilisi. Quisque consequat, elit ac sagittis condimentum, tellus libero blandit ligula, vel egestas dolor dolor sed nisl. Aliquam et quam risus, id pharetra lectus."

CSV.foreach("#{Rails.root}/db/fixtures/csv/pages.csv", headers: [:title_ru, :title_en, :category]) do |row|
  row[:slug_ru] = row[:slug_en] = row[:title_en].parameterize
  row[:published_by_id] = 1
  row[:published_at] = Time.now
  row[:is_published] = true
  row[:body_ru] = row[:body_en] = lorem_ipsum
  pages << row.to_hash
end

Page.seed_once(:title_ru, pages)
