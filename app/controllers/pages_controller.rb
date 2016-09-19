class PagesController < ApplicationController
  def index

  end

  def show
    domain_name = params["ndd"]
    if domain_name == /[a-zA-Z]+[.]+(com|fr|be)/


    redirect_to_root

    else
        time = Time.new()
        timestemp = time.to_i

        #calling the OVH REST gem

        ovh = OVH::REST.new(ENV["apiKey"], ENV["appSecret"], ENV["consumerKey"])

        # Get account status

        @resultat = ovh.get("/domain/#{domain_name}/serviceInfos")
    end
  end
end


