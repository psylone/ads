class Ads::GeocodingJob < ApplicationJob
  queue_as :default

  def perform(ad)
    coordinates = Geocoder.geocode(ad.city)
    return if coordinates.blank?

    ad.lat, ad.lon = coordinates
    ad.save!
  end
end
