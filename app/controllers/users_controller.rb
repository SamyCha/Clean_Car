class UsersController < ApplicationController

  def index
    @title = "Index - My Clean Car"

    if params["address"] != ""
      @address = params["address"]
    else
      @address = "Le Wagon Bordeaux"
    end
    @users = User.all
    @cleaners = User.where(cleaner: true).near(@address, 20).first(5)
    @ratings = []

    @hash = Gmaps4rails.build_markers(@cleaners) do |cleaner, marker|
      marker.lat cleaner.latitude
      marker.lng cleaner.longitude
      marker.picture({ url: "https://image.prntscr.com/image/WtApDFKyS9SqShLkO0YrEw.png", width: 32, height: 32 })
    end
  end
end
