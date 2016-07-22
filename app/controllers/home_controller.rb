class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_filter :set_apps, except: [:store_off]

  def index; end
  def store_off; end

  private
  
  def set_apps
    @apps = []
    @featured = nil
    if @browser.platform.ios?
      @featured = (App.ios.featured.count > 0) ? App.ios.featured.first : nil
      @apps = App.ios.not_featured.all
    end
    if @browser.platform.android?
      @featured = (App.android.featured.count > 0) ? App.android.featured.first : nil
      @apps = App.android.not_featured.all
    end
    
    @apps = App.all if current_user.role.name == "admin"
    
    if @apps.count == 0
      redirect_to :store_off and return
    end
  end
end
