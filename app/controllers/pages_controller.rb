class PagesController < ApplicationController
  def index
    time = Time.new()
    timestemp = time.to_i

    #calling the OVH REST gem

    ovh = OVH::REST.new("60A5LSieS4KVAn4R", "XgF3lQeuga8S790Cy16NjU4spLFyha7y", "2wlviFYogCFvNfke41WnJE0lhx8Izk1a")

    # Get sms account status

result = ovh.get("/auth/currentCredential")


@resultat = JSON.pretty_generate(result)

  end
end


