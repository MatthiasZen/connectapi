class GandiApiController < ApplicationController

  def index
    api = Gandi::Session.new(ENV["GandiapiKey"], env: :test)
    @status_of_operation = api.operation.list({'type': 'domain_transfer_in'})
  end

  def show
  end

  def update
    api = Gandi::Session.new(ENV["GandiapiKey"], env: :test) # Endpoint: https://rpc.gandi.net/xmlrpc/

    ndd = params['ndd']
    authcode = params['auth'].gsub(/["]/, '')

    api.domain.transferin.available(ndd, authinfo =  authcode) #transférer le NDD name to this controller ,'X2pNNIqKdBTL'



     contact_spec = {
    'city' => 'Paris',
    'country' => 'FR',
    'email' => 'jmatthias@zenchef.com',
    'family' => 'Vitte',
    'given' => 'Matthias',
    'password' => '0000000',
    'phone' => '0688833732',
    'streetaddr' => '120 rue Reaumur 75002',
    'type' => 0,
    'zip'=> "75002",
    }


      api.contact.create(contact_spec)



    api.contact.can_associate_domain('MV44-GANDI', contact_spec)

    transfer_spec = {
    'owner' => 'MV44-GANDI',
    'admin' => 'MV44-GANDI',
    'tech' => 'MV44-GANDI',
    'bill' => 'MV44-GANDI',
    }


    api.domain.transferin.proceed(ndd, transfer_spec)

    api.operation.info(oper_id)

  end

end
