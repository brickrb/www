class PagesController < ApplicationController
  def home
    @package_count = Package.all.count
  end
end
