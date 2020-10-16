class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.build(feed_id: params[:feed_id])
    favorite.save
    redirect_to feeds_path
  end

  def destroy
    favorite = Favorite.find_by(feed_id: params[:feed_id], user_id: current_user.id)
    favorite.destroy
    redirect_to feeds_path
  end
end
