class GandiApiController < ApplicationController
  def index

    api = Gandi::Session.new(ENV["GandiapiKey"], env: :test) # Endpoint: https://rpc.gandi.net/xmlrpc/
    api.domain.list
    api.domain.transferin.available('mobicafe.fr') #transférer le NDD name to this controller

     #midifier les infos ci-dessous pour voir si le transfert fonctionne
    transfer_spec = {
    'owner' => 'FLN123-GANDI',
    'admin' => 'FLN123-GANDI',
    'tech' => 'FLN123-GANDI',
    'bill' => 'FLN123-GANDI',
    'nameservers' => ['a.dns.gandi.net', 'b.dns.gandi.net', 'c.dns.gandi.net'],
    'authinfo' => 'xxx',
    'duration' => 1}

    api.domain.transferin.proceed('mobicafe.fr', transfer_spec)
    api.operation.info(oper_id)
    raise
  end

  def show
  end
end
