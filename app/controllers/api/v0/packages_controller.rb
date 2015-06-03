class Api::V0::PackagesController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_filter :doorkeeper_authorize!
  before_action :set_package, only: [:show, :update, :destroy]
  before_action :valid_ownership, only: [:update, :destroy]
  respond_to :json

  def index
    @packages = Package.all
    render json: @packages
  end

  def create
    @package = Package.new(package_params)
    @ownership = Ownership.new(package_id: @package.id, user_id: current_user.id)
    if @package.save
      render json: @package, status: 201
    else
      render json: { "error": "Package could not be saved." }, status: 422
    end
  end

  def show
    if @package
      render json: @package
    else
      render json: { "error": "Package could not be found." }, status: 404
    end
  end

  def update
    if @package.update(package_params)
      render json: @package, status: 200
    else
      render json: { "error": "Package could not be updated." }, status: 422
    end
  end

  def destroy
    @ownerships = Ownership.find_by(package_id: @package.id)
    @ownerships.destroy

    if @package.destroy
      render json: {}, status: 204
    else
      render json: { "error": "Package could not be deleted." }, status: 422
    end
  end

  private
    def set_package
      @package = Package.find_by_id(params[:id])
    end

    def valid_ownership
      @package = current_user.packages.find_by(id: params[:id])
      render json: { "error": "Not authorized." }, status: 401 if @package.nil?
    end

    def package_params
      params.require(:package).permit(:name, :license)
    end
end
