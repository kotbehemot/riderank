class TaxiRideWeeklyStatsPresenter < ApplicationPresenter

  def initialize(stats)
    @stats = stats
  end

  def distance
    "#{(@stats.total_distance.to_f / 1000).round}km"
  end

  def price
    number_to_currency(@stats.total_price.to_f / 100, unit: '€')
  end
end