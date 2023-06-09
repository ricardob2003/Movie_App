class MoviesController < ApplicationController

  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  def index
    case params[:filter]
    when "upcoming"
      @movies = Movie.upcoming
    when "recent"
      @movies = Movie.recent
    else
      @movies = Movie.released
    end
  end

  def show
    @genres = @movie.genres.order(:name)
    if current_user
      @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    end
    @fans = @movie.fans
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie Succesfully Updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie Succesfully Created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

    #Ask how this redirect works with movies_url
  def destroy
    @movie.destroy
    redirect_to movies_url, status: :see_other,
      alert: "Movie Succesfully Deleted!"
  end

private
    def movie_params
      params.require(:movie).
      permit(:title, :description, :rating, :released_on, :total_gross,
      :director, :duration, :main_image, genre_ids: [])
    end
    def set_movie
      @movie = Movie.find_by!(slug: params[:id])
    end
end
