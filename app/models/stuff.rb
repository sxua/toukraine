class Stuff < ActiveRecord::Base
  def self.articles(limit)
    stuff = []
    stuff += News.for_locale(I18n.locale).limit(5)
    stuff += Promotion.for_locale(I18n.locale)
    stuff.sort_by(&:created_at).reverse[0...limit]
  end
end
