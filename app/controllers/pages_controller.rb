class PagesController < ApplicationController
  def index
    time = Time.new()
    timestemp = time.to_i

    #calling the OVH gem
    ovh = OVH::REST.new(apiKey, appSecret, consumerKey)

  end
end

