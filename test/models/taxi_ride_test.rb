require 'test_helper'

class TaxiRideTest < ActiveSupport::TestCase
  test "should not save ride without calculated distance" do
    ride = TaxiRide.new
    assert_not ride.save
  end

  test "should save ride with the right params and calculated distance" do
    provider = TaxiProvider.first
    ride = TaxiRide.new(taxi_provider: provider, origin: 'Lublin', destination: 'Warszawa', price_in_cents: 14000, ride_date: Date.today - 2.days)
    assert ride.save
  end
end
