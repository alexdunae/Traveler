class TripsController < ApplicationController
  before_action :lookup_user, except: [:edit, :update, :destroy]
  before_action :lookup_trip, only: [:show, :edit, :update, :destroy, :delete]
  before_action :lookup_trips, only: [:index, :create, :update]

  def index
  end

  def show
  end

  def new
    @trip = @_user.trips.new
  end

  def create
    @trip = @_user.trips.new(trip_params)

    respond_to do |format|
      if @trip.save
        format.js { }
        format.html { redirect_to root_url, notice: 'Trip added!' }
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
      if @trip.update_attributes(trip_params)
        format.js { }
        format.html { redirect_to root_url, notice: 'Trip edited!' }
      else
        format.js { }
        format.html { render 'edit' }
      end
    end
  end

  def delete
  end
  
  def destroy
    @trip.destroy

    respond_to do |format|
      format.js { }
      format.html { redirect_to root_url, notice: 'Trip removed!'}
    end
  end

  private

  def lookup_user
    @_user = User.find(params[:user_id])
  end

  def lookup_trip
    @trip = Trip.find(params[:id])
  end

  def lookup_trips
    @trips = @_user.trips.all
  end

  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, :description)
  end
end