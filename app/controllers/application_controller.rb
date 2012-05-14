class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def default_url_options(options={})
    { locale: I18n.locale }
  end
  
  def not_found
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end
end
