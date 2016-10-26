class PagesController < ApplicationController

  def index
  end

  def show

    domain_name = params["ndd"]

    #calling the OVH REST gem

    ovh = OVH::REST.new(ENV["apiKey"], ENV["appSecret"], ENV["consumerKey"])

    #checking if the domian_name is on ovh
    all_domain = ovh.get("/domain/")
   if all_domain.include?(domain_name)

        # Get account status

        @resultat = ovh.get("/domain/#{domain_name}/serviceInfos")

        if ovh.get("/domain/#{domain_name}")["transferLockStatus"] == "unlocked"
         @auth = ovh.get("/domain/#{domain_name}/authInfo", nil, "text")
        else
          @is_locked = "le nom de domaine est verrouillé"
        end

      else
        flash[:alert] = "Le nom de domaine n'existe pas ou doit être au format ndd.fr ou ndd.com"
        redirect_to root_path
    end
  end

  def edit
    domain_name = params["ndd"]
    ovh = OVH::REST.new(ENV["apiKey"], ENV["appSecret"], ENV["consumerKey"])
    ovh.put("/domain/#{domain_name}", {"transferLockStatus"=>'unlocked'})
    @is_unlocked = ovh.get("/domain/#{domain_name}")
    #@auth = ovh.get("/domain/#{domain_name}/authInfo", nil, "text")
    raise
  end

  def update

  end
end



