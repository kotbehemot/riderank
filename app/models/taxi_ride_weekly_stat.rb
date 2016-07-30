class TaxiRideWeeklyStat < TaxiRide

  after_initialize :readonly!

  STATS_TO_DISPLAY = [
    'SUM(taxi_rides.distance_in_meters) as distance_in_meters',
    'SUM(taxi_rides.price_in_cents) as total_price_in_cents'
  ]

  default_scope -> { select(STATS_TO_DISPLAY) }

end
