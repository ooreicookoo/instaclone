class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:index, :new, :edit, :update, :destroy]
  before_action :set_current_user

  def index
    @feeds = Feed.all.order(updated_at: :desc)
  end

  def show
  end

  def new
    if params[:back]
      @feed = current_user.feeds.build
    else
      @feed = Feed.new
    end
  end

  def confirm
    @feed = current_user.feeds.build(feed_params)
    if @feed.invalid?
      flash.now[:danger] = 'エラー！内容が未記入です'
      render :new
    end
  end

  def edit
  end

  def create
      @feed = current_user.feeds.build(feed_params)
      if params[:back]
        render :new
      else
        if @feed.save
        redirect_to feeds_path, notice: "投稿しました！"
      else
        render:new
      end
    end
  end

  def update
      if @feed.update(feed_params)
        redirect_to feeds_path, notice: "投稿内容を編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: '投稿を削除しました' }
      format.json { head :no_content }
    end
  end

  private
  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:image, :image_cache, :content)
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end


  def check_user
    unless logged_in?
      flash[:notice] = "ログインもしくはアカウントを作成してください"
      redirect_to new_session_url
    end
  end
end
