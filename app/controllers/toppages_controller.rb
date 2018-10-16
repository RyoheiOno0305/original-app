class ToppagesController < ApplicationController
  def index
    @posts = Post.all.order('created_at DESC').page(params[:page])
    @followers_ranking = Relationship.ranking
    @users = User.find(@followers_ranking.keys)
    
  end
end
