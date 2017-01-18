class GandiApiController < ApplicationController

  def index
    api = Gandi::Session.new(ENV["GandiapiKey"])

    ndd = params['ndd_in_process']

    @status_of_operation = api.operation.list({'domain': ndd, 'type': 'domain_transfer_in'})

  end

  def show
  end

  def update
    api = Gandi::Session.new(ENV["GandiapiKey"]) # Endpoint: https://rpc.gandi.net/xmlrpc/

    ndd = params['ndd']
    authcode = params['auth'].gsub(/["]/, '')

    api.domain.transferin.available(ndd, authcode) #transférer le NDD name to this controller ,'X2pNNIqKdBTL'

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

    api.operation.list({'domain': ndd, 'type': 'domain_transfer_in'})
    #api.operation
   operation_id = api.operation.list({'domain': ndd, 'type': 'domain_transfer_in'}).last.step

    redirect_to 'index'

  end

end
