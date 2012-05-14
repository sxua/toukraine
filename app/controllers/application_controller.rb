class ApplicationController < ActionController::Base
  before_filter :set_locale
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  def set_locale
    I18n.locale = I18n.locale = params[:locale] || cookies[:locale] || get_user_preferred_locale || I18n.default_locale
  end

  def get_user_preferred_locale
    language = request.compatible_language_from(%w(ru en)) || 'ru'
  end
  
  def default_url_options(options={})
    { locale: I18n.locale }
  end
  
  def not_found
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end
end
