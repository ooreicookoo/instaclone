class UsersController < ApplicationController
  def new
    if logged_in?
      @Feeds = Feed.all
      render 'feeds/'
    else
      @user = User.new
      render 'new'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'プロフィールを編集しました。'
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = 'プロフィールの編集に失敗しました。'
      render :edit
    end
  end

  def destroy
     session.delete(:user_id)
     flash[:notice] = 'ログアウトしました'
     redirect_to new_session_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :content, :image_name, :password, :password_confirmation)
  end

  def check_user
    unless logged_in?
      flash[:notice] = "ログインもしくはアカウントを作成してください"
      redirect_to new_session_url
    end
  end
end
