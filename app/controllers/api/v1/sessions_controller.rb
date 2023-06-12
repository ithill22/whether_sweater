class Api::V1::SessionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def create
    user = User.find_by!(email: params[:email])
    raise ActiveRecord::RecordNotFound unless user.authenticate(params[:password])
    render json: UserSerializer.new(user), status: :ok
  end

  private

  def render_not_found
    render json: { errors: { detail: 'Email or password not found' } }, status: :unauthorized
  end
end