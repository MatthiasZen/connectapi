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

        resultat = ovh.get("/domain/#{domain_name}/serviceInfos")
        @resultat = JSON.parse  resultat.first.gsub('=>', ':')

        if ovh.get("/domain/#{domain_name}").first.include?('unlocked')
         redirect_to edit
        else
          is_locked = ovh.get("/domain/#{domain_name}")
          @is_locked = JSON.parse  is_locked.first.gsub('=>', ':')
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
    ovh.put("/domain/#{domain_name}", {"transferLockStatus"=>'unlocked', "type" => "text"})
    @is_unlocked = ovh.get("/domain/#{domain_name}")
    @auth = ovh.get("/domain/#{domain_name}/authInfo")
    #JSON.pretty_generate(@auth)

  end

  def update
    #ovh = OVH::REST.new(ENV["apiKey"], ENV["appSecret"], ENV["consumerKey"])
    #domain_name = params["ndd"]
    #@auth = ovh.get("/domain/#{domain_name}/authInfo")
    #JSON.pretty_generate(@auth)


    #puts JSON.pretty_generate(result)
    #appeler à nouveau l'api ovh (aucune méthode ne focntionne pour ces appels)
    #afficher le code auth
  end
end



