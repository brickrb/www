class Api::V0::VersionsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_filter :doorkeeper_authorize!
  before_action :valid_ownership
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

  private

    def valid_ownership
      @package = current_user.packages.find_by(name: params[:name])
      render json: { "error": "Not authorized." }, status: 401 if @package.nil?
    end

    def version_params
      params.require(:version).permit(:description, :number, :license, :package_id, :shasum, :tarball)
    end
end
