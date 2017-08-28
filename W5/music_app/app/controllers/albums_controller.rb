class AlbumsController < ApplicationController

  def new
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      render band_url(album.band)
    else
      flash.now[:errors] = @album.errors.full_messages
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, :year, :live, :band_id)
  end

end
