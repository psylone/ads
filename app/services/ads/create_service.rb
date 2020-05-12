module Ads
  class CreateService
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
    end

    option :user

    attr_reader :ad

    def call
      @ad = @user.ads.new(@ad.to_h)
      return fail!(@ad.errors) unless @ad.save

      GeocodingJob.perform_later(@ad)
    end
  end
end
