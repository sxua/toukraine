class TourTypesController < ApplicationController
  def show
    @tour_type = TourType.find(params[:id])
    @tours = @tour_type.tours
    if params[:column] && sort_columns_for(Tour).has_key?(:"#{params[:column]}")
      @tours = @tours.order("#{sort_columns_for(Tour)[:"#{params[:column]}"]} #{sanitize_dir(params[:dir])} NULLS LAST")
    end
    @tours = @tours.page(params[:page])
  end
end
