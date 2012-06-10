class RegionsController < ApplicationController
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
