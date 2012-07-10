class RegionsController < ApplicationController
  def show
    @region = Region.find(params[:id])
    @tours = @region.tours
    if params[:column] && sort_columns_for(Tour).has_key?(:"#{params[:column]}")
      @tours = @tours.order("#{sort_columns_for(Tour)[:"#{params[:column]}"]} #{sanitize_dir(params[:dir])} NULLS LAST")
    end
    @tours = @tours.page(params[:page])
    @title = @region.title
  end

  def hotels
    @region = Region.find(params[:id])
    @hotels = @region.hotels
    if params[:column] && sort_columns_for(Hotel).has_key?(:"#{params[:column]}")
      @hotels = @hotels.order("#{sort_columns_for(Hotel)[:"#{params[:column]}"]} #{sanitize_dir(params[:dir])} NULLS LAST")
    end
    @hotels = @hotels.page(params[:page])
    @title = @region.title
  end
end
