class Api::V1::BookSearchController < ApplicationController
  def index
    books = BookSearchFacade.new(params[:location], params[:quantity]).books
    render json: BookSearchSerializer.new(books)
  end
end