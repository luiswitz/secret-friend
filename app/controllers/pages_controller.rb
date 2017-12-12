class PagesController < ApplicationController
  def home
    @campaigns = []
    if current_user
      @campaigns = current_user.last_campaigns
    end
  end
end
