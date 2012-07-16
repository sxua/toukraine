class RedirectController < ApplicationController
  def switch_locale
    cookies[:locale] = { value: I18n.locale, expires: 1.year.from_now }
    if params[:return_path]
      redirect_to params[:return_path], status: 301
    else
      redirect_to :back
    end
  end
end
