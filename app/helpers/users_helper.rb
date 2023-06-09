module UsersHelper
  def profile_image(user, size = 80)
    url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}?s=#{size}"
    image_tag(url, alt: user.name)
  end

  def render_movie_image(movie)
    image_tag(movie.image_file_name, size: "150x150")
  end
end
