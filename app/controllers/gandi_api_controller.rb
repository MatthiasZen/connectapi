class GandiApiController < ApplicationController

  def index
    @ndd_transfered_status = Ndd.all
  end

  def show
    api = Gandi::Session.new(ENV["GandiapiKey"])
    domain_name = params['ndd_in_process']
    @status_of_operation = api.operation.list({'domain': domain_name, 'type': 'domain_transfer_in'})
  end

  def update
    api = Gandi::Session.new(ENV["GandiapiKey"])
    ndd = params['ndd']
    ndd_in_db = Ndd.new(name: ndd)
    ndd_in_db.save

    authcode = params['auth'].gsub(/["]/, '')

    api.domain.transferin.available(ndd, authcode)

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

    redirect_to 'index'

  end

end
