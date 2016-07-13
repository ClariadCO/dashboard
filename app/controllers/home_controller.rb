class HomeController < ApplicationController
  #layout "application"

  def index
    @featured = App.first
    @apps = App.all
  end
end
