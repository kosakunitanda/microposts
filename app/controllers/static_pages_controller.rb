class StaticPagesController < ApplicationController
  def home
#    @micropost = current_user.microposts.build if logged_in?
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
    end
  end
  def about

  end
  
  
  
end
