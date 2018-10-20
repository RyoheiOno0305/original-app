class UsersController < ApplicationController
  before_action :require_user_logged_in, only:[:index, :show, :followings, :followers, :favorites ]
  before_action :correct_user, only:[:edit]
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザー登録が完了しました'
      redirect_to @user
    else
      flash.now[:danger] ='ユーザー登録に失敗しました'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = '自己紹介を編集しました'
      redirect_to @user
    else
      flash.now[:danger]= '編集に失敗しました'
      render :edit
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def favorites
    @user = User.find(params[:id])
    @favorites = @user.favs.page(params[:page])
    counts(@user)
  end
  
  def wants
    @user = User.find(params[:id])
    @wants = @user.want_items.page(params[:page])
    counts(@user)
  end
  
  def has
    @user = User.find(params[:id])
    @has = @user.have_items.page(params[:page])
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email, :password, :password_confirmation, :intro)
  end
end
