class TourTypesController < ApplicationController
  def show
    @object = @tour_type = TourType.find(params[:id])
    @tours = @tour_type.tours.for_locale(I18n.locale).includes(:city)
    redirect_to root_path if @tours.blank?
    if params[:column] && sort_columns_for(Tour).has_key?(:"#{params[:column]}")
      @tours = @tours.order("#{sort_columns_for(Tour)[:"#{params[:column]}"]} #{sanitize_dir(params[:dir])} NULLS LAST")
    end
    @tours = @tours.page(params[:page])
    @title = I18n.t('header.tour_type', type: @tour_type.title)
  end
end
