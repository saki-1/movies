class MoviesController < ApplicationController
  before_action :set_movie, only:[:show, :edit, :update]
  before_action :require_user_logged_in, only:[:new, :create, :show]
  before_action :correct_user, only:[:destroy]
  
  def index
    @movies = Movie.all.page(params[:page]).per(3)
  end
  
  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user_id = current_user.id
    
    if @movie.save
      flash[:success] = '投稿できました'
      redirect_to root_url
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end
  
  def show
  end

  def edit
  end
  
  def update
    if @movie.update(movie_params)
      flash[:success] = '更新されました'
      redirect_to @movie
    else
      flash.now[:danger] = '更新できませんでした'
      render :edit
    end
  end
  
  def destroy
    @movie.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to root_url
  end
  
  private
  
  def set_movie
    @movie = Movie.find(params[:id])
  end
  
  def movie_params
    params.require(:movie).permit(:content, :rank, :title, :release_date, :image)
  end
  
  def correct_user
    @movie = current_user.movies.find_by(id: params[:id])
    unless @movie
      redirect_to root_url
    end
  end
end
