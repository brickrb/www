class Api::V0::VersionsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_filter :doorkeeper_authorize!
  respond_to :json

  def create
  end

  private

    def version_params
      params.require(:version).permit(:number, :shasum, :package_id, :tarball)
    end
end
