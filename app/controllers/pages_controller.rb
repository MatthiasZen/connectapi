class PagesController < ApplicationController

  def index
  end

  def show

    domain_name = params["ndd"]

    #calling the OVH REST gem

    ovh = OVH::REST.new(ENV["apiKey"], ENV["appSecret"], ENV["consumerKey"])

    #checking if the domian_name is on ovh
    all_domain = ovh.get("/domain/").first
   if all_domain.include?(domain_name)

        # Get account status

        @resultat = ovh.get("/domain/#{domain_name}/serviceInfos")

        if ovh.get("/domain/#{domain_name}").first.include?('unlocked')
         redirect_to update
        else
          @is_locked = ovh.get("/domain/#{domain_name}")
          JSON.pretty_generate(@is_locked)
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
    render action: update
  end

  def update
    ovh = OVH::REST.new(ENV["apiKey"], ENV["appSecret"], ENV["consumerKey"])
    domain_name = params["ndd"]
    @auth = ovh.get("/domain/#{domain_name}/authInfo")
    JSON.pretty_generate(@auth)


    #puts JSON.pretty_generate(result)
    #appeler à nouveau l'api ovh (aucune méthode ne focntionne pour ces appels)
    #afficher le code auth
  end
end



