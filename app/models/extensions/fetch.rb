module Extensions
  module Fetch
    def fetch_list(city_id)
      city_id ||= City.first
      self.select("id, title_#{I18n.locale}").where(city_id: city_id)
    end

    def fetch_cities
      self.select('DISTINCT(city_id)').where('city_id IS NOT NULL').includes(:city).map(&:city).sort_by(&:title_ru)
    end
  end
end