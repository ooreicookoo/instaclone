class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_with_http_digest, only: [:edit, :update, :destroy]

  def index
    @feeds = Feed.all.order(updated_at: :desc)
    if logged_in?
      @user = User.find(current_user.id)
    else
      @user = User.new
    end
  end

  def show
    @favorite = current_user.favorites.find_by(feed_id: @feed.id)
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

  def ensure_correct_user
    @feed = Feed.find_by(id:params[:id])
    if @feed.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/feeds")
    end
  end
end
