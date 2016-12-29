class GandiApiController < ApplicationController

  def index
    api = Gandi::Session.new(ENV["GandiapiKey"])
    @status_of_operation = api.operation.list({'type': 'domain_transfer_in'})
  end

  def show
  end

  def update
    api = Gandi::Session.new(ENV["GandiapiKey"]) # Endpoint: https://rpc.gandi.net/xmlrpc/

    ndd = params['ndd']
    authcode = params['auth'].gsub(/["]/, '')

    api.domain.transferin.available(ndd, authcode) #transférer le NDD name to this controller ,'X2pNNIqKdBTL'


    # thi method if to create a contact but in teh test env whe still have 50 contacts
     #contact_spec = {
    #'city' => 'Paris',
    #'country' => 'FR',
    #'email' => 'jmatthias@zenchef.com',
    #'family' => 'Vitte',
    #'given' => 'Matthias',
    #'password' => '0000000',
    #'phone' => '0688833732',
    #'streetaddr' => '120 rue Reaumur 75002',
    #'type' => 0,
    #'zip'=> "75002",
    #}


    #api.contact.create(contact_spec)

    association_spec = {
      'domain' => ndd,
    }

    api.contact.can_associate_domain('JB18182-GANDI', association_spec)

    transfer_spec = {
    'owner' => 'JB18182-GANDI',
    'admin' => 'JB18182-GANDI',
    'tech' => 'JB18182-GANDI',
    'bill' => 'JB18182-GANDI',
    'authinfo' => authcode,
    }



    api.domain.transferin.proceed(ndd, transfer_spec)


    #api.operation
    #api.operation.info(oper_id)

    redirect_to 'index'

  end

end
