class Stuff < ActiveRecord::Base
  def self.shit
    stuff = []
    stuff += News.for_locale(I18n.locale).limit(5)
    stuff += Promotion.for_locale(I18n.locale)
    stuff.sort_by(&:created_at).reverse
  end
end
