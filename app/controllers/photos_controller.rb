class PhotosController < ApplicationController
  before_action :lookup_trip, except: [:edit, :update, :destroy]
  before_action :lookup_photo, only: [:show, :edit, :update, :destroy, :delete]
  before_action :lookup_photos, only: [:index, :create, :update]

  def index
  end

  def show
  end

  def new
    @photo = @trip.photos.new
  end

  def create
    @photo = @trip.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.js { }
        format.html { redirect_to user_trip_path(@trip.user, @trip), notice: 'Photo added!' }
      else
        format.js { }
        format.html { render 'new' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @photo.update_attributes(photo_params)
        format.js { }
        format.html { redirect_to user_trip_path(@trip.user, @trip), notice: 'Photo edited!' }
      else
        format.js { }
        format.html { render 'edit' }
      end
    end
  end

  def delete
  end
  
  def destroy
    @photo.destroy

    respond_to do |format|
      format.js { }
      format.html { redirect_to user_trip_path(@trip.user, @trip), notice: 'Photo removed!'}
    end
  end

  private

  def lookup_trip
    @trip = Trip.find(params[:trip_id])
  end

  def lookup_photo
    @photo = Photo.find(params[:id])
  end

  def lookup_photos
    @photos = @trip.photos.all
  end

  def photo_params
    params.require(:photo).permit(:name, :latitude, :longitude, :taken_date, :description, :image)
  end
end