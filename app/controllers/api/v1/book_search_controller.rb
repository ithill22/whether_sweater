class Api::V1::BookSearchController < ApplicationController
  def index
    book = BookFacade.new(params[:title]).book
    render json: BookSerializer.new(book)
  end
end