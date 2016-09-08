class PagesController < ApplicationController
  def index
    time = Time.new()
    timestemp = time.to_i

    #calling the OVH REST gem

    ovh = OVH::REST.new("6x6sBHG1IyuyPRup", "zJ32TthBnOPsONVjK3E3ZV65qYkYvNBF", "r9vi6k8l6fffAbeVV7fwhU6N0WcrzXCc")

    # Get sms account status

result = ovh.get("/auth/currentCredential")


@resultat = JSON.pretty_generate(result)

  end
end


