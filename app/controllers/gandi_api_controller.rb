class GandiApiController < ApplicationController
  def index

    api = Gandi::Session.new(ENV["GandiapiKey"], env: :test) # Endpoint: https://rpc.gandi.net/xmlrpc/

    api.domain.transferin.available('mobicafe.fr') #transférer le NDD name to this controller

     #midifier les infos ci-dessous pour voir si le transfert fonctionne

     contact_spec = {
    'city' => 'Paris',
    'country' => 'FR',
    'email' => 'matthias@zenchef.com',
    'family' => 'Vitte',
    'given' => 'Matthias',
    'password' => '0000000',
    'phone' => '0688833732',
    'streetaddr' => '120 rue Reaumur',
    'type' => 0,

  }


      api.contact.create(contact_spec)

      api.contact.can_associate_domain('MV22-GANDI', contact_spec)

    transfer_spec = {
    'owner' => 'MV22-GANDI',
    'admin' => 'MV22-GANDI',
    'tech' => 'MV22-GANDI',
    'bill' => 'MV22-GANDI',
    'nameservers' => ['a.dns.gandi.net', 'b.dns.gandi.net', 'c.dns.gandi.net'],
    'authinfo' => 'X2pNNIqKdBTL',
    'duration' => 1}

    api.domain.transferin.proceed('mobicafe.fr', transfer_spec) #le statut du code d'autorisation est en pending api.domain.available(['mobicafe.fr'])

    api.operation.info(oper_id)

  end

  def show
  end
end
