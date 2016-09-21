class PagesController < ApplicationController
  def index

  end

  def show
    domain_name = params["ndd"]
    if domain_name.match(/[a-zA-Z]+[.]+(com|fr|be)/)

        time = Time.new()
        timestemp = time.to_i

        #calling the OVH REST gem

        ovh = OVH::REST.new(ENV["apiKey"], ENV["appSecret"], ENV["consumerKey"])

        # Get account status

        @resultat = ovh.get("/domain/#{domain_name}/serviceInfos")

      else
        flash[:alert] = "Le nom de domaine doit être au format ndd.fr ou ndd.com"
        redirect_to root_path
    end
  end
end




