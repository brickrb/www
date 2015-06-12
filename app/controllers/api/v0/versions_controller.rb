class Api::V0::VersionsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_filter :doorkeeper_authorize!
  before_action :valid_ownership
  before_action :set_version
  respond_to :json

  def create
    @version = Version.new(version_params.merge(package_id: @package))
    if @version.save
      @package.purge
      @package.purge_all
      VersionTweeterJob.enqueue(@version.id)
      render json: {}, status: 201
    else
      render json: { "error": "Version could not be saved." }, status: 422
    end
  end

  def destroy
    if @version.destroy
      @package.purge
      @package.purge_all
      render json: {}, status: 204
    else
      render json: { "error": "Version could not be deleted." }, status: 422
    end
  end

  private

    def valid_ownership
      @package = current_user.packages.find_by(name: params[:name])
      render json: { "error": "Not authorized." }, status: 401 if @package.nil?
    end

    def set_version
      @version = Version.find_by(number: params[:number], package_id: @package)
    end

    def version_params
      params.require(:version).permit(:description, :number, :license, :package_id, :shasum, :tarball)
    end
end
