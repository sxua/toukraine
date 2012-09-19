class HomeController < ApplicationController
  def index
    @promotions = Promotion.published.for_locale(I18n.locale).all
  end
end
