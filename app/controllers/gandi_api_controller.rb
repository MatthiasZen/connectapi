class GandiApiController < ApplicationController
  def index

    api = Gandi::Session.new(ENV["GandiapiKey"], env: :test) # Endpoint: https://rpc.gandi.net/xmlrpc/
    api.domain.list
    raise
  end

  def show
  end
end
