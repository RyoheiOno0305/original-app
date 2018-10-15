class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @post = Post.find(params[:post_id])
    @post.fav(current_user)
    flash[:success] = 'お気に入りしました'
    redirect_to current_user
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post.unfav(current_user)
    flash[:success] = 'お気に入りを解除しました'
    redirect_to current_user
  end
  
end
