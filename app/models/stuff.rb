class Stuff < ActiveRecord::Base
  def self.articles(limit = -1)
    stuff = []
    stuff += News.for_locale(I18n.locale).order("created_at DESC").limit(5)
    stuff += Promotion.for_locale(I18n.locale)
    stuff.sort_by(&:created_at).reverse[0...limit]
  end
end
