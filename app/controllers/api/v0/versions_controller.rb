class Api::V0::VersionsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_filter :doorkeeper_authorize!
  before_action :valid_ownership
  respond_to :json

  def create
    @version = Version.new(version_params)
    if @version.save
      render json: {}, status: 201
    else
      render json: { "error": "Version could not be saved." }, status: 422
    end
  end

  private

    def valid_ownership
      @package = current_user.packages.find_by(id: version_params[:package_id])
      render json: { "error": "Not authorized." }, status: 401 if @package.nil?
    end

    def version_params
      params.require(:version).permit(:description, :number, :license, :shasum, :package_id, :tarball)
    end
end
