class ReviewsController < ApplicationController
  before_action :require_signin
  before_action :set_movie

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to movie_reviews_path(@movie),
                  notice: "Thanks for your review!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @review = @movie.reviews.find_by(id: params[:id])

    if @review.present?
      @review.destroy
      redirect_to movie_review_path(@movie), status: :see_other,
                                             alert: "Reviews Succesfully Deleted!"
    else
      redirect_to movie_review_path(@movie), status: :see_other,
                                             alert: "Movie Review was not Found!"
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :stars)
  end

  def set_movie
    @movie = Movie.find_by!(slug: params[:movie_id])
  end
end
