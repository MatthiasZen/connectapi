class PagesController < ApplicationController
  def index

  end

  def show
    domain_name = params["ndd"]

    time = Time.new()
    timestemp = time.to_i

    #calling the OVH REST gem

    ovh = OVH::REST.new(ENV["apiKey"], ENV["appSecret"], ENV["consumerKey"])

    # Get account status

    @resultat = ovh.get("/domain/#{domain_name}/serviceInfos")

  end
end


