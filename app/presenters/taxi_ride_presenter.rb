class TaxiRidePresenter < ApplicationPresenter

  def ride_date
    model.ride_date.to_s(:short)
  end

  def distance
    distance_decorator model.distance_in_meters
  end

  def avg_distance
    distance_decorator model.avg_distance_in_meters
  end

  def avg_price
    price_decorator model.avg_price_in_cents
  end

  def total_price
    price_decorator model.total_price_in_cents
  end

  def price
    price_decorator model.price_in_cents
  end
end