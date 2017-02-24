class PagesController < ApplicationController


  def index
    #root
  end

  def expire

    ovh = OVH::REST.new(ENV["apiKey"], ENV["appSecret"], ENV["consumerKey"])
    all_domain = ovh.get("/domain/").first(100)
    @all_domain_count = all_domain.count
    @arry = all_domain.map { |arr| ovh.get("/domain/#{arr}/serviceInfos")}

  end

  def show

    domain_name = params["ndd"]

    #calling the OVH REST gem

    ovh = OVH::REST.new(ENV["apiKey"], ENV["appSecret"], ENV["consumerKey"])

    #calling the Gandi API

    api = Gandi::Session.new(ENV["GandiapiKey"])

    #checking if the domian_name is on ovh
    all_domain = ovh.get("/domain/")
   if all_domain.include?(domain_name)

        # Get account status

        @resultat = ovh.get("/domain/#{domain_name}/serviceInfos")

        #Get the email associated to the acocunt
        @email = ovh.get("/email/domain/#{domain_name}/account").first

        #Get the alias redirection
        @get_alias_id = ovh.get("/email/domain/#{domain_name}/redirection")
        @get_alias_id.each do |a|
           @alias = ovh.get("/email/domain/#{domain_name}/redirection/#{a}")
        end

        #get the auth code
        if ovh.get("/domain/#{domain_name}")["transferLockStatus"] == "unlocked"
            @auth = ovh.get("/domain/#{domain_name}/authInfo", nil, "text")
            @gandi_operation_running = api.operation.list({'domain': domain_name, 'type': 'domain_transfer_in'})
          elsif ovh.get("/domain/#{domain_name}")["transferLockStatus"] == "unlocking"
            @is_unlocking = "Le nom de domaine est en train de se déverouiller"
          else
            @is_locked = ovh.get("/domain/#{domain_name}")["transferLockStatus"]
        end

      else
        flash[:alert] = "Le nom de domaine n'existe pas ou n'est pas au format ndd.fr ou ndd.com"
        redirect_to root_path
    end
  end

  def edit
    domain_name = params["ndd"]
    ovh = OVH::REST.new(ENV["apiKey"], ENV["appSecret"], ENV["consumerKey"])
    ovh.put("/domain/#{domain_name}", {"transferLockStatus"=>'unlocked'})
    while ovh.get("/domain/#{domain_name}/authInfo", nil, "text") == "{\"message\":\"Your domain is being unlocked, please wait...\"}"
      sleep(5)
    end
    redirect_to 'show'
  end

  def update
  end

end



