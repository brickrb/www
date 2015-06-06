class Api::V0::VersionsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_filter :doorkeeper_authorize!
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

    def version_params
      params.require(:version).permit(:number, :shasum, :package_id, :tarball)
    end
end
