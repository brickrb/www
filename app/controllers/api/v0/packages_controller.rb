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

  def show
    @package = Package.find_by_name(params[:name])
    if @package
      render json: @package
    else
      render json: { "error": "Package could not be found." }, status: 404
    end
  end

  def update
    @package = Package.find_by_id(params[:id])
    if @package.update(package_params)
      render json: @package, status: 200
    else
      render json: { "error": "Package could not be updated." }, status: 422
    end
  end

  private
    def package_params
      params.require(:package).permit(:name)
    end
end
