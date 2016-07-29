class TaxiRidesController < ApplicationController

  respond_to :html

  def index
    get_rides
    @new_ride = TaxiRide.new :ride_date => Time.now
  end

  def create
    @new_ride = TaxiRide.new(permitted_params)
    @new_ride.distance_in_meters = GoogleIntegrations::GmapsDistanceMatrix.get_distance(@new_ride.origin, @new_ride.destination)
    if @new_ride.save
      flash[:notice] = "Your ride was registered successfully"
      redirect_to taxi_rides_path
    else
      get_rides
      flash.now[:error] = "Your ride couldn't be added. Check below for errors."
      render :index
    end
  end

  def destroy_all
    TaxiRide.delete_all
    flash[:notice] = "Data cleared"
    redirect_to taxi_rides_path
  end

  private

  def get_rides
    @all_rides = TaxiRide.order(:ride_date)
    @day_ride_stats = TaxiRideDailyStat.from_current_month.order(:ride_date).map {|stat| TaxiRideDailyStatsPresenter.new(stat)}

    @weekly_stats = TaxiRideWeeklyStat.from_current_week.take(1).first
    @weekly_stats_presenter = TaxiRideWeeklyStatsPresenter.new(@weekly_stats)


  end

  def permitted_params
    params.require(:taxi_ride).permit('ride_date(1i)', 'ride_date(2i)', 'ride_date(3i)', 'origin', 'destination', 'taxi_provider_id', 'price')
  end
end
