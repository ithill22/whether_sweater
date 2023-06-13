class Api::V1::BackgroundsController < ApplicationController
  def index
    background = BackgroundFacade.new(params[:location]).background
    render json: BackgroundSerializer.new(background)
  end
end