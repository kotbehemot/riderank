class TaxiRideDailyStatsPresenter < ApplicationPresenter

  def initialize(stats)
    @stats = stats
  end

  def day
    @stats.ride_date.to_s(:short)
  end

  def total_distance
    "#{(@stats.total_distance.to_f / 1000).round}km"
  end

  def avg_distance
    "#{(@stats.avg_distance.to_f / 1000).round}km"
  end

  def avg_price
    number_to_currency(@stats.avg_price.to_f / 100, unit: '€')
  end

  def names
    @stats.names
  end
end