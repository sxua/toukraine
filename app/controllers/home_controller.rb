class HomeController < ApplicationController
  def index
    @promotions = Promotion.random(5).all
  end
end
