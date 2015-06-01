class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
    @packages = User.find_by_username(params[:username]).packages.all
  end
end
