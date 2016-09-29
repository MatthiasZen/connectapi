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
        @is_locked = ovh.get("/domain/#{domain_name}")
        #@unlocked = ovh.put("/domain/#{domain_name}", transferLockStatus='locked')


      else
        flash[:alert] = "Le nom de domaine n'existe pas ou doit être au format ndd.fr ou ndd.com"
        redirect_to root_path
    end
  end

  def update
    ovh = OVH::REST.new(ENV["apiKey"], ENV["appSecret"], ENV["consumerKey"])
    all_domain = ovh.get("/domain/")
    # rendre les params du nom de domaine
    domain_name = params["ndd"]
    raise
  end
end

#faire une méthode pour appeler l'API ovh avec un before action

#vh.put("/domain/#{domain_name}", {"transferLockStatus"=>'locked'})

