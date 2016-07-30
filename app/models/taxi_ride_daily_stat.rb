class TaxiRideDailyStat < TaxiRide

  after_initialize :readonly!

  STATS_TO_DISPLAY = [
    'ride_date',
    'SUM(taxi_rides.distance_in_meters) as distance_in_meters',
    'AVG(taxi_rides.distance_in_meters) as avg_distance_in_meters',
    'AVG(taxi_rides.price_in_cents) as avg_price_in_cents',
    "string_agg(DISTINCT taxi_providers.name, ', ') as names"
  ]

  default_scope -> { select(STATS_TO_DISPLAY).group(:ride_date).joins(:taxi_provider) }

end
