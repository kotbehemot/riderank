class ApplicationPresenter < SimpleDelegator
  include ActionView::Helpers
  include Rails.application.routes.url_helpers

  def model
    __getobj__
  end

  protected
  def distance_decorator(distance)
    "#{(distance.to_f / 1000).round}km"
  end

  def price_decorator(price)
    number_to_currency(price.to_f / 100, unit: '€')
  end
end