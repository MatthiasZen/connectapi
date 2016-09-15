class PagesController < ApplicationController
  def index

  end

  def show
    domain_name = params["ndd"]
    time = Time.new()
    timestemp = time.to_i

    #calling the OVH REST gem

    ovh = OVH::REST.new("6x6sBHG1IyuyPRup", "zJ32TthBnOPsONVjK3E3ZV65qYkYvNBF", "r9vi6k8l6fffAbeVV7fwhU6N0WcrzXCc")

    # Get account status

    @resultat = ovh.get("/domain/#{domain_name}/serviceInfos")

  end
end


