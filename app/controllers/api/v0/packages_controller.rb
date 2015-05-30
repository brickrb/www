class Api::V0::PackagesController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  respond_to :json

  def index
    @packages = Package.all
    render json: @packages
  end

  def create
    @package = Package.new(package_params)
    if @package.save
      render json: @package, status: 201
    else
      render json: { "error": "Package could not be saved." }, status: 422
    end
  end

  private
    def package_params
      params.require(:package).permit(:name)
    end
end
