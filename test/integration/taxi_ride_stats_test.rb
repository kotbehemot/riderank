require 'test_helper'

class TaxiRideStatsTest < ActionDispatch::IntegrationTest
  test "can see the main stats page" do
    get "/"
    assert_response :success
  end

  test "can add new ride" do
    post "/taxi_rides",
      params: { taxi_ride: { ride_date: Date.today - 1.days, origin: "Warszawa", destination: "Lublin", price: 100, taxi_provider_id: taxi_provider(:sawa).id } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
end