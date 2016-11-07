class GandiApiController < ApplicationController
  def index

    api = Gandi::Session.new(ENV["GandiapiKey"], env: :test) # Endpoint: https://rpc.gandi.net/xmlrpc/
    api.domain.list
    api.domain.transferin.available('mobicafe.fr') #transférer le NDD name to this controller

     #midifier les infos ci-dessous pour voir si le transfert fonctionne

     contact_spec = {
    'city' => 'Paris',
    'country' => 'FR',
    'email' => 'julien@zenchef.com',
    'family' => 'Balmont',
    'given' => 'Julien',
    'password' => '0000000',
    'phone' => '0688833732',
    'streetaddr' => '120 rue Reaumur',
    'type' => 1,
    'orgname' => "SAS Zenchef"

  }


      api.contact.create(contact_spec)

      api.contact.can_associate_domain('JB18182-GANDI', contact_spec) # the solution can be here => https://wiki.gandi.net/en/contacts/create

      raise
    transfer_spec = {
    'owner' => 'JB18182-GANDI',
    'admin' => 'JB18182-GANDI',
    'tech' => 'JB18182-GANDI',
    'bill' => 'JB18182-GANDI',
    'nameservers' => ['a.dns.gandi.net', 'b.dns.gandi.net', 'c.dns.gandi.net'],
    'authinfo' => 'X2pNNIqKdBTL',
    'duration' => 1}

    api.domain.transferin.proceed('mobicafe.fr', transfer_spec)
    api.operation.info(oper_id)

  end

  def show
  end
end
