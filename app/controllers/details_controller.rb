class DetailsController < ApplicationController
  require 'date'

  def show
    details = Tmdb::Movie.detail(params[:id])
    details.cast = Tmdb::Movie.cast(params[:id])
    details.reviews = Tmdb::Movie.reviews(params[:id]).results
    details.backdrops = Tmdb::Movie.backdrops(params[:id])
    release = details.release_date
    if release.nil? || release == ''
      details.release_date = 'TBD'
    else
      details.release_date = "#{Date::MONTHNAMES[release.slice(5..6).to_i]} #{release.slice(8..9)}, #{release.slice(0..3)}"
    end
    unless details.runtime.nil?
      details.runtime = time_conversion(details.runtime)
    end
    if details.backdrop_path != nil
      details.backdrop_path = details.backdrops[rand(0..(details.backdrops.length - 1))].file_path
    else
      details.backdrop_path = details.poster_path
    end
    @film = details
  end

  def time_conversion(minutes)
    hours = minutes / 60
    rest = minutes % 60
    return "#{hours}h #{rest}m"
  end
end
