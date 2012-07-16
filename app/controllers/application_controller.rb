class ApplicationController < ActionController::Base
  before_filter :set_locale
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  # rescue_from ArgumentError, with: :not_found

  def set_locale
    I18n.locale = params[:locale] || cookies[:locale] || get_user_preferred_locale || I18n.default_locale
    cookies[:locale] = I18n.locale
  end

  def get_user_preferred_locale
    language = request.compatible_language_from(%w(ru en)) || 'ru'
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  def change_locale_path locale
    return_path = if params[:controller] && params[:action]
      url_for params.merge({ locale: locale, only_path: true })
    else
      "/"
    end
    switch_locale_path(locale: locale, return_path: return_path)
  end

  helper_method :change_locale_path

  def not_found
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end

  def sort_columns_for(model)
    { title: "#{model.table_name}.title_#{I18n.locale}", city: "cities.title_#{I18n.locale}", price: "#{model.table_name}.price" }
  end

  def sanitize_dir(dir)
    dir.downcase == 'desc' ? 'DESC' : 'ASC'
  end
end
