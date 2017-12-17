class PagesController < ApplicationController
  def home
    @campaigns = []
    @campaigns = current_user.last_campaigns if current_user
  end
end
