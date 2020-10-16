class UsersController < ApplicationController
before_action :ensure_correct_user, only:[:show, :edit, :update]
before_action :set_user, only: [:show, :edit, :update]

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
      redirect_to user_path(@user.id), notice: "ユーザー登録しました！"
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
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'プロフィールを編集しました!'
    else
      render :edit, notice: 'プロフィールの編集に失敗しました。'
    end
  end

  def destroy
     session.delete(:user_id)
     flash[:notice] = 'ログアウトしました'
     redirect_to new_session_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :content, :icon, :password, :password_confirmation)
  end

  def ensure_correct_user
    unless logged_in?
      flash[:notice] = "ログインもしくはアカウントを作成してください"
      redirect_to new_session_url
    end
  end
end
