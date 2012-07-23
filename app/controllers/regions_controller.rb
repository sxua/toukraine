class RegionsController < ApplicationController
  def show
    @object = @region = Region.find(params[:id])
    @tours = @region.tours
    redirect_to root_path if @tours.blank?
    if params[:column] && sort_columns_for(Tour).has_key?(:"#{params[:column]}")
      @tours = @tours.order("#{sort_columns_for(Tour)[:"#{params[:column]}"]} #{sanitize_dir(params[:dir])} NULLS LAST")
    end
    @tours = @tours.page(params[:page])
    @title = @region.title
  end

  def hotels
    @object = @region = Region.find(params[:id])
    @hotels = @region.hotels
    redirect_to root_path if @hotels.blank?
    if params[:column] && sort_columns_for(Hotel).has_key?(:"#{params[:column]}")
      @hotels = @hotels.order("#{sort_columns_for(Hotel)[:"#{params[:column]}"]} #{sanitize_dir(params[:dir])} NULLS LAST")
    end
    @hotels = @hotels.page(params[:page])
    @title = @region.title
  end
end
