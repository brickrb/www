class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :update, :destroy]
  respond_to :html

  def show
  end

  private
    def set_package
      @package = Package.find_by_name(params[:name])
    end

    def package_params
      params.require(:package).permit(:name, :license)
    end
end
