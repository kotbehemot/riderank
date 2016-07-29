class TaxiRideWeeklyStat < TaxiRide

  after_initialize :readonly!

  STATS_TO_DISPLAY = [
    'SUM(taxi_rides.distance_in_meters) as total_distance',
    'SUM(taxi_rides.price_in_cents) as total_price'
  ]

  default_scope -> { select(STATS_TO_DISPLAY) }

end
