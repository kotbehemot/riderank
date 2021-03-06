class TaxiRidesController < ApplicationController

  def index
    get_ride_stats
    @new_ride = TaxiRide.new :ride_date => Time.now
  end

  def create
    @new_ride = TaxiRide.new(permitted_params)
    if @new_ride.save
      flash[:notice] = "Your ride was registered successfully"
      redirect_to root_path
    else
      get_ride_stats
      flash.now[:error] = "Your ride couldn't be added. Check below for errors."
      render :index
    end
  end

  def destroy
    @taxi_ride = TaxiRide.find(params[:id])
    @taxi_ride.destroy
    redirect_to root_path
  end

  def destroy_all
    TaxiRide.delete_all
    flash[:notice] = "Data cleared"
    redirect_to root_path
  end

  private

  def get_ride_stats
    @all_rides      = TaxiRide.order(:ride_date).limit(50)
    @daily_stats = TaxiRideDailyStat.from_current_month.order(:ride_date)
    @weekly_stats   = TaxiRideWeeklyStat.from_current_week.take(1).first
  end

  def permitted_params
    params.require(:taxi_ride).permit('ride_date(1i)', 'ride_date(2i)', 'ride_date(3i)', 'origin', 'destination', 'taxi_provider_id', 'price')
  end
end
