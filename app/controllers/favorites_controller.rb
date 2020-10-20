class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.build(feed_id: params[:feed_id])
    redirect_to feeds_path, notice: "#{favorite.feed.user.name}さんの投稿に♡しました"
  end

  def destroy
    favorite = current_user.favorite.find_by(id: params[:id]).destroy
    redirect_to feeds_path, notice: "#{favorite.feed.user.name}さんの投稿のいいね！を取り消しました"
  end
end
