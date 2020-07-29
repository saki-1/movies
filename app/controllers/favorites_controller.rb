class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    movie = Movie.find(params[:movie_id])
    current_user.favorite(movie)
    flash[:success] = 'お気に入り登録しました'
    redirect_to root_url

  end

  def destroy
    movie = Movie.find(params[:movie_id])
    current_user.unfavorite(movie)
    flash[:success] = 'お気に入りを解除しました'
    redirect_to root_url
  end
end
