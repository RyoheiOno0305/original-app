class PostsController < ApplicationController
	before_action :require_user_logged_in , only:[:new, :create, :destroy]
	before_action :correct_user, only:[:destroy]
	
	def index
		@posts = Post.all.order('created_at DESC').page(params[:page])
	end
	
	def show
		@post = Post.find(params[:id])
	end
	
	def new
		@post = current_user.posts.build
	end
	
	def create
		@post = current_user.posts.build(post_params)
    
		if @post.save
			flash[:success] = '投稿しました'
			redirect_to root_url
		else
			@post.destroy
			flash.now[:danger] = '投稿に失敗しました'
			render 'new'
		end
	end
	
	def destroy
		@post.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
	end
	
	private
	
	def post_params
		params.require(:post).permit(:picture, :title, :content)
	end
	
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
