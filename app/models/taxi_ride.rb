class TaxiRide < ApplicationRecord

  belongs_to :taxi_provider

  validates :origin, :destination, :price, :distance_in_meters, :taxi_provider_id, presence: true
  validates :price, :distance_in_meters, numericality: {greater_than: 0}

  before_validation :compute_distance!

  scope :from_current_month, -> { where(['ride_date BETWEEN ? AND ?', Date.today.beginning_of_month, Date.today.end_of_month]) }
  scope :from_current_week, -> { where(['ride_date BETWEEN ? AND ?', Date.today.beginning_of_week, Date.today.end_of_week]) }

  #virtual attributes
  def price
    return nil if price_in_cents.nil?
    (price_in_cents.to_f / 100)
  end

  def price=price
    self.price_in_cents = price.to_f * 100
  end

  protected
  def compute_distance!
    self.distance_in_meters = GoogleIntegrations::GmapsDistanceMatrix.get_distance(origin, destination) if self.distance_in_meters.blank?
  end
end
