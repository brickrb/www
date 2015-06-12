class Api::V0::PackagesController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_filter :doorkeeper_authorize!
  before_action :set_cache_control_headers, only: [:index, :show]
  before_action :set_package, only: [:show, :update, :destroy]
  before_action :valid_ownership, only: [:update, :destroy]
  respond_to :json

  def index
    @packages = Package.all
    set_surrogate_key_header Package.table_key, @packages.map(&:record_key)
  end

  def create
    @package = Package.new(package_params)
    @ownership = Ownership.new(package_id: @package.id, user_id: current_user.id)
    if @package.save
      @package.purge_all
      render :show, location: @package , status: 201
    else
      render json: { "error": "Package could not be saved." }, status: 422
    end
  end

  def show
    if @package
      set_surrogate_key_header @package.record_key
    else
      render json: { "error": "Package could not be found." }, status: 404
    end
  end

  def update
    if @package.update(package_params)
      @package.purge
      render :show, location: @package , status: 200
    else
      render json: { "error": "Package could not be updated." }, status: 422
    end
  end

  def destroy
    @ownerships = Ownership.find_by(package_id: @package.id)
    @ownerships.destroy

    if @package.destroy
      @package.purge
      @package.purge_all
      render json: {}, status: 204
    else
      render json: { "error": "Package could not be deleted." }, status: 422
    end
  end

  private
    def set_package
      @package = Package.find_by(params[:name])
    end

    def valid_ownership
      @package = current_user.packages.find_by(params[:name])
      render json: { "error": "Not authorized." }, status: 401 if @package.nil?
    end

    def package_params
      params.require(:package).permit(:name, :latest_version)
    end
end
