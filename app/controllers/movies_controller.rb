class MoviesController < ApplicationController
  before_action :require_user_logged_in, only:[:new, :create, :show]
  
  def index
    @movies = Movie.all
  end
  
  def new
    @movie = Movie.new
  end
  
  def show
    @movie = Movie.find(params[:id])
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
  
  private
  
  def movie_params
    params.require(:movie).permit(:content, :rank, :title, :release_date, :picture)
  end
end
