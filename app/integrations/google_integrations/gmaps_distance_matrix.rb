module GoogleIntegrations
  module GmapsDistanceMatrix
    require 'uri'
    require 'open-uri'

    GOOGLE_BASE_URL = 'https://maps.googleapis.com/maps/api/distancematrix/json'

    def self.get_distance(origin, destination)
      raise ArgumentError, "Invalid params" if origin.blank? or destination.blank?
      distance = 0
      params = URI.encode_www_form([["origins", origin], ["destinations", destination], ['key', Rails.application.secrets.google_maps_api_key]])
      google_query = "#{GOOGLE_BASE_URL}?#{params}"

      Rails.logger.debug "Querying Google Maps Distance Matrix:"
      Rails.logger.debug google_query

      response = ActiveSupport::JSON.decode(open(google_query).read)
      if response['status'] == 'OK' && !response['rows'].empty? && response['rows'].first['elements'].first['status'] == 'OK'
        distance = response['rows'].first['elements'].first['distance']['value']
      end

      Rails.logger.debug "Distance: #{distance}m"

      return distance
    rescue
      return 0
    end
  end
end