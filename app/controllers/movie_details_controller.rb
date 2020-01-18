class MovieDetailsController < ApplicationController
  require 'date'

  def show
    details = Tmdb::Movie.detail(params[:id])
    details.cast = Tmdb::Movie.cast(params[:id])
    release = details.release_date
    if release.nil? || release == ''
      details.release_date = 'TBD'
    else
      details.release_date = "#{Date::MONTHNAMES[release.slice(5..6).to_i]} #{release.slice(8..9)}, #{release.slice(0..3)}"
    end
    @film = details
  end
end
